# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include datacenter
class datacenter (
  String $datacenter_name = '?' ,
  String $datacenter_name_flag   ,
){
# OS-specific
#  $datacenter = 'AWS';
  if $datacenter_name == '?'  {

    if  $facts[ 'domain' ] == 'platform9.puppet.net'  {
      $datacenter_name_ = 'P9'
    }elsif   $facts[ 'ec2_metadata' ] and
      $facts[ 'ec2_metadata' ]['services'] and
      $facts[ 'ec2_metadata' ]['services']['domain'] == 'amazonaws.com'  {
        $datacenter_name_ = 'AWS'
    }else {
      $datacenter_name_ = 'UKNOWN'
    }
  }

  if $datacenter_name == ''  {
      case $facts[ 'kernel' ] {
        'windows': {
          file { 'datacenter.txt':
          ensure => 'absent',
          path   => 'C:\\ProgramData\\PuppetLabs\\facter\\facts.d\\datacenter.txt',
        }
      }
        'Linux': {
          file { 'datacenter.txt':
          ensure => 'absent',
          path   => '/etc/puppetlabs/facter/facts.d/datacenter.txt',
        }
      }
        default: {
          fail('Unsupported operating system!')
        }
    }
  } else {

    unless  $datacenter_name_  {
      $datacenter_name_ = $datacenter_name
    }

    case $facts['kernel'] {
      'windows': {
        file { 'datacenter.txt':
        ensure  => 'file',
        path    => 'C:\\ProgramData\\PuppetLabs\\facter\\facts.d\\datacenter.txt',
        content => "datacenter=${datacenter_name_}",
        require => File['fact.d'] ,
      }
      file { 'fact.d':
        ensure  => 'directory',
        path    => 'C:\\ProgramData\\PuppetLabs\\facter\\facts.d',
        recurse => true,
      }
      }
      'Linux': {
        file { 'datacenter.txt':
        ensure  => 'file',
        path    => '/etc/puppetlabs/facter/facts.d/datacenter.txt',
        content => "datacenter=${datacenter_name_}",
        require => File['fact_d'] ,
      }
        file { 'fact_d':
        ensure  => 'directory',
        path    => '/etc/puppetlabs/facter/facts.d/',
        recurse => true,
        require => File['facter'] ,
      }
      file { 'facter':
        ensure  => 'directory',
        path    => '/etc/puppetlabs/facter',
        recurse => true,
        require => File['puppetlabs'] ,
      }
      file { 'puppetlabs':
        ensure  => 'directory',
        path    => '/etc/puppetlabs',
        recurse => true,
      }
      }
      default: {
        fail('Unsupported operating system!')
      }
    }
  }
}
