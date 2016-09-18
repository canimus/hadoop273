# Hadoop Cluster in Virtual Box

This project is an attempt to recreate a minimalistic infrastructure that provides a training environment to experiment with **HDFS** and enable the visualization of the operation of a Hadoop Cluster in an encapsulated environment.

## Prerequisites
1. Virtual Box 
2. Vagrant

## Installation
```sh
git clone https://github.com/canimus/hadoop273.git
vagrant up
```

## Outcome
It will create 4 virtial boxes named
1. NameNode (nn)
2. SecondaryNameNode (nn)
3. DataNode1 (dn1)
4. DataNode2 (dn2)
5. DataNode3 (dn3)
