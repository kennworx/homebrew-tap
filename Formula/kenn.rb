class Kenn < Formula
  desc "Code graph for your codebase — and for the agents working on it"
  homepage "https://github.com/kennworx/kenn"
  version "0.1.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/kennworx/kenn/releases/download/v0.1.0/kenn-aarch64-apple-darwin.tar.xz"
    sha256 "c5049153bb1387cc8d4197f0fc2cc4a47b79e071509d462e4d553b71e806f4cb"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kennworx/kenn/releases/download/v0.1.0/kenn-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "65998c75b3d244a95c842e73133d2db043d46870ffc654b79317fc1c0f058f44"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kennworx/kenn/releases/download/v0.1.0/kenn-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "621dac878d1d5521ca5ef0b36dd2413e1b2dfe8f3591e850f5a247286d114220"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
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
