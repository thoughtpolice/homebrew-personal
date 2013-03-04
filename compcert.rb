require 'formula'

class Compcert < Formula
  homepage 'http://compcert.inria.fr/'
  url 'http://compcert.inria.fr/release/compcert-1.12.1.tgz'
  sha1 'bb2b9737c9e946590c1a041cb5cdce6c71d4d33e'

  depends_on 'objective-caml'
  depends_on 'camlp5'
  depends_on 'coq'

  def install
    ENV.O2
    system "./configure -prefix #{prefix} ia32-macosx"
    system "make all"
    system "make install"
  end

  def test
    system "ccomp"
  end
end
