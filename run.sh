echo "Provisioning virtual machine..."

echo "Installing Utilities"
dpkg --add-architecture i386
apt-get update  > /dev/null

apt-get install software-properties-common -y
add-apt-repository main
add-apt-repository universe
add-apt-repository restricted
add-apt-repository multiverse

apt-get update  > /dev/null

apt-get install git curl udev python-dev python3-pip python-pil python-setuptools zlib1g-dev libjpeg-dev libudev-dev build-essential libusb-1.0-0-dev -y #> /dev/null
apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 libc6-dev-i386 wget gcc-arm-none-eabi libc6-dev-i386 -y #> /dev/null

pip3 install --upgrade pip
pip3 install --upgrade setuptools
pip3 install ledgerblue

update-alternatives --install /usr/bin/python python /usr/bin/python3 1

echo "Setting up BOLOS environment"
mkdir /opt/bolos
cd /opt/bolos

echo "Installing custom compilers, can take a few minutes..."
wget -q https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q1-update/+download/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2
tar xjf gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2 --no-same-owner
ln -s /opt/bolos/gcc-arm-none-eabi-5_3-2016q1/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc

wget -q http://releases.llvm.org/4.0.0/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
tar xvf clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz --no-same-owner
mv clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-14.04 clang-arm-fropi
chmod 757 -R clang-arm-fropi/
chmod +x clang-arm-fropi/bin/clang
ln -s /opt/bolos/clang-arm-fropi/bin/clang /usr/bin/clang

echo "cloning sdk for nano s"
cd /opt/bolos/
git clone https://github.com/LedgerHQ/nanos-secure-sdk.git
cd nanos-secure-sdk/
#git checkout tags/nanos-131
git checkout master
cd /opt/bolos/

echo "finetuning rights for usb access"
wget -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | bash

echo "Setting up bash profile"
echo "" >> /root/.bashrc
echo "# Custom variables for Ledger Development" >> /root/.bashrc
echo "export BOLOS_ENV=/opt/bolos" >> /root/.bashrc
echo "export BOLOS_SDK=/opt/bolos/nanos-secure-sdk" >> /root/.bashrc
echo "export ARM_HOME=/opt/bolos/gcc-arm-none-eabi-5_3-2016q1" >> /root/.bashrc
echo "" >> /root/.bashrc
echo "export PATH=\$PATH:\$ARM_HOME/bin" >> /root/.bashrc

export BOLOS_ENV=/opt/bolos
export BOLOS_SDK=/opt/bolos/nanos-secure-sdk
export ARM_HOME=/opt/bolos/gcc-arm-none-eabi-5_3-2016q1
export PATH=\$PATH:\$ARM_HOME/bin
