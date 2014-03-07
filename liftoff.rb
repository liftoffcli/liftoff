require 'formula'

class Liftoff < Formula
  homepage 'http://github.com/thoughtbot/liftoff'
  # This will change once we release. For now, I just want to point it at this branch since I know it works.
  url 'https://github.com/thoughtbot/liftoff/raw/gf-man-oh-man/pkg/Liftoff-0.7.6.tar.gz'
  sha1 '1d9028775b58f0c9c3285c1a0278f69f8373916d'

  depends_on 'xcproj' => :recommended

  def install
    bin.install 'bin/liftoff'
    prefix.install 'defaults', 'lib', 'templates', 'vendor'
    man1.install ['man/liftoff.1']
    man5.install ['man/liftoffrc.5']
  end

  test do
    system '/usr/local/bin/liftoff -v'
  end
end
