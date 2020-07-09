# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include datacenter::selfintro
class datacenter::selfintro {
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

  $bar=split('                      ','').join('========')
    
  notify { "0${$bar}": }
  $datacenter_keys.each |String $hkey| {
    $v =  lookup($hkey)
    notify { " ${hkey} = ${v} ": }
  }  
  
  notify { "1${$bar}": }
  
  $msg = ($datacenter_keys.map | $hkey | {   " ${hkey} :          ${lookup( $hkey ) }\r\n" } ).join
  
  notify { "Message\r\n  ${msg}" :  }
  
  notify { "2${$bar}": }

  file{'/tmp/datacenterInfo.txt': 
    content => $msg ,
  }

}
