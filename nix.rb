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

    (bin+'nix-init.sh').write <<-EOS.undent
      #!/bin/bash
      source #{prefix}/etc/profile.d/nix.sh
    EOS
    chmod 0775, bin+'nix-init.sh'
  end

  def caveats; <<-EOS.undent
    You can use the 'nix-init.sh' script to prepare your shell environment.

    You need to add the nixpkgs channel:

      $ nix-channel --add http://nixos.org/channels/nixpkgs-unstable
      $ nix-channel --update

    EOS
  end

  plist_options :manual => "nix-daemon"
  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_prefix}/bin/nix-daemon</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>UserName</key>
      <string>#{`whoami`.chomp}</string>
      <key>WorkingDirectory</key>
      <string>#{var}</string>
      <key>StandardErrorPath</key>
      <string>#{var}/nix/daemon.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/nix/daemon.log</string>
    </dict>
    </plist>
    EOS
  end

  def test
    system "nix-env --help"
  end
end
