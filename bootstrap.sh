# -*- mode: bash -*-

#!/usr/bin/env sh

DIR=/vagrant

apt-get update
apt-get install -y unzip bc libaio1 flex unixodbc alien openjdk-7-jdk

unzip $DIR/oracle-xe-11.2.0-1.0.x86_64.rpm.zip -d $DIR
alien --scripts -d $DIR/Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm
rm -rf $DIR/Disk1

# Set swap size to 2GB
cp /etc/fstab /etc/fstab.bk
swapoff /dev/precise64/swap_1
lvm lvremove /dev/precise64/swap_1
sed -i '/swap_1/d' /etc/fstab
dd if=/dev/zero of=/swapfile bs=2048 count=1048576
mkswap /swapfile
swapon /swapfile
echo '/swapfile swap swap defaults 0 0' >> /etc/fstab

bash -c "cat > /sbin/chkconfig" <<EOF
#!/bin/bash
# Oracle 11gR2 XE installer chkconfig hack for Ubuntu
file=/etc/init.d/oracle-xe
if [[ ! \`tail -n1 $file | grep INIT\` ]]; then
echo >> \$file
echo '### BEGIN INIT INFO' >> \$file
echo '# Provides: OracleXE' >> \$file
echo '# Required-Start: $remote_fs $syslog' >> \$file
echo '# Required-Stop: $remote_fs $syslog' >> \$file
echo '# Default-Start: 2 3 4 5' >> \$file
echo '# Default-Stop: 0 1 6' >> \$file
echo '# Short-Description: Oracle 11g Express Edition' >> \$file
echo '### END INIT INFO' >> \$file
fi
update-rc.d oracle-xe defaults 80 01
EOF

chmod 755 /sbin/chkconfig

bash -c "cat > /etc/sysctl.d/60-oracele.conf" <<EOF
# Oracle 11g XE kernel parameters
fs.file-max=6815744
net.ipv4.ip_local_port_range=9000 65000
kernel.sem=250 32000 100 128
kernel.shmmax=536870912
EOF

service procps start

ln -sf /usr/bin/awk /bin/awk
mkdir -p /var/lock/subsys
touch /var/lock/subsys/listener

dpkg -i oracle-xe_11.2.0-2_amd64.deb
rm -rf oracle-xe_11.2.0-2_amd64.deb

bash -c "cat >> .bashrc" <<EOF
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export NLS_LANG=\`$ORACLE_HOME/bin/nls_lang.sh\`
export ORACLE_BASE=/u01/app/oracle
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$LD_LIBRARY_PATH
export PATH=\$ORACLE_HOME/bin:\$PATH
EOF

source .bashrc

rm -r /dev/shm
mkdir -p /dev/shm
mount -t tmpfs shmfs -o size=2048m /dev/shm
