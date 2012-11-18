require 'formula'

class Z3 < Formula
  homepage 'http://z3.codeplex.com/'
  url 'https://git01.codeplex.com/z3', :using => :git, :tag => 'v4.3.1'
  version '4.3.1'

  depends_on :autoconf
  depends_on :automake
  depends_on :libtool

  fails_with :llvm do
    cause "configure says compiler is unsupported"
  end

  def install
    ENV.O3
    system "autoreconf -i --force"
    system "./configure --prefix=#{prefix} CXX=clang++"
    system "python scripts/mk_make.py"
    cd "build" do
      system "make"
      system "make install"
    end
  end
end
