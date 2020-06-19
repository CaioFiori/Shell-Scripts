#!/bin/bash

#Script que raliza o backup da home do usuário que estiver logado no momento, é criado um diretório chamado "Backup" dentro da home do usuário, local onde será armazenados os arquivos de backup.



DIRBACKUP="/home/$USER/Backup"
DATACOMPLETA=$(date +%F | tr -d -)
HORA=$(date +%R | tr -d :)
ULTIMOSBACKUPS=$(find $DIRBACKUP -ctime -7  -name backup\*)

clear 

if [ ! -d $DIRBACKUP ]
then
	echo "O diretório está sendo criado .."
	mkdir -p $DIRBACKUP
fi


if [ "$ULTIMOSBACKUPS" ]
then
	echo "Já foi feito um backup nos últimos 7 dias"
	read -p "Deseja continuar? (s:N): " ESCOLHA
	
	case "$ESCOLHA" in
		s) 
			tar -cvpzf $DIRBACKUP/backup_home_"$DATACOMPLETA""$HORA".tgz --absolute-names $HOME --exclude="$DIRDEST"
			echo -e "\nO backup foi criado no destino $DIRBACKUP\n"
			;;
		S)
			tar -cvpzf $DIRBACKUP/backup_home_"$DATACOMPLETA""$HORA".tgz --absolute-names $HOME --exclude="$DIRDEST"
			echo -e "\nO backup foi criado no destino $DIRBACKUP\n"
			;;
		n)
			exit 1
			;;
		N)
			exit 1
			;;
		*)
			echo "Opção Inválida!"
	esac


else
	tar -cvpzf $DIRBACKUP/backup_home_"$DATACOMPLETA""$HORA".tgz --absolute-names $HOME --exclude="$DIRDEST"
	echo -e "\nO backup foi criado no destino $DIRBACKUP\n"
	
fi
