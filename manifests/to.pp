# @summary A short summary of the purpose of this class
#
# Prepares the traffic ops
#
# @example
#   include tc::to
class tc::to (
) {
  class { 'tc::to::install': }
  -> class { 'tc::to::configure': }
}
