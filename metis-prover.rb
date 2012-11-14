require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class MetisProver < Formula
  homepage 'http://www.gilith.com/software/metis/'
  url 'http://www.gilith.com/software/metis/metis.tar.gz'
  sha1 '4fdf2e8715e657d176d302914fc31da42f338bd0'
  version '20120927'

  depends_on 'mlton'
  depends_on 'gmp'

  def install
    ENV.j1 # Tests aren't thread safe
    system "make mlton"
    bin.install 'bin/mlton/metis' => 'metis-prover'
  end

  def test
    system "metis-prover --help"
  end

  def caveats; <<-EOS.undent
    The metis binary is installed as 'metis-prover'.
    EOS
  end
end
