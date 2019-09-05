# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc
class tc (
  String $rolefile = '/etc/tcrole'
){
  # classify node
  if ! $facts['tcrole'] {
    file {'/tmp/role.txt':
      content => "I have no role, file $rolefile probably does not exist!\n"
    }
  } elsif $facts['tcrole'] == 'trafficops' {
    include tc::to
  } else {
    file {'/tmp/role.txt':
      content => "I have an unknown role: ${facts['tcrole']}\n"
    }
  }
}
