require 'formula'

class Coccinelle < Formula
  url 'http://coccinelle.lip6.fr/distrib/coccinelle-1.0.0-rc16.tgz'
  homepage 'http://coccinelle.lip6.fr'
  sha1 'b4a5c1eeafa84fd54239a4bbc327676cff6453a6'
  head 'https://github.com/coccinelle/coccinelle.git'

  depends_on 'ocaml'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make depend"
    system "make all.opt"
    system "make install"
  end
end
