require 'formula'

class CamlLight < Formula
  homepage 'http://caml.inria.fr/caml-light/'
  url 'http://caml.inria.fr/pub/distrib/caml-light-0.75/cl75unix.tar.gz'
  sha1 '967d0a102409dc6201387302cb44b8f2b2828c46'
  version '0.75'

  keg_only "It conflicts with OCaml (ocamlyacc, etc.)"

  fails_with :clang do
    build 421
    cause "'linker' input unused when '-E' is present"
  end

  def install
    ENV.O2

    inreplace ['src/Makefile'] do |s|
      s.change_make_var! "BINDIR", bin
      s.change_make_var! "LIBDIR", lib
      s.change_make_var! "MANDIR", man1
      s.change_make_var! "CPP", "/usr/bin/cpp -P -traditional -Dunix"
    end

    man1.mkpath # The install script expects this to be there
    cd "src" do
      system "make configure"
      system "make world"
      system "make install"
    end

    (bin+'caml-light').write <<-EOS.undent
      #!/bin/bash
      exec #{bin}/camlrun #{lib}/camltop -stdlib #{prefix}/lib $*
    EOS
    chmod 0775, bin+'caml-light'
  end

  def caveats; <<-EOS.undent
    This formula is keg-only, so it doesn't conflict with OCaml.

    You probably just want the Caml REPL, which you can get by
    doing:

      $ ln -s #{bin}/caml-light ~/bin/caml-light
    EOS
  end
end
