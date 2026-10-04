class Shoal < Formula
  desc "Structured, typed, sandbox-aware shell"
  homepage "https://github.com/alliecatowo/shoal"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.4/shoal-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "55a989ba46ad8a152598510366fc52f5976bb290f6b74be7e07f923077ba565d"
    end
    on_intel do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.4/shoal-v0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "6e2f9a5eca5c2d9c17134853f3110d293ea70ee7111d37a6d99ba2d9f6fd60bf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.4/shoal-v0.1.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e848f555dd48c4bcbb4f45a4d3f976621751a1847113a81f87267dec7be7f4d7"
    end
    on_intel do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.4/shoal-v0.1.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d1e49be4eb6ff67e56c1905c247946860106fa6384ba772103eae60ddb39af48"
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
