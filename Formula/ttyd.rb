class Ttyd < Formula
  desc "Command-line tool for sharing terminal over the web"
  homepage "https://tsl0922.github.io/ttyd/"
  url "https://github.com/tsl0922/ttyd/archive/1.6.3.tar.gz"
  sha256 "1116419527edfe73717b71407fb6e06f46098fc8a8e6b0bb778c4c75dc9f64b9"
  license "MIT"
  revision 4
  head "https://github.com/tsl0922/ttyd.git", branch: "main"

  bottle do
    sha256 arm64_big_sur: "c447da2fb5319fb4f14156e6df03aced1a4eff128538c05674a3872a3843a5e0"
    sha256 big_sur:       "1d05dbb4c06fdf46c47195d4cbd32939e484fbff6b973ce111166a6fead65b5c"
    sha256 catalina:      "201f490f7ccbb978085190d01585deda06430aada52271cc4ea8f434d16492c6"
    sha256 mojave:        "555135cdd2ff20f6e0c7d95e756e1be4561c458b2f2411c6478b574e726b8b5d"
    sha256 x86_64_linux:  "b97f691e851cd0d89abdb7297f1177e18600618a8b3d5851e928cd258e89b7f4" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "json-c"
  depends_on "libevent"
  depends_on "libuv"
  depends_on "libwebsockets"
  depends_on "openssl@1.1"

  uses_from_macos "vim" # needed for xxd

  def install
    system "cmake", ".",
                    *std_cmake_args,
                    "-DOPENSSL_ROOT_DIR=#{Formula["openssl@1.1"].opt_prefix}"
    system "make", "install"
  end

  test do
    port = free_port
    fork do
      system "#{bin}/ttyd", "--port", port.to_s, "bash"
    end
    sleep 5

    system "curl", "-sI", "http://localhost:#{port}"
  end
end
