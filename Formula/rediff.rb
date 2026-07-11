class Rediff < Formula
  desc "A fast Rust TUI git-diff viewer for reviewing changes"
  homepage "https://github.com/kennworx/rediff"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kennworx/rediff/releases/download/v0.1.0/rediff-aarch64-apple-darwin.tar.xz"
      sha256 "5abb4b2a55ab526e349e69d5c9ec223dcb29cd514c872b0500db5df1c429b4f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kennworx/rediff/releases/download/v0.1.0/rediff-x86_64-apple-darwin.tar.xz"
      sha256 "b64e0c2f8cc8bdb6123656a6b37e9ca27147cfbafc394d0423d9f40802916cbe"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kennworx/rediff/releases/download/v0.1.0/rediff-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9fb21cdd81daee1298b1e83effa93e93aedf2b4aeaf2c3f47a47a75d92aaf52b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kennworx/rediff/releases/download/v0.1.0/rediff-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ce44e190d62d4a9f242a75b041d67098f8be95d3f1cd9b5e0ed9573d308c1f08"
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
