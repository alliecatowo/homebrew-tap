class Shoal < Formula
  desc "Structured, typed, sandbox-aware shell"
  homepage "https://github.com/alliecatowo/shoal"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.1/shoal-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "00ff2ddc4290930b0f774aeccb507b6b26ee4a703739d3ff05b3a24cc500f58b"
    end
    on_intel do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.1/shoal-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "6b9e2406bd9f0bd29208c7f315983e33abdd5cd92413ba645a6c47479151a053"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.1/shoal-v0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e7d6dbd711f0f3e7fb1d9ba480a1980c011cb2f643458128840751434e9915af"
    end
    on_intel do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.1/shoal-v0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3fce93b6a0af6f8c542f535f8b5dcb360b26ef3e292b1559c5a04fb4f8f81228"
    end
  end

  def install
    # The archive holds one directory of prebuilt executables plus docs.
    bin.install Dir["shoal*"].select { |f| File.file?(f) && File.executable?(f) }
    doc.install "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/shoal --version")
  end
end
