require 'formula'

class Liftoff < Formula
  homepage 'https://github.com/thoughtbot/liftoff'
  url 'http://thoughtbot.github.io/liftoff/Liftoff-__VERSION__.tar.gz'
  sha1 '__SHA__'

  depends_on 'xcproj' => :recommended

  def install
    build_xcodeproj_extension

    prefix.install 'defaults', 'templates', 'vendor'
    prefix.install 'lib' => 'rubylib'

    man1.install ['man/liftoff.1']
    man5.install ['man/liftoffrc.5']

    bin.install 'src/liftoff'
  end

  def build_xcodeproj_extension
    ohai 'Creating Xcodeproj C extension'
    xcodeproj_ext_dir = Dir.glob('vendor/gems/xcodeproj*/ext/xcodeproj').first
    Dir.chdir xcodeproj_ext_dir do
      system '/usr/bin/ruby extconf.rb'
      system 'make'
    end
  end

  test do
    system "#{bin}/liftoff", '--version'
  end
end
