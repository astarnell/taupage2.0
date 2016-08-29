
SYSTEMD_FILES = $(shell find src/systemd -name '*.service')
SIDECAR_FILES = 
SCRIPT_FILES = $(shell find src/scripts -name '*.sh')

PACKER_INSTALATION = src/install.sh src/cloud-config.yml $(SYSTEMD_FILES) $(SCRIPT_FILES) $(SIDECAR_FILES)
VBOX_PREPARE = VirtualBox/prepare.sh VirtualBox/cloud-config.yaml

all: Vagrant

ami: packer.json $(VBOX_PREPARE) $(PACKER_INSTALATION)
	packer build -only=amazon-ebs packer.json

output-virtualbox-iso/box.ovf: packer.json $(VBOX_PREPARE) $(PACKER_INSTALATION)
	packer build -force -only=virtualbox-iso packer.json
    
packer.box: output-virtualbox-iso/box.ovf tmp/Vagrantfile
	cd output-virtualbox-iso &&	cp ../tmp/Vagrantfile . && tar cfz ../taupage.box * && cd ..
	vagrant box remove -f --all ./taupage.box || exit 0
    
clean:
	rm -rf output-virtualbox-iso
	rm taupage.box

VirtualBox: output-virtualbox-iso/box.ovf

Vagrant: packer.box

