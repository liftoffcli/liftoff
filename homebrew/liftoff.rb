require 'formula'

class Liftoff < Formula
  homepage 'https://github.com/liftoffcli/liftoff'
  url 'http://liftoffcli.github.io/liftoff/Liftoff-__VERSION__.tar.gz'
  sha256 '__SHA__'

  depends_on 'xcproj' => :recommended

  def install
    prefix.install 'defaults', 'templates', 'vendor'
    prefix.install 'lib' => 'rubylib'

    man1.install ['man/liftoff.1']
    man5.install ['man/liftoffrc.5']

    bin.install 'src/liftoff'
  end

  test do
    system "#{bin}/liftoff", '--version'
  end
end
