# Homebrew formula for glassy, a fast GPU-accelerated terminal emulator.
# brew install alliecatowo/tap/glassy
#
# Version and sha256 fields are rewritten on every release by the update-homebrew
# job in alliecatowo/glassy (.github/workflows/release.yml), which renders them from
# packaging/homebrew/formula.rb.tmpl in that repo and pushes here. Do not edit by hand.
#
# On macOS, stable installs fetch the prebuilt per-arch binary release asset. Linux
# stable installs build from the source tarball. --HEAD builds from main on any OS.
class Glassy < Formula
  desc "Fast, minimal GPU-accelerated terminal emulator written in Rust"
  homepage "https://github.com/alliecatowo/glassy"
  url "https://github.com/alliecatowo/glassy/releases/download/v0.6.1/glassy-0.6.1-src.tar.gz"
  version "0.6.1"
  sha256 "2b58d0ffcc0690965840b29f1f4b31357d7e9e00ccc42c2934368e807256ca6c"
  license "MIT"

  head do
    url "https://github.com/alliecatowo/glassy.git", branch: "main"
    depends_on "pkg-config" => :build
    depends_on "rust" => :build
  end

  # macOS-only override: swap the default source tarball for a prebuilt
  # per-arch binary. Homebrew resolves on_arm/on_intel against the host's
  # arch, so `brew install glassy` on macOS never touches the url/sha256 above.
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
    depends_on "pkg-config" => :build
    depends_on "rust" => :build
    depends_on "fontconfig"
  end

  def install
    if OS.mac? && !build.head?
      # Downloaded as a bare (non-archived) binary named glassy-<arch>-macos;
      # GitHub release assets carry no exec bit, hence the explicit chmod.
      bin.install Dir["glassy-*-macos"].first => "glassy"
      chmod 0755, bin/"glassy"
    else
      system "cargo", "install", *std_cargo_args
    end
  end

  # Install man page if present.
  def post_install
    man1.mkpath
    man1.install "extra/glassy.1" if File.exist?("extra/glassy.1")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/glassy --version 2>&1")
  end
end
