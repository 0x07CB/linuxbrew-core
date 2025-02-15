class Tanka < Formula
  desc "Flexible, reusable and concise configuration for Kubernetes using Jsonnet"
  homepage "https://tanka.dev"
  url "https://github.com/grafana/tanka.git",
      tag:      "v0.18.2",
      revision: "2034d2db26694eb6e404a567e23c2328dc75d489"
  license "Apache-2.0"
  head "https://github.com/grafana/tanka.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "96ab09d0931f4d046b00d6c13501c78a49f1f82d5f6e308988791402c0f2185c"
    sha256 cellar: :any_skip_relocation, big_sur:       "7d419079b8bc5a8785f70c119f7a949856f527b3ad7af814012006ad03ae94c1"
    sha256 cellar: :any_skip_relocation, catalina:      "6ab384978628615590e13b8f78b6e9d4a7d45a1fe1c26e640b27cb9bd5d909a2"
    sha256 cellar: :any_skip_relocation, mojave:        "32608fe976b454e5a38818e213c916c0c1bc1e8b3ecb3aadb558f926073b452a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ac6c455c59e1f540aed3bce6655650602c294e72ce6f1943816879e77edaa988" # linuxbrew-core
  end

  depends_on "go" => :build
  depends_on "kubernetes-cli"

  def install
    system "make", "static"
    bin.install "tk"
  end

  test do
    system "git", "clone", "https://github.com/sh0rez/grafana.libsonnet"
    system "#{bin}/tk", "show", "--dangerous-allow-redirect", "grafana.libsonnet/environments/default"
  end
end
