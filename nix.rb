require 'formula'

class Nix < Formula
  homepage 'http://nixos.org/nix'
  url 'http://hydra.nixos.org/build/3455295/download/5/nix-1.2.tar.xz'
  version '1.2'
  sha1 'b5f5fb7e9932805fa3546f641330642470390d07'

  depends_on 'xz'
  depends_on 'bdw-gc'

  def install
    system "./configure --prefix=#{prefix}"
    system "make"
    system "make install"
  end

  def test
    system "true"
  end
end
