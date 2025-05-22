#!/bin/bash

echo "
Desenvolvido por Marx F. C. Monte
Instalador do EditorLink v 1.5 (2025)
Para a Distribuição Debian 12 e derivados (antiX 23)
"

if [ "$USER" != "root" ]; then
	echo "Use comando 'sudo'  ou comando 'su' antes de inicializar o programa.
"
	exit 1	
fi

echo "
	MENU

[1] PARA INSTALAR
[2] PARA REMOVER
[3] PARA SAIR
"
read -p "OPÇÃO: " opcao

if [ "$opcao" = "1" ]; then
	echo -e "\nInstalação sendo iniciada...\n"
	if [ -d "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink" ]; then
		echo "O diretório EditorLink existe e será deletado..."
		rm -rf "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink"
		echo -e "O diretório EditorLink será criado...\n"
		mkdir "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink"
		mkdir "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones"
		wget -P "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink"\
		  https://github.com/marxfcmonte/Editor-de-Link-Windows-/raw/refs/heads/main/EditorLnk_pt_br.exe
		wget -P "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink"\
		 https://github.com/marxfcmonte/Editor-de-Link-Windows-/raw/refs/heads/main/EditorLink.lnk
		wget -P "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones"\
		  https://raw.githubusercontent.com/marxfcmonte/Editor-de-Link-Windows-/refs/heads/main/Icones/editor.png
	else
		echo -e "O diretório EditorLink será criado...\n"
		mkdir "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink"
		mkdir "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones"
		wget -P "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink"\
		  https://github.com/marxfcmonte/Editor-de-Link-Windows-/raw/refs/heads/main/EditorLnk_pt_br.exe
		wget -P "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink"\
		 https://github.com/marxfcmonte/Editor-de-Link-Windows-/raw/refs/heads/main/EditorLink.lnk
		wget -P "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones"\
		  https://raw.githubusercontent.com/marxfcmonte/Editor-de-Link-Windows-/refs/heads/main/Icones/editor.png
	fi
	cat <<EOF > /usr/share/applications/LinkEditor.desktop
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=Link Editor (Windows) 
Name[pt_BR]=Editor de Link (Windows) 
GenericName=Link Editor (Windows) 
GenericName[pt_BR]=Editor de Link (Windows) 
Comment=Run Link Editor (Windows) 
Comment[pt_BR]=Executa Editor de Link (Windows)
Icon=/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones/editor.png
Terminal=false
Categories=GTK;Development;IDE;TextEditor;
Keywords=Text;Editor;
Keywords[fr_BE]=Text;Editor;texte;éditeur;
Keywords[pt_BR]=Editor;Texto;Ambiente de Desenvolvimento Integrado;IDE;Ferramenta de Programação;
Exec=env WINEPREFIX="/home/$SUDO_USER/.wine" wine "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink/EditorLink.lnk"

EOF
	cat <<EOF > /home/$SUDO_USER/Desktop/LinkEditor.desktop
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=Link Editor (Windows) 
Name[pt_BR]=Editor de Link (Windows) 
GenericName=Link Editor (Windows) 
GenericName[pt_BR]=Editor de Link (Windows) 
Comment=Run Link Editor (Windows) 
Comment[pt_BR]=Executa Editor de Link (Windows)
Icon=/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones/editor.png
Terminal=false
Categories=GTK;Development;IDE;TextEditor;
Keywords=Text;Editor;
Keywords[fr_BE]=Text;Editor;texte;éditeur;
Keywords[pt_BR]=Editor;Texto;Ambiente de Desenvolvimento Integrado;IDE;Ferramenta de Programação;
Exec=env WINEPREFIX="/home/$SUDO_USER/.wine" wine "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink/EditorLink.lnk"

EOF
	
	echo "Os atalhos na Àrea de trabalho foram criados..."
	chmod +x /usr/share/applications/LinkEditor.desktop
	chmod 775 /home/$SUDO_USER/Desktop/LinkEditor.desktop
	desktop-menu --write-out-global
elif [ "$opcao" = "2" ]; then
	echo ""
	if [ -d "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink" ]; then
		echo "Os arquivos serão removidos..." 
		rm -rf "/home/$SUDO_USER/.wine/drive_c/Program Files (x86)/EditorLink"
	else
		echo "O diretório não encontrado..."
	fi
	if [ -e "/home/$SUDO_USER/.local/share/applications/LinkEditor.desktop" ]; then
		rm /home/$SUDO_USER/.local/share/applications/LinkEditor.desktop
	else
		echo "O arquivo não encontrado..."
	fi
	if [ -e "/home/$SUDO_USER/Desktop/LinkEditor.desktop" ]; then
		rm /home/$SUDO_USER/Desktop/LinkEditor.desktop
	else
		echo "O arquivo não encontrado..."
	fi	 
	desktop-menu --write-out-global
elif [ "$opcao" = "3" ]; then
	echo -e "\nSaindo do instalador...\n" 
else
	echo -e "\nOpção inválida!!!\n" 
fi

sleep 2

echo 

exit 0
