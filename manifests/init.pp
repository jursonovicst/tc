# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc
class tc (
  String $rolefile = '/etc/tcrole'
){
  #TODO: remove, this is just debug
  file {'/tmp/tcworking.txt':
    content => "module tc loaded by hydra\n"
  }

  # classify node
  if ! $facts['tcrole'] {
    file {'/tmp/role.txt':
      content => "I have no role, file $rolefile probably does not exist!\n"
    }
  } elsif $facts['tcrole'] == 'trafficops' {
    include tc::to
  } else {
    #TODO: remove, this is just debug
    file {'/tmp/role.txt':
      content => "I have an unknown role: ${facts['tcrole']}\n"
    }
  }

}
