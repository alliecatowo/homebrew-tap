class Shoal < Formula
  desc "Structured, typed, sandbox-aware shell"
  homepage "https://github.com/alliecatowo/shoal"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.5/shoal-v0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "be15dc6dfcc05ccc0a1bed81ae835b2715d8555eb8b0c7396daa77278a8de847"
    end
    on_intel do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.5/shoal-v0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "c73dac10814515347ece5794135ca6033fe8a1d4f704e2582cbe2dde38a63956"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.5/shoal-v0.1.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "23fe0895075d7cd8ff9301db26b943e5df69f2e6130747a28dd33741483b6b93"
    end
    on_intel do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.5/shoal-v0.1.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "046bfb2442ea2746935c86f010d9393a0267733a23012cb8ab1d3b9775f2f757"
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
