class Ox < Formula
  desc "Independent Rust text editor that runs in your terminal"
  homepage "https://github.com/curlpipe/ox"
  url "https://github.com/curlpipe/ox/archive/0.2.5.tar.gz"
  sha256 "873eb447029508bc3fd1d7dda8803d79a7b107a7a903399947f4eac6ae671176"
  license "GPL-2.0-only"
  head "https://github.com/curlpipe/ox.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b2d8f1cf845e18a1068b939792814aaa0de01557bf62f55a54f399fbfec397f6"
    sha256 cellar: :any_skip_relocation, big_sur:       "d7488d81ea3d4717ea749f5c9fdc252077f2a99ccc40fbec98e9e12b20a16f74"
    sha256 cellar: :any_skip_relocation, catalina:      "7677242429502708970da5a5a4665cfa0b999581e6ab793ce8c4304d2488c6d7"
    sha256 cellar: :any_skip_relocation, mojave:        "fc76d843172825e04a7912b0aeace96c7e913c2b851f08cb646b4bc3f1add3aa"
    sha256 cellar: :any_skip_relocation, high_sierra:   "3008a1719ef3675fc9fb9c12de08dc7e1193877084f6a83db6a1ec87ac453da7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7a5ed34654ba0755784239451632e8bdddf1881371de7e48a2c8a69eede4e775" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    require "pty"

    _, w, pid = PTY.spawn(bin/"ox", "test.txt")
    sleep 1
    w.write "Hello Homebrew!\n"
    w.write "\cS"
    sleep 1
    w.write "\cQ"

    assert_match "Hello Homebrew!\n", (testpath/"test.txt").read
  ensure
    Process.kill("TERM", pid)
  end
end
