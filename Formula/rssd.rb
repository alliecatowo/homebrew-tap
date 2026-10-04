# Homebrew formula for rssd, a Python CLI published to PyPI as rssd-fs.
# Installs the PyPI release into a private uv-managed virtualenv with the
# optional TUI extra, and links both binaries (rssd, the daemon, and rss, the reader).
# url and sha256 are bumped by rssd's release workflow.
class Rssd < Formula
  desc "File-based RSS daemon: the filesystem is the API"
  homepage "https://github.com/alliecatowo/rssd"
  url "https://files.pythonhosted.org/packages/c5/0f/0fcd4e8bef543e142fa0e60bc4a8694cccbd5b4f74329e142fb72e20b315/rssd_fs-0.2.2.tar.gz"
  sha256 "5c728df751c72684c7deede5d030ef0c6ba758a0b213e8946dc15f18b4e1d81a"
  license "MIT"

  depends_on "python@3.14"
  depends_on "uv"

  # The virtualenv is built in post_install, not install: its prebuilt wheels
  # include Rust extensions (watchfiles) that Homebrew cannot relink on macOS.
  def install
    %w[rssd rss].each do |name|
      (bin/name).write <<~SH
        #!/bin/sh
        exec "#{opt_libexec}/venv/bin/#{name}" "$@"
      SH
    end
  end

  def post_install
    python = formula_opt_bin("python@3.14")/"python3.14"
    ENV["UV_PYTHON_DOWNLOADS"] = "never"
    system "uv", "venv", "--python", python, libexec/"venv"
    system "uv", "pip", "install", "--python", libexec/"venv/bin/python", "rssd-fs[tui]==#{version}"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rssd --version")
    assert_match "usage", shell_output("#{bin}/rss --help").downcase
  end
end
