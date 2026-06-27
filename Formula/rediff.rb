class Rediff < Formula
  desc "A fast Rust TUI git-diff viewer for reviewing changes"
  homepage "https://github.com/martynovs/rediff"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/martynovs/rediff/releases/download/v0.1.0/rediff-aarch64-apple-darwin.tar.xz"
      sha256 "165dd9932dbccba034bad6368155d0558fa74aa131c01c09304a57368060153a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/martynovs/rediff/releases/download/v0.1.0/rediff-x86_64-apple-darwin.tar.xz"
      sha256 "3dd948e005fa886230a7b168fb618e587670c81376e4ababe6b416975a2de0ba"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/martynovs/rediff/releases/download/v0.1.0/rediff-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2b5bc0894b91f83e9a8fd457d2900597d1bc1ad7a2029c171647772f128b33e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/martynovs/rediff/releases/download/v0.1.0/rediff-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6664740106d9a62ca6fc9d58f4d67930c3c307a462940a9a24f578980190f088"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "rediff" if OS.mac? && Hardware::CPU.arm?
    bin.install "rediff" if OS.mac? && Hardware::CPU.intel?
    bin.install "rediff" if OS.linux? && Hardware::CPU.arm?
    bin.install "rediff" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
