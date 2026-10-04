# Homebrew formula for rssd, a Python CLI published to PyPI as rssd-fs.
# Installs the PyPI release into a private uv-managed virtualenv with the
# optional TUI extra, and links both binaries (rssd, the daemon, and rss, the reader).
# url and sha256 are bumped by rssd's release workflow.
class Rssd < Formula
  desc "File-based RSS daemon: the filesystem is the API"
  homepage "https://github.com/alliecatowo/rssd"
  url "https://files.pythonhosted.org/packages/61/6a/83669dd0a93e72a91dd9ba7a200a9097b709970b608292f4dc4e4e6c4a6a/rssd_fs-0.3.0.tar.gz"
  sha256 "1ced62c71f79176131b881ae7b36a607eb452965db0d8c28edcb17653be33d88"
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
