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

  notify { $datacenter_keys:
    message => " ${title}  = ${lookup($title)}",
  }
}
