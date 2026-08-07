class Ags < Formula
  desc "Turn agent-authored markdown reasoning into an interactive in-browser review page"
  homepage "https://github.com/kennworx/agent-stage"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kennworx/agent-stage/releases/download/v0.1.0/ags-aarch64-apple-darwin.tar.xz"
      sha256 "3ca50f1ddb0827b906de295475207067c921f4ab3cc3ebf2b6e85f08f67bcb4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kennworx/agent-stage/releases/download/v0.1.0/ags-x86_64-apple-darwin.tar.xz"
      sha256 "88f53328e5e8a0256d6abb8f8acea0eed58e2212bf784ff81fb01bf077d9f6ec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kennworx/agent-stage/releases/download/v0.1.0/ags-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d0e38a62d7fead4238c41d6ae29771c94bfc4a2c5e030c916030bd520b37c3fe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kennworx/agent-stage/releases/download/v0.1.0/ags-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d4ec1affab825a5df8fb8feaa54b5def555e562132709c1b105af13c6b17b1a0"
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
    bin.install "ags" if OS.mac? && Hardware::CPU.arm?
    bin.install "ags" if OS.mac? && Hardware::CPU.intel?
    bin.install "ags" if OS.linux? && Hardware::CPU.arm?
    bin.install "ags" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
