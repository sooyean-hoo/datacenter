# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include datacenter
class datacenter (
  String $datacenterName = '?' ,
){
# OS-specific
#  $datacenter = 'AWS';
  
  if $datacenterName == '?'  {

    if  $facts[ 'domain' ] == 'platform9.puppet.net'  {
      $datacenterName_ = 'P9'
    }elsif   $facts[ 'ec2_metadata' ] and
      $facts[ 'ec2_metadata' ]['services'] and
      $facts[ 'ec2_metadata' ]['services']['domain'] == 'amazonaws.com'  {
        $datacenterName_ = "AWS"  
    }else {
      $datacenterName_ = "UKNOWN"
    }
  }

  if $datacenterName == ''  {
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
     
    unless  $datacenterName_  {
      $datacenterName_ = $datacenterName  
    }
      case $facts['kernel'] {
        'windows': {
          file { 'datacenter.txt':
          ensure => 'file',
          path   => 'C:\\ProgramData\\PuppetLabs\\facter\\facts.d\\datacenter.txt',
          content => "datacenter=$datacenterName_",
          require => File['fact.d'] ,
        }
        file { 'fact.d':
          ensure => 'directory',
          path   => 'C:\\ProgramData\\PuppetLabs\\facter\\facts.d',
          recurse => true,
        }
        }
        'Linux': {
          file { 'datacenter.txt':
          ensure => 'file',
          path   => '/etc/puppetlabs/facter/facts.d/datacenter.txt',
          content => "datacenter=$datacenterName_",
          require => File['fact_d'] ,
        }
          file { 'fact_d':
          ensure => 'directory',
          path   => '/etc/puppetlabs/facter/facts.d/',
          recurse => true,
          require => File['facter'] ,
        }
        file { 'facter':
          ensure => 'directory',
          path   => '/etc/puppetlabs/facter',
          recurse => true,
          require => File['puppetlabs'] ,
        }
        file { 'puppetlabs':
          ensure => 'directory',
          path   => '/etc/puppetlabs',
          recurse => true,
        }
        }
        default: {
          fail('Unsupported operating system!')
        }
    }    
    }
}
