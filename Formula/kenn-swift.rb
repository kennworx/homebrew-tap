class KennSwift < Formula
  desc "kenn's Swift indexer"
  homepage "https://github.com/kennworx/kenn"
  version "0.2.1"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.1/kenn-swift-aarch64-apple-darwin.tar.gz"
      sha256 "1a3533f5093d0186cef45b8a670df51d3406164be4c0cb3388887edbad4fbb98"
    end
  end

  def install
    bin.install "kenn-swift"
  end
end
