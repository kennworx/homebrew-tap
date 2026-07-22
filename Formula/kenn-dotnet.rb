class KennDotnet < Formula
  desc "kenn's C# indexer (self-contained)"
  homepage "https://github.com/kennworx/kenn"
  version "0.2.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.0/kenn-dotnet-aarch64-apple-darwin.tar.gz"
      sha256 "c7037c7ab8d887ccd3d73994437cdf5cfb34d5c27841ea66cf27725bd8e08142"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.0/kenn-dotnet-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3f59c9e8b7a2cdef0b58908b6909223211b90296280191d4efc0f5c22055de8c"
    end
    on_intel do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.0/kenn-dotnet-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3f43c8d815d57a07e8318d4394e7363c7bacad4e7111e43038d338f9273af8b1"
    end
  end

  def install
    bin.install "kenn-dotnet"
  end
end
