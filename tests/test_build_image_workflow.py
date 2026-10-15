import os
import subprocess
import unittest
import yaml

class TestBuildImageWorkflow(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
        cls.workflow_path = os.path.join(cls.repo_root, ".github", "workflows", "build-image.yaml")
        cls.makefile_path = os.path.join(cls.repo_root, "makefile")

        with open(cls.workflow_path, "r", encoding="utf-8") as f:
            cls.workflow = yaml.safe_load(f)

    def test_workflow_metadata(self):
        self.assertEqual(self.workflow.get("name"), "build image")
        on_triggers = self.workflow.get(True) or self.workflow.get("on", {})
        self.assertIn("push", on_triggers)
        self.assertIn("workflow_dispatch", on_triggers)
        self.assertIn("workflow_call", on_triggers)

    def test_build_job_matrix_and_runners(self):
        jobs = self.workflow.get("jobs", {})
        self.assertIn("build", jobs)
        build_job = jobs["build"]

        self.assertEqual(build_job.get("runs-on"), "${{ matrix.runner }}")

        matrix_include = build_job.get("strategy", {}).get("matrix", {}).get("include", [])
        self.assertEqual(len(matrix_include), 2)

        amd64_entry = next((item for item in matrix_include if item.get("arch") == "amd64"), None)
        self.assertIsNotNone(amd64_entry)
        self.assertEqual(amd64_entry.get("platform"), "linux/amd64")
        self.assertEqual(amd64_entry.get("runner"), "ubuntu-latest")

        arm64_entry = next((item for item in matrix_include if item.get("arch") == "arm64"), None)
        self.assertIsNotNone(arm64_entry)
        self.assertEqual(arm64_entry.get("platform"), "linux/arm64")
        self.assertEqual(arm64_entry.get("runner"), "ubuntu-24.04-arm")

    def test_build_job_steps(self):
        build_job = self.workflow["jobs"]["build"]
        steps = build_job.get("steps", [])
        step_runs = [s.get("run", "") for s in steps if "run" in s]
        self.assertTrue(any("make upload-arch" in r for r in step_runs))

    def test_manifest_job(self):
        jobs = self.workflow.get("jobs", {})
        self.assertIn("manifest", jobs)
        manifest_job = jobs["manifest"]

        self.assertEqual(manifest_job.get("needs"), "build")
        self.assertEqual(manifest_job.get("runs-on"), "ubuntu-latest")

        steps = manifest_job.get("steps", [])
        step_runs = [s.get("run", "") for s in steps if "run" in s]
        self.assertTrue(any("make manifest" in r for r in step_runs))

    def test_makefile_dry_run_upload_arch(self):
        # AMD64
        cmd_amd64 = ["make", "-n", "upload-arch", "PLATFORM=linux/amd64", "ARCH=amd64"]
        res_amd64 = subprocess.run(cmd_amd64, cwd=self.repo_root, capture_output=True, text=True, check=True)
        self.assertIn("--platform linux/amd64", res_amd64.stdout)
        self.assertIn("-amd64", res_amd64.stdout)

        # ARM64
        cmd_arm64 = ["make", "-n", "upload-arch", "PLATFORM=linux/arm64", "ARCH=arm64"]
        res_arm64 = subprocess.run(cmd_arm64, cwd=self.repo_root, capture_output=True, text=True, check=True)
        self.assertIn("--platform linux/arm64", res_arm64.stdout)
        self.assertIn("-arm64", res_arm64.stdout)

    def test_makefile_dry_run_manifest(self):
        cmd = ["make", "-n", "manifest"]
        res = subprocess.run(cmd, cwd=self.repo_root, capture_output=True, text=True, check=True)
        self.assertIn("docker buildx imagetools create", res.stdout)
        self.assertIn("-amd64", res.stdout)
        self.assertIn("-arm64", res.stdout)

if __name__ == "__main__":
    unittest.main()
