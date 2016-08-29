#!/bin/sh

set -v

echo "Installing Taupage ..."

mkdir -vp /etc/kubernetes/manifests /opt/bin /opt/taupage || exit 1
cp -v /tmp/taupage/cloud-config.yml /etc/cloud-config.yml || exit 1
cp -rv /tmp/taupage/sidecar-definition /etc/sidecars || exit 1
cp -v /tmp/taupage/systemd/* /etc/systemd/system || exit 1
cp -rv /tmp/taupage/scripts/ /opt/taupage

/usr/bin/curl -L -o /opt/bin/kubelet https://storage.googleapis.com/kubernetes-release/release/v1.3.0/bin/linux/amd64/kubelet || exit 1
/usr/bin/chmod -v +x /opt/bin/kubelet || exit 1

systemctl daemon-reload || exit 1
systemctl enable kubelet.service || exit 1
#systemctl enagle taupage-sysctl.service || exit 1
#systemctl enable berry.service || exit 1

if [ -f /usr/share/oem/cloud-config.yml ]; then
    sudo sed -i 's#--oem=ec2-compat#--file=/etc/cloud-config.yml#' /usr/share/oem/cloud-config.yml || exit 1
fi

#sudo passwd -d core || exit 1

echo " Taupage Installation successful"
