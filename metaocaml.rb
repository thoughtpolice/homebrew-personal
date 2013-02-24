require 'formula'

class Metaocaml < Formula
  homepage 'http://metaocaml.org'
  head 'https://github.com/metaocaml/ber-metaocaml.git', :branch => 'ber-n100'

  depends_on :x11 if MacOS::X11.installed?
  keg_only "It conflicts with OCaml."

  def install
    system "./configure", "--prefix", prefix,
                          "--mandir", man,
                          "-cc", ENV.cc,
                          "-with-debug-runtime",
                          "-no-tk",
                          "-aspp", "#{ENV.cc} -c"
    ENV.deparallelize # Builds are not parallel-safe, esp. with many cores
    cd "metalib" do
      system "make patch"
    end

    system "make core"
    system "make coreboot"
    system "make all"
    system "make -i install"

    cd "metalib" do
      system "make all"
      system "make install"
    end

    # site-lib in the Cellar will be a symlink to the HOMEBREW_PREFIX location,
    # which is mkpath'd by Keg#link when something installs into it
    ln_s prefix/"lib/ocaml/site-lib", lib/"ocaml/site-lib"
  end

  def caveats; <<-EOS.undent
    This formula is keg-only, so it doesn't conflict with OCaml.

    You probably just want the REPL and batch compiler, which you can
    get by saying:

      $ ln -s #{bin}/metaocaml ~/bin/metaocaml
      $ ln -s #{bin}/metaocamlc ~/bin/metaocamlc
    EOS
  end
end
