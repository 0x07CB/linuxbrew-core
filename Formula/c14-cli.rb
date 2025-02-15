class C14Cli < Formula
  desc "Manage your Online C14 archives from the command-line"
  homepage "https://github.com/scaleway/c14-cli"
  url "https://github.com/scaleway/c14-cli/archive/v0.5.0.tar.gz"
  sha256 "b93960ee3ba516a91df9f81cf9b258858f8b5da6238d44a339966a5636643cb2"
  license "MIT"
  head "https://github.com/scaleway/c14-cli.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "46d65ade1ad6406be53f136729cbeca6892dd53f6958dfd7417e3773ac9d2041"
    sha256 cellar: :any_skip_relocation, big_sur:       "ad34da8ecf1f0563fb208247b904bc64c11ff98c681dc87744ea32e9093b5d19"
    sha256 cellar: :any_skip_relocation, catalina:      "137f585fd6aef342e9ac97ce6ffe819d30641727e7f9d621fa6d0124afeb46f5"
    sha256 cellar: :any_skip_relocation, mojave:        "245dc470e7883100e9b8d3dd229a5fbf2e0960993c7432be11e31ba7ef887f71"
    sha256 cellar: :any_skip_relocation, high_sierra:   "6b3262c0d209f01dd93a491c541ee7f9fedca9f6ff03203487394e0e4f5cdecf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "239b003f8c7be81fbeea6be3488aa2d353b614b92b57d23b5bd6237827d4bad1" # linuxbrew-core
  end

  # "C14 Classic has been discontinued"
  deprecate! date: "2020-12-01", because: :repo_archived

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-o", bin/"c14",
           "-ldflags", "-X github.com/online-net/c14-cli/pkg/version.GITCOMMIT=homebrew",
           "./cmd/c14/"
  end

  test do
    output = shell_output(bin/"c14 help")
    assert_match "Interact with C14 from the command line.", output
  end
end
