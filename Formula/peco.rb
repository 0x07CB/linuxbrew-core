class Peco < Formula
  desc "Simplistic interactive filtering tool"
  homepage "https://github.com/peco/peco"
  url "https://github.com/peco/peco/archive/refs/tags/v0.5.10.tar.gz"
  sha256 "781c2effc4f6a58d9ff96fb0fc8b0fba3aab56a91a34933d68c5de3aea5fe3f6"
  license "MIT"
  head "https://github.com/peco/peco.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d272601e901b030d5912749e56d9c27bc08ea42a47833658f5d0ceef3b3acf16"
    sha256 cellar: :any_skip_relocation, big_sur:       "dd707346be0be24e7f91aeca1bb9520a17d9632758e427dde0b66c4638944be2"
    sha256 cellar: :any_skip_relocation, catalina:      "8c6e6459743f08e90e73f9b826505807b8d0d3f2ad2d818f580bcb2addf7c115"
    sha256 cellar: :any_skip_relocation, mojave:        "7abf9bc7b046f07d3f2c53599c2f41cac7196945cda79f10295db4e61aa50397"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c540a8589945da4b402dfaa39d8cc201d0b8bad018f71cdb55d35885053c4691" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "make", "build"
    system "go", "build", *std_go_args, "cmd/peco/peco.go"
  end

  test do
    system "#{bin}/peco", "--version"
  end
end
