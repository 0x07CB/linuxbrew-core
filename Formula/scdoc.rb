class Scdoc < Formula
  desc "Small man page generator"
  homepage "https://git.sr.ht/~sircmpwn/scdoc/"
  url "https://git.sr.ht/~sircmpwn/scdoc/archive/1.11.1.tar.gz"
  sha256 "e529fcb00508e7e4c5025a745591b805b754b3bd5c84c5192acaefabdfa8f700"
  license "MIT"

  bottle do
    cellar :any_skip_relocation
    sha256 "81dd4cefe0f4df18d14726d318b5dbcf8b42085041834e5da8852f6ec02e8b73" => :big_sur
    sha256 "2aac49cd42efd595338cb631a42ffa7f418c46a144eb15398d60c38bee6644df" => :arm64_big_sur
    sha256 "ea37af44324b83e8368af5965ef5cb198ef1a4b4dbabcd81e0da9297366a245b" => :catalina
    sha256 "9ad77b02592b8be119ceafd2286a24c383a537a3b1e169b91aba049e82d41dee" => :mojave
    sha256 "5db50f8536ae9280e0954a09c672ffd249bbd57247781cfad6b9824c7ac396ed" => :x86_64_linux
  end

  def install
    # scdoc sets by default LDFLAGS=-static which doesn't work on macos(x)
    system "make", "LDFLAGS=", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    preamble = <<~EOF
      .\\" Generated by scdoc #{version}
      .\\" Complete documentation for this program is not available as a GNU info page
      .ie \\n(.g .ds Aq \\(aq
      .el       .ds Aq '
      .nh
      .ad l
      .\\" Begin generated content:
    EOF
    assert_equal preamble, shell_output("#{bin}/scdoc </dev/null")
  end
end
