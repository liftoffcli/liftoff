require 'formula'

class Liftoff < Formula
  homepage 'http://github.com/thoughtbot/liftoff'
  # This will change once we release. For now, I just want to point it at this branch since I know it works.
  url 'http://thoughtbot.github.io/liftoff/Liftoff-1.0.tar.gz'
  sha1 '6218799f1f8730ac05fb72e488c6617c8a468454'

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
