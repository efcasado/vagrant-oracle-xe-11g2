[UOC] Database Architecture - Oracle Express 11g2
==============================

## Requirements
- [Vagrant](https://www.vagrantup.com/)
- [Virtualbox](https://www.virtualbox.org/)

## Usage
1. Download Oracle Express 11g2 (Linux x64) from Oracle's website
2. Unzip it and place the unzipped RPM file 
3. [Optional] Adjust the memory and cpu settings in `Vagrantfile`
4. Run `make start` to build the virtual machine (`make stop` and `make delete` can be used for stopping and deleting the virtual machine, respectively)
5. Once the virtual machine is built, SSH into it and configure the database server
6. Create a new user
7. [Optional] Install [Oracle SQL Developer](http://www.oracle.com/technetwork/developer-tools/sql-developer/overview/index.html) on the host machine
