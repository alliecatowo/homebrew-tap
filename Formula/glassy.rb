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
  url "https://github.com/alliecatowo/glassy/releases/download/v0.6.1/glassy-0.6.1-src.tar.gz"
  sha256 "2b58d0ffcc0690965840b29f1f4b31357d7e9e00ccc42c2934368e807256ca6c"
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
      url "https://github.com/alliecatowo/glassy/releases/download/v0.6.1/glassy-aarch64-macos"
      sha256 "23b24450b97e49cac78bd4abb66566f5a78b0a8f9c65e95db690a4ea9b51398b"
    end
    on_intel do
      url "https://github.com/alliecatowo/glassy/releases/download/v0.6.1/glassy-x86_64-macos"
      sha256 "db74004f18624503e495035767479d42cdef74dbcfd8fecba4bffb97ba001da4"
    end
  end

  on_linux do
    depends_on "dbus"
    depends_on "fontconfig"

    on_intel do
      url "https://github.com/alliecatowo/glassy/releases/download/v0.6.1/glassy-x86_64-linux"
      sha256 "5f72cc6f819d3137d2fea35516f2bbb3f6721a1b69c0692304216c3a8ccf4bc0"
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
