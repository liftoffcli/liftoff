TODO_WARNING_SCRIPT = <<WARNING
KEYWORDS="TODO:|FIXME:|\\?\\?\\?:|\\!\\!\\!:"
find "${SRCROOT}" -ipath "${SRCROOT}/vendor" -prune -o \\( -name "*.h" -or -name "*.m" \\) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\\$" | perl -p -e "s/($KEYWORDS)/ warning: \\$1/"
WARNING

command :todo do |c|
  c.syntax = 'liftoff todo [options]'
  c.summary = 'Add a build script to treat TODO and FIXME as warnings.'
  c.description = ''

  c.action do |args, options|
    helper = XcodeprojHelper.new
    helper.add_shell_script(TODO_WARNING_SCRIPT)
  end
end
