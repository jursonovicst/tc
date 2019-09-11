# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc::to
class tc::to (
) {
  #TODO: remove, this is just a test
  file { '/tmp/role.txt':
    content => "I am a traffic ops\n"
  }

  class { 'tc::to::install': }
  -> class { 'tc::to::configure': }
}
