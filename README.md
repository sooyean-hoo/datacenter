# datacenter

Determine which DataCenter the node is in by examining the available facts.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with datacenter](#setup)
    * [What datacenter affects](#what-datacenter-affects)
    * [Setup requirements](#setup-requirements)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

Help in ENC, by providing a fact datacenter which show which DataCenter the node is in.

## Setup

```
mod 'datacenter',
  :git    => 'https://github.com/sooyean-hoo/datacenter.git',
  :branch => 'master'
```

### What datacenter affects 

* Add a fact: datacenter
* Produce a file with details of it datacenter.

## Usage

Just to start with a fact

```
include datacenter
```

To Dump the DataCenter Info out as a file.
DataCenter Info can be provide via Hiera:
E.g. data/datacenter/AWS/AWS.yaml

```
include datacenter::selfintro 
```

## Limitations

Windows and Linux

## Development

In the Development section, tell other users the ground rules for contributing to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You can also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
