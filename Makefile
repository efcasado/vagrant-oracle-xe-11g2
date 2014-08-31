# ==============================================================================
#  Make file for building and operating the virtual machine required for the
#  Database Architecture at Universitat Oberta de Catalunya (UOC).
#
#  Author: Enrique Fernandez <efcasado@gmail.com>
#  Date:   August, 2014
# ==============================================================================

start:
	@vagrant up

stop:
	@vagrant halt

delete:
	@vagrant destroy

attach:
	@vagrant ssh

clean:
	@rm -rf Disk1
	@rm -rf oracle-xe-11.2.0
	@rm -f oracle-xe*.deb
	@rm -f *~
