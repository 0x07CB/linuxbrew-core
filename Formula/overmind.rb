class Overmind < Formula
  desc "Process manager for Procfile-based applications and tmux"
  homepage "https://github.com/DarthSim/overmind"
  url "https://github.com/DarthSim/overmind/archive/v2.2.2.tar.gz"
  sha256 "1d8afd960f91dcbb9e3c529f69aa3f1be89931b2c888a78ad69915faeb523f47"
  license "MIT"
  head "https://github.com/DarthSim/overmind.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "00af66eeee076ae3bccba58a690dc73f908b6af7ea0bfebf1fc6b81c5a88c445"
    sha256 cellar: :any_skip_relocation, big_sur:       "f0a2458bfe0cbe0a38ca8579b774e45262f68bf8a9f9d1d2ff70a9c388c21446"
    sha256 cellar: :any_skip_relocation, catalina:      "0d2b7a68b08aa6ce0a5cdfad5a90166248ee11fce70970d1e820918de612168a"
    sha256 cellar: :any_skip_relocation, mojave:        "07036145d0ff5102e0a64607cb1d253a49e66aa6ceb5ea4b82780a4078910c04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c7d86e0af5fbbe3f8155e0fd1d6553737f69f1697632055fbcd1bf5198fc4a50" # linuxbrew-core
  end

  depends_on "go" => :build
  depends_on "tmux"

  def install
    system "go", "build", "-ldflags", "-s -w", "-trimpath", "-o", bin/"overmind"
    prefix.install_metafiles
  end

  test do
    expected_message = "overmind: open ./Procfile: no such file or directory"
    assert_match expected_message, shell_output("#{bin}/overmind start 2>&1", 1)
    (testpath/"Procfile").write("test: echo 'test message'")
    expected_message = "test message"
    assert_match expected_message, shell_output("#{bin}/overmind start")
  end
end
