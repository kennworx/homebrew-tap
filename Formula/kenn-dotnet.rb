class KennDotnet < Formula
  desc "kenn's C# indexer (self-contained)"
  homepage "https://github.com/kennworx/kenn"
  version "0.2.1"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.1/kenn-dotnet-aarch64-apple-darwin.tar.gz"
      sha256 "4c970858f6d56e0ade3ea839ba9d193f13fa2291678cccd0564b39ae2f3797af"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.1/kenn-dotnet-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "90c3f6b3d5cf7f9f75667be4e2abe837fef9493e7e1eea691d32a198647baf10"
    end
    on_intel do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.1/kenn-dotnet-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "05236ac9d9671ee050d859d46cf7d2ea06d93cfb7a7497b5c1350a14935544f9"
    end
  end

  def install
    bin.install "kenn-dotnet"
  end
end
