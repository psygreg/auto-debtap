#!/bin/sh
echo "Language:"
select lang in "en-US" "pt-BR"; do
  case $lang in
    en-US )
      echo "This is *Psygreg's AutoDebtap* script.";
      echo "It can convert and install an application from a .deb package.";
      echo "Remember, it must only be used if an application doesn't provide any versions for Arch and there are no builds available in the AUR.";
      echo "This script also may not be able to install all dependencies necessary for the package, and you may have to install them yourself if so."
      echo "Do you want to proceed?";
      select yn in "Yes" "No"; do
        case $yn in
          Yes )
            yay -S --needed --noconfirm debtap;
            read -p "Copy the path to the *.deb package and paste it here:" debpath;
            debtap $debpath;
            read -p "Now, copy the path to the *.pkg.tar.zst converted file here:" pkgpath;
            sudo pacman -U --needed --noconfirm $pkgpath
            echo "Done. You may now use your software."
            exit 0;;
          No )
            echo "Operation cancelled."
            exit 0;;
        esac
      done;;
    pt-BR )
      echo "Este é o script *Psygreg's AutoDebtap*.";
      echo "Ele irá converter e instalar uma aplicação de um pacote .deb.";
      echo "Lembre-se que isto só deve ser utilizado se uma aplicação não oferece versões para Arch e não houver builds disponíveis no AUR.";
      echo "Este script também pode não conseguir instalar todas as dependências necessárias para o pacote, e você terá que instalá-las você mesmo neste caso."
      echo "Prosseguir?";
      select sn in "Sim" "Não"; do
        case $sn in
          Sim )
            yay -S --needed --noconfirm debtap;
            read -p "Copie o caminho do arquivo *.deb aqui:" debpath;
            debtap $debpath;
            read -p "Agora, copie o caminho do arquivo convertido *.pkg.tar.zst aqui:" pkgpath;
            sudo pacman -U --needed --noconfirm $pkgpath
            echo "Feito. Você pode usar a aplicação agora."
            exit 0;;
          Não )
            echo "Operação cancelada."
            exit 0;;
        esac
      done;;
  esac
done
