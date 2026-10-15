import os
import unittest

class TestFooterVersion(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
        cls.version_file = os.path.join(cls.repo_root, "VERSION")
        cls.layout_file = os.path.join(cls.repo_root, "src", "app", "views", "layouts", "application.html.erb")
        cls.helper_file = os.path.join(cls.repo_root, "src", "app", "helpers", "application_helper.rb")
        cls.makefile_path = os.path.join(cls.repo_root, "makefile")

    def test_version_file_exists_and_non_empty(self):
        self.assertTrue(os.path.isfile(self.version_file), "VERSION file must exist at repo root")
        with open(self.version_file, "r", encoding="utf-8") as f:
            content = f.read().strip()
        self.assertTrue(len(content) > 0, "VERSION file must not be empty")

    def test_layout_contains_footer_and_prints_version(self):
        self.assertTrue(os.path.isfile(self.layout_file), "Base layout file must exist")
        with open(self.layout_file, "r", encoding="utf-8") as f:
            content = f.read()
        self.assertIn("<footer", content, "Base template must contain a footer tag")
        self.assertIn("app_version", content, "Footer must print app_version")

    def test_helper_defines_app_version(self):
        self.assertTrue(os.path.isfile(self.helper_file), "application_helper.rb must exist")
        with open(self.helper_file, "r", encoding="utf-8") as f:
            content = f.read()
        self.assertIn("def app_version", content, "application_helper.rb must define app_version method")
        self.assertIn("VERSION", content, "app_version must read from VERSION file")

    def test_makefile_mounts_version_in_test_target(self):
        with open(self.makefile_path, "r", encoding="utf-8") as f:
            content = f.read()
        self.assertIn("VERSION:", content, "makefile test target should mount VERSION into container")

if __name__ == "__main__":
    unittest.main()
