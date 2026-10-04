class Shoal < Formula
  desc "Structured, typed, sandbox-aware shell"
  homepage "https://github.com/alliecatowo/shoal"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.2.0/shoal-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "c51ea53df9ffd5f6dbd902d00523a3f64db396a4b23152fe018a69e0f35d8b90"
    end
    on_intel do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.2.0/shoal-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "f3cfc5f631ec57b6f148edb181effcd46dfc4eb4f418a42905ac05ca5b4d221d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.2.0/shoal-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3edd356c574120777caa92ed9e8af1e4547b56d187104bbf119a571806bcfa58"
    end
    on_intel do
      url "https://github.com/alliecatowo/shoal/releases/download/v0.2.0/shoal-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8c2f0e94223ebcaf32147456a182d58af54ec2fb8522910cfc9debdce6510725"
    end
  end

  def install
    # The archive holds one directory of prebuilt executables plus docs.
    bin.install Dir["shoal*"].select { |f| File.file?(f) && File.executable?(f) }
    man1.install Dir["man/*.1"] if Dir.exist?("man")
    bash_completion.install "completions/shoal.bash" => "shoal" if File.exist?("completions/shoal.bash")
    zsh_completion.install "completions/_shoal" if File.exist?("completions/_shoal")
    fish_completion.install "completions/shoal.fish" if File.exist?("completions/shoal.fish")
    doc.install "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/shoal --version")
  end
end
