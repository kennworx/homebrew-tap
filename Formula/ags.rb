class Ags < Formula
  desc "Turn agent-authored markdown reasoning into an interactive in-browser review page"
  homepage "https://github.com/kennworx/agent-stage"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kennworx/agent-stage/releases/download/v0.1.0/ags-aarch64-apple-darwin.tar.xz"
      sha256 "37b43a431b4a0a754a7802d511cf153be739ca8d27fe6540e81bcf5c2acab4bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kennworx/agent-stage/releases/download/v0.1.0/ags-x86_64-apple-darwin.tar.xz"
      sha256 "547f0a143e53f36e6bd28339500c7870a5f2542a6a8673eb1291e89536e6b6f5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kennworx/agent-stage/releases/download/v0.1.0/ags-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1a986d3107f43379dcf0765ee5199007cabb3d04160ac8657510472d8db5b34b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kennworx/agent-stage/releases/download/v0.1.0/ags-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "95cbb3e4963659044c78a86ec9132653172b5d72f4bc5bfcd84a5bea39ecda79"
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
