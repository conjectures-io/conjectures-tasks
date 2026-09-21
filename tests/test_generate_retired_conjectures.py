import importlib.util
import json
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

spec = importlib.util.spec_from_file_location(
    'retired_generator', Path(__file__).resolve().parents[1] / 'scripts/generate_retired_conjectures.py'
)
generator = importlib.util.module_from_spec(spec)
spec.loader.exec_module(generator)


class ReinstatementTests(unittest.TestCase):
    def build(self, active, log, deleted='Erdos96.erdos_96'):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'allowlist.json').write_text(json.dumps({
                'repository_commit': 'a' * 40,
                'allowed_source_theorems': [{'theorem': name} for name in active],
            }))
            with (
                patch.object(generator, 'TASKS_ROOT', root),
                patch.object(generator, 'retirement_log', return_value=log),
                patch.object(generator, 'deleted_bundles', return_value={'old-directory': 'b' * 40}),
                patch.object(generator, 'bundle_before', return_value={
                    'manifest': {'source_theorem': deleted}
                }),
            ):
                return generator.build()

    def test_explicit_reinstatement_omits_historical_deletion(self):
        self.assertEqual(self.build(['Erdos96.erdos_96'], {})['retired'], [])

    def test_unexplained_deletion_still_fails(self):
        with self.assertRaisesRegex(generator.GeneratorError, 'not in RETIREMENTS'):
            self.build([], {})

    def test_simultaneously_active_and_retired_fails(self):
        with self.assertRaisesRegex(generator.GeneratorError, 'still in RETIREMENTS'):
            self.build(['Erdos96.erdos_96'], {'Erdos96.erdos_96': {}})


if __name__ == '__main__':
    unittest.main()
