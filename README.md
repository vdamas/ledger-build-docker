# ledger-build-docker
dockerfile for building a Ledger App. It's an builder alternative to https://github.com/fix/ledger-vagrant , I couldn't make work so I've tried with Docker!

## run

being:
 
    /home/user/apps -> your apps folder, 

    /home/user/apps/ledger-build-docker -> this project,

    /home/user/apps/app-cryptoescudo -> the project that you want to compile

running:

    connect ledger on usb host
    cd /home/user/apps/ledger-build-docker
    docker build . ##--> this will return an hash on the last line, eg: Successfully built c8638d26b08e
    cd ..
    docker run -it --privileged -v /dev/bus/usb:/dev/bus/usb -v /home/user/apps:/root/apps c8638d26b08e

then you can go to /root and compile it!

## compile example

	cd /root
	cd app-cryptoescudo
	make clean
	make
	
## upload binary (experimental)
	make load
	
## install binary (created in bin folder after running make)

I use my ledger on Windows and this were my steps:
	Copy bin folder content (4 files) to C:\temp\app-cryptoescudo\bin
	
Install python tools:
	pip install ledgerblue

Install nanos-secure-sdk (for creation of icon hex):

	git clone https://github.com/LedgerHQ/nanos-secure-sdk

Generate icon hex: 

	python.exe C:\temp\nanos-secure-sdk\icon.py 32 32 C:\temp\app-cryptoescudo\bin\nanos_app_cryptoescudo.gif hexbitmaponly
	output: 0100000000ffffff00ffffffffffffffff3ffc9ffb9fff9fff9fff9fff9ffb3ffcffffffffffffffff

Load app to ledger:

	python.exe -m ledgerblue.loadApp --targetId 0x31100004 --path "44'/111'" --fileName C:\temp\app-bitcoin\cryptoescudo\bin\app.hex --appName "CryptoEscudo" --tlv --delete --icon 0100000000ffffff00ffffffffffffffff3ffc9ffb9fff9fff9fff9fff9ffb3ffcffffffffffffffff --dep Bitcoin





