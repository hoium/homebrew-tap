class JcCli < Formula
  desc "JumpCloud CLI"
  homepage "https://github.com/TheJumpCloud/jc-cli"
  version "1.42.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-darwin-arm64.tar.gz"
      sha256 "985e729a9e737293896ffe6dd64f5c70269aab99a2abe05997525c797e1bb971"
    end
    on_intel do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-darwin-amd64.tar.gz"
      sha256 "cb294be27ce49dd7778d45593686849d7570195d2747f6f2e3f8610547ec6a4b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-linux-arm64.tar.gz"
      sha256 "1f2409193ec49b55ac74ed2dbded6c9eac95da7b427907eaea1f85ee5c088b39"
    end
    on_intel do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-linux-amd64.tar.gz"
      sha256 "a9e9138005d906c0bbaccdac2c45365dc4702b8c47e80518fa90b49f9e481622"
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
