require 'formula'

class Compcert < Formula
  homepage 'http://compcert.inria.fr/'
  url 'http://compcert.inria.fr/release/compcert-1.11.tgz'
  sha1 '61e474dc209d939c737b953df3b41355f5d2e857'

  depends_on 'objective-caml'
  depends_on 'camlp5'
  depends_on 'coq'

  def patches
    { :p0 => "http://compcert.inria.fr/release/compcert-1.11-coq-8.4.patch" }
  end

  def install
    ENV.O2
    system "./configure -prefix #{prefix} ia32-macosx"
    system "make all"
    system "make install"
  end

  def test
    system "compcert"
  end
end
