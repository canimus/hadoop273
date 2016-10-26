# Hadoop Cluster in Virtual Box

This project is an attempt to recreate a minimalistic infrastructure that provides a training environment to experiment with **HDFS** and enable the visualization of the operation of a Hadoop Cluster in an encapsulated environment.

You can always play with Enterprise Distributions of Hadoop like Cloudera Manager, HortonWorks or MapR but this is to understand what is happening behind the scenes, the details in the configuration and the footprints for each component to its lowest granularity.

## Prerequisites

1. Virtual Box
2. Vagrant

## Installation
```sh
git clone https://github.com/canimus/hadoop273.git
cd hadoop273
vagrant up
```

## Outcome

It will create 4 virtial boxes named

1. NameNode (nn) 10.10.10.2
2. SecondaryNameNode (nn) 10.10.10.2
3. DataNode1 (dn1) 10.10.10.3
4. DataNode2 (dn2) 10.10.10.4
5. DataNode3 (dn3) 10.10.10.5

### Addition in October 2016
6. Hive (hv) 10.10.10.6


## Configuration

```ruby
# Integers for data nodes
(1..3).each # This specified the number of DataNodes in the Vagrantfile

# vb.memory
vb.memory = 2048 # 2GB for NameNode
vb.memory = 1024 # 1GB for DataNode
```
## Hardware

Preferable __5GB__ of memory available in host machine


## Playground
To access the HDFS Name Node
```sh
vagrant ssh nn
cd /vagrant/hadoop*
bin/hdfs dfsadmin --help
# Alternatively you can access the web browser for the NameNode WebUI Admin
# http://localhost:50070/
```
