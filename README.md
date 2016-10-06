# Hadoop Cluster in Virtual Box

This project is an attempt to recreate a minimalistic infrastructure that provides a training environment to experiment with **HDFS** and enable the visualization of the operation of a Hadoop Cluster in an encapsulated environment.

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

1. NameNode (nn)
2. SecondaryNameNode (nn)
3. DataNode1 (dn1)
4. DataNode2 (dn2)
5. DataNode3 (dn3)


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
