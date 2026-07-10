class JcCli < Formula
  desc "JumpCloud CLI"
  homepage "https://github.com/TheJumpCloud/jc-cli"
  version "1.35.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-darwin-arm64.tar.gz"
      sha256 "f9ef7b4bb107857bb81b054ea1eee62f18081c92cd85300d2ecef095afe4c0c1"
    end
    on_intel do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-darwin-amd64.tar.gz"
      sha256 "e16671af3458f8d67f9d85d7a5564d7f5ffff2841f6ede5046c98b66dbf8c962"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-linux-arm64.tar.gz"
      sha256 "a1d4d8566eb59fc32705e2a701cd7d099dc854ba075a324c0025c567ad2c64b5"
    end
    on_intel do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-linux-amd64.tar.gz"
      sha256 "00b62ec9b4fac7c2b4ce74eb7d36081e783fd7bd80c9231e91f12b289349c015"
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
