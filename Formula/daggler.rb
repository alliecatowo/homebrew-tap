# Homebrew formula for daggler, a GitHub Actions workflow linter and graph tool
# published to npm as daggler-cli. Bump url and sha256 by hand after each npm release.
class Daggler < Formula
  desc "Semantic workbench for GitHub Actions: graph, validate and secure workflows"
  homepage "https://github.com/alliecatowo/daggler"
  url "https://registry.npmjs.org/daggler-cli/-/daggler-cli-0.1.0.tgz"
  sha256 "5b30d70fee041cb8c3a5fe111333db8d63dcfd1ca856f192b02fc20d6d8ae579"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/daggler --version")
  end
end
