#!/bin/bash

echo "
Desenvolvido por Marx F. C. Monte
Instalador do EditorLink v 1.5 (2025)
Para a Distribuição Debian 12 e derivados (antiX 23)
"


echo "
	MENU

[1] PARA INSTALAR
[2] PARA REMOVER
[3] PARA SAIR
"
read -p "OPÇÃO: " opcao

if [ "$opcao" = "1" ]; then
	echo -e "\nInstalação sendo iniciada...\n"
	if [ -d "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink" ]; then
		echo "O diretório EditorLink existe e será deletado..."
		rm -rf "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink"
		echo -e "O diretório EditorLink será criado...\n"
		mkdir "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink"
	else
		echo -e "O diretório EditorLink será criado...\n"
		mkdir "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink"
	fi
	if [ -d "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones" ]; then
		echo "O diretório Icones existe e será deletado..."
		rm -rf "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones"
		echo -e "O diretório Icones será criado...\n"
		mkdir "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones"
	else
		echo -e "O diretório Icones será criado...\n"
		mkdir "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones"
	fi
	if [ -e "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/EditorLnk_pt_br.exe" ]; then
		echo -e "O arquivo encontrado... Será atualizado...\n"
		rm "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/EditorLnk_pt_br.exe"
		wget -P "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink"\
		  https://github.com/marxfcmonte/Editor-de-Link-Windows-/blob/40a8eeb35f2fcba552a9527ea12eab6ba4d35b7b/EditorLnk_pt_br.exe
	else
		echo -e "O arquivo não encontrado... Será baixado...\n"
		rm "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/EditorLnk_pt_br.exe"
		wget -P "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink"\
		  https://github.com/marxfcmonte/Editor-de-Link-Windows-/raw/40a8eeb35f2fcba552a9527ea12eab6ba4d35b7b/EditorLnk_pt_br.exe
	fi
	if [ -e "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/EditorLink.lnk" ]; then
		echo -e "O arquivo encontrado... Será atualizado...\n"
		rm "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/EditorLink.lnk"
		wget -P "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink"\
		 https://github.com/marxfcmonte/Editor-de-Link-Windows-/raw/refs/heads/main/EditorLink.lnk
	else
		echo -e "O arquivo não encontrado... Será baixado...\n"
		wget -P "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink"\
		  https://github.com/marxfcmonte/Editor-de-Link-Windows-/raw/refs/heads/main/EditorLink.lnk
	fi	
	if [ -e "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones/editor.png" ]; then
		echo -e "O arquivo encontrado... Será atualizado...\n"
		rm "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones/editor.png"
		wget -P "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones"\
		  https://raw.githubusercontent.com/marxfcmonte/Editor-de-Link-Windows-/refs/heads/main/Icones/editor.png
	else
		echo -e "O arquivo não encontrado... Será baixado...\n"
		wget -P "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones"\
		  https://raw.githubusercontent.com/marxfcmonte/Editor-de-Link-Windows-/refs/heads/main/Icones/editor.png
	fi
	cat <<EOF > /home/$USER/.local/share/applications/LinkEditor.desktop
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=Link Editor (Windows) 
Name[pt_BR]=Editor de Link (Windows) 
GenericName=Link Editor (Windows) 
GenericName[pt_BR]=Editor de Link (Windows) 
Comment=Run Link Editor (Windows) 
Comment[pt_BR]=Executa Editor de Link (Windows)
Icon=/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones/editor.png
Terminal=false
Categories=GTK;Development;IDE;TextEditor;
Keywords=Text;Editor;
Keywords[fr_BE]=Text;Editor;texte;éditeur;
Keywords[pt_BR]=Editor;Texto;Ambiente de Desenvolvimento Integrado;IDE;Ferramenta de Programação;
Exec=env WINEPREFIX="/home/$USER/.wine" wine "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/EditorLink.lnk"

EOF
	cat <<EOF > /home/$USER/Desktop/LinkEditor.desktop
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=Link Editor (Windows) 
Name[pt_BR]=Editor de Link (Windows) 
GenericName=Link Editor (Windows) 
GenericName[pt_BR]=Editor de Link (Windows) 
Comment=Run Link Editor (Windows) 
Comment[pt_BR]=Executa Editor de Link (Windows)
Icon=/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/Icones/editor.png
Terminal=false
Categories=GTK;Development;IDE;TextEditor;
Keywords=Text;Editor;
Keywords[fr_BE]=Text;Editor;texte;éditeur;
Keywords[pt_BR]=Editor;Texto;Ambiente de Desenvolvimento Integrado;IDE;Ferramenta de Programação;
Exec=env WINEPREFIX="/home/$USER/.wine" wine "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink/EditorLink.lnk"

EOF
	
	echo "Os atalhos na Àrea de trabalho foram criados..."
	chmod 775 /home/$USER/.local/share/applications/LinkEditor.desktop
	chmod 775 /home/$USER/Desktop/LinkEditor.desktop
	desktop-menu --write-out-global
elif [ "$opcao" = "2" ]; then
	echo ""
	if [ -d "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink" ]; then
		echo "Os arquivos serão removidos..." 
		rm -rf "/home/$USER/.wine/drive_c/Program Files (x86)/EditorLink"
	else
		echo "O diretório não encontrado..."
	fi
	if [ -e "/home/$USER/.local/share/applications/LinkEditor.desktop" ]; then
		rm /home/$USER/.local/share/applications/LinkEditor.desktop
	else
		echo "O arquivo não encontrado..."
	fi
	if [ -e "/home/$USER/Desktop/LinkEditor.desktop" ]; then
		rm /home/$USER/Desktop/LinkEditor.desktop
	else
		echo "O arquivo não encontrado..."
	fi	 
elif [ "$opcao" = "3" ]; then
	echo -e "\nSaindo do instalador...\n" 
else
	echo -e "\nOpção inválida!!!\n" 
fi

sleep 2

echo 

exit 0
