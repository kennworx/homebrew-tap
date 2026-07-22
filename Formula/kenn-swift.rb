class KennSwift < Formula
  desc "kenn's Swift indexer"
  homepage "https://github.com/kennworx/kenn"
  version "0.2.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.0/kenn-swift-aarch64-apple-darwin.tar.gz"
      sha256 "f214c04a81a7d17678b022df4d3bccde362a42f95c0444a7347f9ac6dc5f4a5d"
    end
  end

  def install
    bin.install "kenn-swift"
  end
end
