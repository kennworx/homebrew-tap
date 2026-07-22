class Kenn < Formula
  desc "Code graph for your codebase — and for the agents working on it"
  homepage "https://github.com/kennworx/kenn"
  version "0.2.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/kennworx/kenn/releases/download/v0.2.0/kenn-aarch64-apple-darwin.tar.xz"
    sha256 "18417b86a7d96cba4de8838edff7406e7c55f6e8444658f9055b9bc9db0cd435"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kennworx/kenn/releases/download/v0.2.0/kenn-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "56323e4b54237784ae1a3a388cd7d930cd008a7f7f7303c6dde493800ff08389"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kennworx/kenn/releases/download/v0.2.0/kenn-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "192a35f1f26f2e2b9615df95720979e09b4ccd6ce369a0c04d58ea75f6044e15"
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
