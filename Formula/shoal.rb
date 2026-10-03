class Shoal < Formula
  desc "Structured, typed, sandbox-aware shell"
  homepage "https://github.com/alliecatowo/shoal"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.3/shoal-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "6bafcbcb06188f99951a3846ac74e62df2ce88e3b3643ddad84b49a4dcac360b"
    end
    on_intel do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.3/shoal-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "ab68416b4e59295918b83930a1fdd4bc06b3b69e9550fa821e34a17b89010d65"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.3/shoal-v0.1.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "64e770bdcf96f5bbd07ba9ffff83320ee1af9c735a1659f85ec0703c9cc5a232"
    end
    on_intel do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.1.3/shoal-v0.1.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1e98b001ac005061f8f32d0f87e3e39384bf3af508a6f18b3bd1bb3d5670aee9"
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
