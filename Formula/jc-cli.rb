class JcCli < Formula
  desc "JumpCloud CLI"
  homepage "https://github.com/TheJumpCloud/jc-cli"
  version "1.46.78"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-darwin-arm64.tar.gz"
      sha256 "0803dbe37faaf5bee6f47ec85bb1343beadfbf1b1ab01b15beac6035a8b01b39"
    end
    on_intel do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-darwin-amd64.tar.gz"
      sha256 "da8a14a89ed3b6ba96dbb5e1f4e789a4d4b4e2c148dfc66c4b1e91ddb04ad9e9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-linux-arm64.tar.gz"
      sha256 "55379ff8e3a8373408bfa6e80485a6451c10be19c0b804c3e8b832523b6a5fc6"
    end
    on_intel do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-linux-amd64.tar.gz"
      sha256 "e95dd7762c91a4a46292fc48e04c60f1e0739720258dfbccb5e8eb357035b536"
    end
  end

  def install
    bin.install "jc"
    generate_completions_from_executable(bin/"jc", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jc --version")
  end
end
