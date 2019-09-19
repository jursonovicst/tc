# @summary A short summary of the purpose of this class
#
# prepares traffic portal
#
# @example
#   include tc::tp
class tc::tp {
  class { 'tc::tp::install': }
  -> class { 'tc::tp::configure': }
}
