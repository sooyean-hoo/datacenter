# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include datacenter::selfintro
class datacenter::selfintro (
    String $datacenter_name_flag   ,
){
  $datacenter_keys=[
    'datacentername',
    'datacenterurl',
    'datacenteraddress',
    'datacentertelno',
    'datacentertechology',
    'datacentermanagedby',
    'motd',
    'password'
    ]

  $datacenter_values=[
    'datacentername',
    'datacenterurl',
    'datacenteraddress',
    'datacentertelno',
    'datacentertechology',
    'datacentermanagedby',
    'motd',
    'password'
    ]

  $tmp=['','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',]
  $bar=$tmp.join('====')
  $cross=$tmp.join('++++')
  notify { "Start${$cross}": }

  notify { "0${$bar}": }
  $datacenter_keys.each |String $hkey| {
    $v =  lookup($hkey)
    notify { " ${hkey} = ${v} ": }
  }

  notify { "1${$bar}": }

  $msg = ($datacenter_keys.map | $hkey | {   " ${hkey} :          ${lookup( $hkey ) }\r\n" } ).join

  notify { "Message\r\n  ${msg}" :  }

  notify { "2${$bar}": }

  case $facts[ 'kernel' ] {
    'windows': {
      $fileURL= 'C:\\datacenter.txt'
    }
    'Linux': {
      $fileURL= '/tmp/datacenter.txt'
    }
  }
  
  file{ $fileURL:
    content => $msg ,
  }
  
  notify { "End${$cross}": }

}
