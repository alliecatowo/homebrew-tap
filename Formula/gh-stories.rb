# Homebrew formula for the gh-stories CLI (Stories for GitHub, in your terminal).
# The release assets are bare per-platform binaries. Bump the version, URLs and
# sha256 values (from the release checksums.txt) by hand after each release.
class GhStories < Formula
  desc "Terminal client for Stories for GitHub (also usable as a gh extension)"
  homepage "https://github.com/alliecatowo/gh-stories"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/alliecatowo/gh-stories/releases/download/v0.5.4/gh-stories_v0.5.4_darwin-arm64"
      sha256 "4497e4c1d038f8899591731209ffcc75d6c36d2b9f79bf6a8862355179e952dc"
    end
    on_intel do
      url "https://github.com/alliecatowo/gh-stories/releases/download/v0.5.4/gh-stories_v0.5.4_darwin-amd64"
      sha256 "8c9c5d4d1e099ace76dbbc524d7442d7d969b2d96d6a24bc5414c68f34f342c7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/alliecatowo/gh-stories/releases/download/v0.5.4/gh-stories_v0.5.4_linux-arm64"
      sha256 "a2595c4fd1044badd2a880c0efe1829780c71c1f6d4a6e318c5af5670b3620c1"
    end
    on_intel do
      url "https://github.com/alliecatowo/gh-stories/releases/download/v0.5.4/gh-stories_v0.5.4_linux-amd64"
      sha256 "6d83c3e918cc4bcd8ba78f926dadc3fa99bd0115d746c8d6e247cddb17ebe30a"
    end
  end

  def install
    # Downloaded as a bare binary (no archive); release assets carry no exec bit.
    bin.install Dir["gh-stories_*"].first => "gh-stories"
    chmod 0755, bin/"gh-stories"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gh-stories --version")
  end
end
