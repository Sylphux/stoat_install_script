VERSION="1.3.0"
INSTALL_PATH="$HOME/.local/bin/"
FILE="Stoat-linux-x64-$VERSION.zip"
RELEASE_URL="https://github.com/stoatchat/for-desktop/releases/download/v$VERSION/Stoat-linux-x64-$VERSION.zip"
ICON_URL="https://raw.githubusercontent.com/stoatchat/assets/refs/heads/main/desktop/icon.ico"
ICON_PATH="$INSTALL_PATH/Stoat-linux-x64/icon.ico"
DESKTOP_FILE="$HOME/.local/share/applications/stoat.desktop"
echo "Welcome to this basic Stoat install/update script for linux."
echo "Version will $VERSION will be downloaded and installed / updated. This can be changed in the beginning of the script."
echo "Be sure to have chromium and all the required dependencies installed before proceeding."
echo "Please check for new versions at https://github.com/stoatchat/for-desktop/releases/"
echo ""
read -p "Press enter to continue or leave now: "
output=""
wget -O $FILE $RELEASE_URL && echo "Downloaded $FILE" && output="success" || output="failed"
if [ "$output" != "success" ]; then
    echo "Download failed. Check for release version or contact me for a fix."
    rm -rf $FILE
    echo "Exiting..."
    exit
fi
echo "Downloaded $FILE successfully."
unzip -o $FILE -d $INSTALL_PATH
echo "Version $VERSION installed."
echo "Downloading icon..."
wget -O $ICON_PATH $ICON_URL
echo "Creating entry for application..."
echo "[Desktop Entry]" > $DESKTOP_FILE
echo "Type=Application" >> $DESKTOP_FILE
echo "Name=Stoat" >> $DESKTOP_FILE
echo "GenericName=Stoat" >> $DESKTOP_FILE
echo "Comment=Stoat sandbox" >> $DESKTOP_FILE
echo "Icon=$ICON_PATH" >> $DESKTOP_FILE
echo "Exec=$INSTALL_PATH/Stoat-linux-x64/stoat-desktop" >> $DESKTOP_FILE
echo "Categories=Network;InstantMessaging;" >> $DESKTOP_FILE
echo "Terminal=false" >> $DESKTOP_FILE
echo "Keywords=Chat;Messaging;Stoat;" >> $DESKTOP_FILE
echo ""
echo "Installation complete. You can now launch Stoat. You can also use this script to update the application by changing the release version at the top of the script."
