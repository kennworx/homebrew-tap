class KennTs < Formula
  desc "kenn's TypeScript/JavaScript indexer"
  homepage "https://github.com/kennworx/kenn"
  version "0.2.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.0/kenn-ts-aarch64-apple-darwin.tar.gz"
      sha256 "bd467684238000bf8a6ebc2156b068aca4a1ca76755c0b6b09dd19756dc096d8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.0/kenn-ts-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3ba7e27e3e1a37edd53a955b63917e086dc1fdc152fec420302bfa025667daa6"
    end
    on_intel do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.0/kenn-ts-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "32ffd5bfc0a77bc9b16fe710d0b6bb9811f3c143cff19908a07f06d223a3d7e2"
    end
  end

  def install
    bin.install "kenn-ts"
  end
end
