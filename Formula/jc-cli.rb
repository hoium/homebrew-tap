class JcCli < Formula
  desc "JumpCloud CLI"
  homepage "https://github.com/TheJumpCloud/jc-cli"
  version "1.46.33"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-darwin-arm64.tar.gz"
      sha256 "64dedd7b87fdc6af30433ce709a757053411d9db18472449da5cadcba433830b"
    end
    on_intel do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-darwin-amd64.tar.gz"
      sha256 "0b847d0eec1e400c4a871d340d4847add14fbe8b115d9bfc9c57cf39054feb11"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-linux-arm64.tar.gz"
      sha256 "3c98ef397184616b80f8619ad447a6bfd77ca9cdb9c35b27e6b3b86c695a2877"
    end
    on_intel do
      url "https://github.com/TheJumpCloud/jc-cli/releases/download/#{version}/jc-linux-amd64.tar.gz"
      sha256 "aa2d857bcb7709306e2bc96e76b7dc5a321df32182e4508e7f31c88de59f84a6"
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
