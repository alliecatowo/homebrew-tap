# Homebrew formula for rssd, a Python CLI published to PyPI as rssd-fs.
# Installs the PyPI release into a private uv-managed virtualenv with the
# optional TUI extra, and links both binaries (rssd, the daemon, and rss, the reader).
# Bump url and sha256 by hand after each PyPI release (no release job pushes here yet).
class Rssd < Formula
  desc "File-based RSS daemon: the filesystem is the API"
  homepage "https://github.com/alliecatowo/rssd"
  url "https://files.pythonhosted.org/packages/88/b3/bd56d358c61b0f278789ab7499897985babdde16f9edf8b05b41dd66e4e0/rssd_fs-0.2.1.tar.gz"
  sha256 "f1049a64c9d2facbdda1c1475ebb2d79ecd4fc37b7407a6c2bd3acde40d5ee4a"
  license "MIT"

  depends_on "uv" => :build
  depends_on "python@3.14"

  def install
    python = formula_opt_bin("python@3.14")/"python3.14"
    ENV["UV_PYTHON_DOWNLOADS"] = "never"
    system "uv", "venv", "--python", python, libexec
    system "uv", "pip", "install", "--python", libexec/"bin/python", "#{buildpath}[tui]"
    bin.install_symlink libexec/"bin/rssd", libexec/"bin/rss"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rssd --version")
    assert_match "usage", shell_output("#{bin}/rss --help").downcase
  end
end
