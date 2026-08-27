class JcCli < Formula
  desc "JumpCloud CLI"
  homepage "https://github.com/TheJumpCloud/jc-cli"
  version "1.46.26"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-darwin-arm64.tar.gz"
      sha256 "424493992fc650a0fc356b372d3ae5928613d05796e5a6986f68d8ca621f9b31"
    end
    on_intel do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-darwin-amd64.tar.gz"
      sha256 "82cbfc0d61e4537bcdb04cd43d2f008a3202a9d7c9c8ff47f4856796f932244d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-linux-arm64.tar.gz"
      sha256 "b42309ffcd527224467bff7b9a55da16f813c7b1358b047dc37c6f6e34c54ac1"
    end
    on_intel do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-linux-amd64.tar.gz"
      sha256 "f494483e910d09971ac4b6350bb64f2a01ffb7ffaf89a154518ed535ba5ab308"
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
