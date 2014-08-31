UOC - Oracle Express 11g Release 2
==============================

## Requirements
- [Vagrant](https://www.vagrantup.com/)
- [Virtualbox](https://www.virtualbox.org/)

## Usage
1. Download Oracle Express 11g2 (Linux x64) from Oracle's website
2. Unzip it and place the unzipped RPM file into the same directory as this project
3. **[Optional]** Adjust the memory and cpu settings in `Vagrantfile`
4. Run `make start` to build the virtual machine (`make stop` and `make delete` can be used for stopping and deleting the virtual machine, respectively)
5. Once the virtual machine is built, SSH into it and configure the database server (`make attach` and `sudo /etc/init.d/oracle-xe configure`)
6. Create a new user
7. **[Optional]** Install [Oracle SQL Developer](http://www.oracle.com/technetwork/developer-tools/sql-developer/overview/index.html) on the host machine

## How-To

#### Create User
To create a new user you first need to SSH into the guest machine. You can SSH into it by typing
`make attach`. Once in the guest machine, connect to the database server

```sh
sqlplus sys as sysdba
```

and create a new user by typing

```sql
CREATE USER <username> IDENTIFIED BY <password>
```
