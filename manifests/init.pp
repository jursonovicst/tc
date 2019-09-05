# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc
class tc {
  file {'/tmp/tcworking.txt':
    content => "module tc loaded by hydra"
  }
}
