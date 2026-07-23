class KennTs < Formula
  desc "kenn's TypeScript/JavaScript indexer"
  homepage "https://github.com/kennworx/kenn"
  version "0.2.1"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.1/kenn-ts-aarch64-apple-darwin.tar.gz"
      sha256 "383cf28c72f33263b5f547ec0dc5c161aaa535fa55f9a0af798f6bb88559b204"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.1/kenn-ts-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3788b2c66617aee4a1f1eb701bff8a0211fbe6804ada49e1e6bcbd0f5c803ba9"
    end
    on_intel do
      url "https://github.com/kennworx/kenn/releases/download/v0.2.1/kenn-ts-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8534eab24905be8fbf0662cebe932640a717ad1418b79779429884a87b314307"
    end
  end

  def install
    bin.install "kenn-ts"
  end
end
