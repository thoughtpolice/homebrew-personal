require 'formula'

class Ott < Formula
  homepage 'http://www.cl.cam.ac.uk/~pes20/ott/'
  url 'http://www.cl.cam.ac.uk/~pes20/ott/ott_distro_0.21.2.tar.gz'
  version '0.21.2'
  sha1 'b3696a839caf03d11fa4dfac4505553ae9ac9577'

  depends_on 'objective-caml'

  def install
    system "make world"
    bin.install "bin/ott"
  end

  def test
    system "ott -help"
  end
end
