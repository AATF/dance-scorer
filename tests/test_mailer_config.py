import os
import unittest

class TestMailerConfig(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
        cls.prod_config = os.path.join(cls.repo_root, "src", "config", "environments", "production.rb")
        cls.dev_config = os.path.join(cls.repo_root, "src", "config", "environments", "development.rb")
        cls.test_config = os.path.join(cls.repo_root, "src", "config", "environments", "test.rb")

    def test_production_mailer_default_url_options(self):
        with open(self.prod_config, "r", encoding="utf-8") as f:
            content = f.read()
        self.assertIn("config.action_mailer.default_url_options", content)
        self.assertIn("APP_HOST", content)

    def test_development_mailer_default_url_options(self):
        with open(self.dev_config, "r", encoding="utf-8") as f:
            content = f.read()
        self.assertIn("config.action_mailer.default_url_options", content)
        self.assertIn("host", content)

    def test_test_mailer_default_url_options(self):
        with open(self.test_config, "r", encoding="utf-8") as f:
            content = f.read()
        self.assertIn("config.action_mailer.default_url_options", content)
        self.assertIn("host", content)

if __name__ == "__main__":
    unittest.main()

