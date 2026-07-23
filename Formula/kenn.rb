class Kenn < Formula
  desc "Code graph for your codebase — and for the agents working on it"
  homepage "https://github.com/kennworx/kenn"
  version "0.2.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/kennworx/kenn/releases/download/v0.2.1/kenn-aarch64-apple-darwin.tar.xz"
    sha256 "e35bcd14d472721c3d3b90ff0560c5296879c45226f02436ac32d934d5c1993b"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kennworx/kenn/releases/download/v0.2.1/kenn-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "190eeb4ef450c00604dc2a46f6244ff9d783f7dd98301186f6100f7d4b1f0fbc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kennworx/kenn/releases/download/v0.2.1/kenn-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "93479f11be53f4cfd00c9994c10999cac79cecdc52b1c92bea82b1611ab7ee4f"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "kenn" if OS.mac? && Hardware::CPU.arm?
    bin.install "kenn" if OS.linux? && Hardware::CPU.arm?
    bin.install "kenn" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
