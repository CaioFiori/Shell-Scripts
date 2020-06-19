#!/bin/bash

############################################################################################################################		
# Nome: Script De Backup V1.0			      								            #
# Autor: Caio Fiori													    #
# 															    #
# Descrição: O script realiza o backup remoto ou local de arquivos e diretórios, possibilita uma maior compreenção          #
# para usuários com pouco conhecimento. 										    #
#												                            #
# Requisitos Necessários: Caso queira realizar um backuo remoto, é necessário que ambas as máquinas possuam o SSH instalado #
#														            #
# Formas de Uso: ./ScriptBackupV1.0.sh											    #
#############################################################################################################################



# Diretório que será criado por padrão na opção de backup local caso o usuário queira.
# Essa variável deve ser alterada por cada usuário, informando o diretório na qual queira como padrão.
DIRPADRAO="/home/caiofiori/Backups"

clear

# Menu de escolha: Backup local ou Backup remoto:
echo -e "Escolha uma opção de Backup:\n 1 - Buckup Local\n 2 - Backup Remoto\n"
read -p "Opção: " TIPOBACKUP


case "$TIPOBACKUP" in
	1)
		read -p "Qual diretório você deseja realizar o backup?: " DIRORIGEM
     
		if [ -d "$DIRORIGEM" ]
		then
			echo -e "\nDIRETÓRIO VÁLIDO!\n"	
			read -p "Deseja utilizar o diretório padrão como destino do backup? ($DIRPADRAO) -> [S/N]: " ESCOLHAPADRAO
			
			if [ $ESCOLHAPADRAO == "S" ]
			then
				rsync -vah $DIRORIGEM $DIRPADRAO
			fi


			if [ $ESCOLHAPADRAO == "N" ]
			then
				read -p "Qual o diretório de destino escolhido?: " DIRDESTINO

				if [ -d "$DIRDESTINO" ]
				then
					echo "DIRETÓRIO VÁLIDO"
					rsync -vah $DIRORIGEM $DIRDESTINO
				else
					echo -e "\nDiretório não encontrado!\n"
					read -p "Deseja criar este diretório? -> [S/N]: " CRIADIRETORIO
					
					case "$CRIADIRETORIO" in
						S)
							mkdir $DIRDESTINO
							echo -e "\nDiretório criado com sucesso!\nRealizando o Backup!!"
							rsync -vah $DIRORIGEM $DIRDESTINO
							;;
						N)
							exit
							;;

						*)
							echo -e "\nOpção Inválida\nFim da execução!"
					esac
							
				fi			
	 		fi

		else
			echo -e "Diretório Inválido\nFim da execução!"
		fi		
		;;


# Parte referente ao backup remoto:		
	2)
		read -p "- Qual diretório você deseja realizar o backup?: " DIRORIGEM
		read -p "- Digite o Nome do usuário da máquina remota: " USUARIOREMOTO
		read -p "- Digite o endereço local do usuário: " IPUSUARIO
		read -p "- Informa o diretório de destino na máquina remota: " DIRDESTINOREMOTO
	
		echo -e "\n"

		if [ -d "$DIRORIGEM" ]
		then
			rsync -vabh $DIRORIGEM $USUARIOREMOTO@$IPUSUARIO:$DIRDESTINOREMOTO
		
		else
			echo "Diretório inválido"
		fi
		;;

	*)
		echo -e "\nOpção Inválida"
		echo "Fim da Execução !!"

esac

