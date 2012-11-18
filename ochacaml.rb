require 'formula'

class Ochacaml < Formula
  homepage 'http://pllab.is.ocha.ac.jp/~asai/OchaCaml'
  url 'http://caml.inria.fr/pub/distrib/caml-light-0.75/cl75unix.tar.gz'
  sha1 '967d0a102409dc6201387302cb44b8f2b2828c46'
  version '110912'

  keg_only "It conflicts with OCaml (ocamlyacc, etc.)"

  def patches
    { :p1 => "http://raw.github.com/gist/4101977/0f44a77fb7850451e453e2a5f387d263c41857e2/ochacaml.diff" }
  end

  def install
    ENV.O2

    inreplace ['src/Makefile'] do |s|
      s.change_make_var! "BINDIR", bin
      s.change_make_var! "LIBDIR", lib
      s.change_make_var! "MANDIR", man1
    end

    man1.mkpath # The install script expects this to be there
    cd "src" do
      system "make configure"
      system "make world"
      system "make install"
    end

    (bin+'ochacaml').write <<-EOS.undent
      #!/bin/bash
      exec #{bin}/camlrun #{lib}/camltop -stdlib #{prefix}/lib $*
    EOS
    chmod 0775, bin+'ochacaml'
  end

  def caveats; <<-EOS.undent
    This formula is keg-only, so it doesn't conflict with OCaml.

    You probably just want the OchaCaml REPL, which you can get by
    doing:

      $ ln -s #{bin}/ochacaml ~/bin/ochacaml
    EOS
  end
end
