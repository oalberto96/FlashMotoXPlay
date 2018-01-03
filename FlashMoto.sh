#!/bin/bash

CustomLogo(){
	
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "~~~~~~~~~~~~~~~~~~~~~|Custom Logo|~~~~~~~~~~~~~~~~~~~~~~~"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "Ingresa la ubicacion de fastboot"
	read path_fastboot
	echo "Ingrese Ubicacion del nuevo logo (logo.bin)"
	read path_firmware
	sudo $path_fastboot/./fastboot flash logo $path_firmware/logo.bin
}


CustomRecovery(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "~~~~~~~~~~~~~~~~~|Custom Recovery|~~~~~~~~~~~~~~~~~~~~~~~"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "Ingresa la ubicacion de fastboot"
	read path_fastboot
	echo "Ingrese Ubicacion del nuevo recovery (recovery.img)"
	read path_firmware
	sudo $path_fastboot/./fastboot flash recovery $path_firmware/recovery.img
	echo "Recovery actualizado..."
}

Formateo (){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~|Formateo|~~~~~~~~~~~~~~~~~~~~~~~"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "Ingresa la ubicacion de fastboot"
	read path_fastboot
	echo "Ingrese Ubicacion de Firmware"
	read path_firmware
	sudo $path_fastboot/./fastboot flash partition $path_firmware/gpt.bin
	sudo $path_fastboot/./fastboot flash bootloader $path_firmware/bootloader.img
	sudo $path_fastboot/./fastboot flash logo $path_firmware/logo.bin
	sudo $path_fastboot/./fastboot flash boot $path_firmware/boot.img
	sudo $path_fastboot/./fastboot flash recovery $path_firmware/recovery.img
	for (( i = 0; i < 10; i++ )) do
		sudo $path_fastboot/./fastboot flash system $path_firmware/system.img_sparsechunk.$i
	done
	sudo $path_fastboot/./fastboot flash modem $path_firmware/NON-HLOS.bin
	sudo $path_fastboot/./fastboot erase modemst1
	sudo $path_fastboot/./fastboot erase modemst2
	sudo $path_fastboot/./fastboot flash fsg $path_firmware/fsg.mbn
	sudo $path_fastboot/./fastboot erase cache
	sudo $path_fastboot/./fastboot erase userdata
	sudo $path_fastboot/./fastboot reboot
	echo "Formateo exitoso!"
}


while [[ $Opcion != 4 ]]; do
	clear
	echo "Formateo Moto X play"
	echo "Ingrese una opcion"
	echo "1.-Formateo"
	echo "2.-Custom Recovery"
	echo "3.-Custom Logo"
	echo "4.-Salir"
	read Opcion
	case "$Opcion" in 
	"1") Formateo ;;
	"2") CustomRecovery ;;
	"3") CustomLogo ;;
	*) Comando Invalido ;;
	esac
done




