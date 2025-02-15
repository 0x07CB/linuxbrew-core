class Ko < Formula
  desc "Build and deploy Go applications on Kubernetes"
  homepage "https://github.com/google/ko"
  url "https://github.com/google/ko/archive/v0.9.3.tar.gz"
  sha256 "a31c9f6f3fd443599b854338f396f0e4c43a3d6ef7b1138f5df75a2c1c785c61"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "05aee246743e81f1249b21b6972168756588d69e55ed6eb7c313527e1e7ef002"
    sha256 cellar: :any_skip_relocation, big_sur:       "2f7f3143a1033749e9ea454c920f8a8ced7fecb79ad7f51ba610ce03a2a5150e"
    sha256 cellar: :any_skip_relocation, catalina:      "2ee78e315a67abd4852c5aed5518c34edb19807a42c19bcbd81d9c28063f038f"
    sha256 cellar: :any_skip_relocation, mojave:        "2632cb6ac6ba4340008befa04b0b1a81415506a3c0b526006183a22636ce14e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2591ec7bdad23739ba49f2835c9b8d8de0b70fd1ae59ce36c0500fba482c1463" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags",
      "-s -w -X github.com/google/ko/pkg/commands.Version=#{version}"
  end

  test do
    output = shell_output("#{bin}/ko login reg.example.com -u brew -p test 2>&1")
    assert_match "logged in via #{testpath}/.docker/config.json", output
  end
end
