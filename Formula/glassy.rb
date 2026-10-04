# Homebrew formula template for glassy, a fast GPU-accelerated terminal emulator.
# Users install it from the shared tap:
#   brew install alliecatowo/tap/glassy          # latest tagged release
#   brew install --HEAD alliecatowo/tap/glassy   # build from main (requires Rust)
#
# This is a TEMPLATE. The update-homebrew job in .github/workflows/release.yml
# renders it (version + sha256 sentinels) into Formula/glassy.rb of
# alliecatowo/homebrew-tap on every release. Edit this file, not the tap copy:
# edits there get overwritten on the next release. Rendering fresh from an
# untouched template every time avoids the old sed-in-place trap, where the
# sentinels were consumed on the first run and later releases silently stopped
# updating.
#
# On macOS, stable installs fetch the prebuilt per-arch binary that
# build-macos already uploads as a release asset (glassy-aarch64-macos /
# glassy-x86_64-macos) instead of compiling from source — `cargo install`
# here took several minutes (lto = "fat" + codegen-units = 1 in Cargo.toml),
# while downloading an already-built binary takes seconds. Linux x86_64 does
# the same with glassy-x86_64-linux. Linux arm64 has no prebuilt asset yet and
# builds from the top-level source tarball. `--HEAD` always builds from source
# on any OS, since there's no prebuilt asset for an arbitrary main commit.
class Glassy < Formula
  desc "Fast, minimal GPU-accelerated terminal emulator written in Rust"
  homepage "https://github.com/alliecatowo/glassy"
  url "https://github.com/alliecatowo/glassy/releases/download/v0.6.2/glassy-0.6.2-src.tar.gz"
  sha256 "1c92a9f633393130c97a4a929bf885cd7e6eb86396a7843a95fe216f0bbe0443"
  license "MIT"

  head do
    url "https://github.com/alliecatowo/glassy.git", branch: "main"
    depends_on "pkg-config" => :build
    depends_on "rust" => :build
  end

  # Override: swap the default source tarball for a prebuilt binary on macOS
  # and Linux x86_64. Homebrew resolves on_arm/on_intel against the host's
  # arch, so those installs never touch the url/sha256 above.
  on_macos do
    on_arm do
      url "https://github.com/alliecatowo/glassy/releases/download/v0.6.2/glassy-aarch64-macos"
      sha256 "0e0fb5868d0935633323009c3449b98993598dfa066960fdcaa8f82855aecf8e"
    end
    on_intel do
      url "https://github.com/alliecatowo/glassy/releases/download/v0.6.2/glassy-x86_64-macos"
      sha256 "425716df17955b6705b607b039fce55f3381cd8f481d4c99a9f8d5def813d74e"
    end
  end

  on_linux do
    depends_on "dbus"
    depends_on "fontconfig"

    on_intel do
      url "https://github.com/alliecatowo/glassy/releases/download/v0.6.2/glassy-x86_64-linux"
      sha256 "0da00374d8dba97a4b25e1a5711ab3f659529e06c77b4cd63f4456e1b477c00b"
    end

    # No prebuilt arm64 Linux binary: build from the source tarball.
    on_arm do
      depends_on "pkg-config" => :build
      depends_on "rust" => :build
    end
  end

  def install
    if !build.head? && (OS.mac? || Hardware::CPU.intel?)
      # Downloaded as a bare (non-archived) binary named glassy-<arch>-<os>;
      # GitHub release assets carry no exec bit, hence the explicit chmod.
      bin.install Dir["glassy-*-{macos,linux}"].first => "glassy"
      chmod 0755, bin/"glassy"
    else
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/glassy --version 2>&1")
  end
end
