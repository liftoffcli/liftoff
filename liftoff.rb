require 'formula'

class Liftoff < Formula
  homepage 'http://github.com/thoughtbot/liftoff'
  # This will change once we release. For now, I just want to point it at this branch since I know it works.
  url 'https://github.com/thoughtbot/liftoff/raw/gf-vendorize-gems/pkg/Liftoff-0.7.6.tar.gz'
  sha1 '7b30fe6e1946d8ef83eed305d489aa59a7de4275'

  depends_on 'xcproj' => :recommended

  def install
    bin.install 'bin/liftoff'
    prefix.install 'defaults', 'lib', 'templates', 'vendor'
  end

  test do
    system '/usr/local/bin/liftoff -v'
  end
end
