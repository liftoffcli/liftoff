require 'formula'

class Liftoff < Formula
  homepage 'http://github.com/thoughtbot/liftoff'
  # This will change once we release. For now, I just want to point it at this branch since I know it works.
  url 'https://github.com/thoughtbot/liftoff/raw/master/pkg/Liftoff-0.7.6.tar.gz'
  sha1 '8afd0d04f85f8b5ddc11817957e1c9d558dfa34f'

  depends_on 'xcproj' => :recommended

  def install
    bin.install 'bin/liftoff'
    prefix.install 'defaults', 'lib', 'templates', 'vendor'
  end

  test do
    system '/usr/local/bin/liftoff -v'
  end
end
