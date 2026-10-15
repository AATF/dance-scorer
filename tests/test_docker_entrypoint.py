import os
import subprocess
import unittest

class TestDockerEntrypoint(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
        cls.entrypoint_path = os.path.join(cls.repo_root, "src", "bin", "docker-entrypoint")
        cls.dockerfile_path = os.path.join(cls.repo_root, "docker", "Dockerfile")

    def test_entrypoint_file_exists_and_executable(self):
        self.assertTrue(os.path.isfile(self.entrypoint_path), "docker-entrypoint file must exist")
        self.assertTrue(os.access(self.entrypoint_path, os.X_OK), "docker-entrypoint must be executable")

    def test_entrypoint_syntax_valid(self):
        res = subprocess.run(["bash", "-n", self.entrypoint_path], capture_output=True, text=True)
        self.assertEqual(res.returncode, 0, f"docker-entrypoint has syntax errors: {res.stderr}")

    def test_entrypoint_content(self):
        with open(self.entrypoint_path, "r", encoding="utf-8") as f:
            content = f.read()
        self.assertTrue(content.startswith("#!/bin/bash"), "Shebang must be #!/bin/bash")
        self.assertIn("set -e", content, "Script must have set -e")
        self.assertIn("./bin/rails db:prepare", content, "Script must call db:prepare")
        self.assertTrue(content.strip().endswith('exec "${@}"') or content.strip().endswith('exec "$@"'), "Script must exec arguments")

    def test_entrypoint_delegates_non_server_commands(self):
        res = subprocess.run([self.entrypoint_path, "echo", "test-pass"], capture_output=True, text=True)
        self.assertEqual(res.returncode, 0)
        self.assertEqual(res.stdout.strip(), "test-pass")

    def test_dockerfile_config(self):
        with open(self.dockerfile_path, "r", encoding="utf-8") as f:
            content = f.read()
        self.assertIn('ENTRYPOINT ["/rails/bin/docker-entrypoint"]', content)
        self.assertIn('CMD ["./bin/rails", "server"]', content)

if __name__ == "__main__":
    unittest.main()

