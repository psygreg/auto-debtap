#!/bin/sh
##VARS
PACINSTAL="sudo pacman -U --needed --noconfirm $pkgpath"
TAPDEB="debtap $debpath"
YAYDEB="yay -S --needed --noconfirm debtap"
##FUNCTIONS
#get language from OS
get_lang() {
    local lang="${LANG:0:2}"
    local available=("pt" "en")

    if [[ " ${available[*]} " == *"$lang"* ]]; then
        ulang="$lang"
    else
        ulang="en"
    fi
}
#yay check
yay_func() {
	if pacman -Qs yay > /dev/null; then
        echo "YAY already installed, proceeding..."
    else
        cd && pacman -S --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd && rm -r ~/yay
    fi
}
##SCRIPT RUN START
#check if distro is arch-based
if command -v pacman &> /dev/null; then
    echo "Pacman detected. Starting..."
else
    echo "Pacman not detected."
    exit 1
fi
#yay check
yay_func
#get language
get_lang
#en-US
if [ "$ulang" == "en" ]; then
    echo "This is *Psygreg's AutoDebtap* script."
    echo "It can convert and install an application from a .deb package."
    echo "Remember, it must only be used if an application doesn't provide any versions for Arch and there are no builds available in the AUR."
    echo "This script also may not be able to install all dependencies necessary for the package, and you may have to install them yourself if so."
    echo "Do you want to proceed?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes )
                eval "$YAYDEB";
                read -p "Copy the path to the *.deb package and paste it here:" debpath;
                eval "$TAPDEB";
                read -p "Now, copy the path to the *.pkg.tar.zst converted file here:" pkgpath;
                eval "$PACINSTAL";
                echo "Done. You may now use your software.";
                exit 0;;
            No )
                echo "Operation cancelled."
                exit 0;;
        esac
    done
#pt-BR
elif [ "$ulang" == "pt" ]; then
    echo "Este é o script *Psygreg's AutoDebtap*.";
    echo "Ele irá converter e instalar uma aplicação de um pacote .deb.";
    echo "Lembre-se que isto só deve ser utilizado se uma aplicação não oferece versões para Arch e não houver builds disponíveis no AUR.";
    echo "Este script também pode não conseguir instalar todas as dependências necessárias para o pacote, e você terá que instalá-las você mesmo neste caso."
    echo "Prosseguir?";
    select sn in "Sim" "Não"; do
        case $sn in
            Sim )
                eval "$YAYDEB";
                read -p "Copie o caminho do arquivo *.deb aqui:" debpath;
                eval "$TAPDEB";
                read -p "Agora, copie o caminho do arquivo convertido *.pkg.tar.zst aqui:" pkgpath;
                eval "$PACINSTAL";
                echo "Feito. Você pode usar a aplicação agora.";
                exit 0;;
            Não )
                echo "Operação cancelada.";
                exit 0;;
        esac
    done
fi
