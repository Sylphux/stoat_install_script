# All variables below this line can be edited to customize your installation.

VERSION=1.3.0 # Fallback version if auto latest release detection is not used. This can be changed if necessary.
INSTALL_PATH="$HOME/.local/bin/"
ICON_PATH="$INSTALL_PATH/Stoat-linux-x64/icon.ico"

# Don't touch anything below here unless you know what you are doing.

echo "Welcome to this basic Stoat install/update script for Linux."
echo "Would you like to find the latest release available ? If not, the script will default to version $VERSION."
read -p "Search for latest release ? (Y/n): " ask
echo ""
if [ "$ask" != "n" ]; then
    echo "Please wait while script finds the latest release version..."
    FOUND_VERSION=$(searchitem=$(curl -v https://github.com/stoatchat/for-desktop 2>&1 | grep -E '\<span\sclass\=\"css-truncate\scss\-truncate-target\stext-bold\smr-2"\sstyle=\"max-width\:\snone\;\">v([0-9]\.[0-9]+\.[0-9]+)<\/span\>'); grep -Po '([0-9]\.[0-9]+\.[0-9]+)' <<< $searchitem)
    if ! [[ "$FOUND_VERSION" =~ [0-9]\.[0-9]+\.[0-9]+ ]]; then
        echo "Error retrieving latest version. Defaulting to $VERSION"
    else
        VERSION="$FOUND_VERSION"
        echo ""
        echo "Version $VERSION was automatically detected as the latest release. It will be downloaded and installed/updated."
    fi
else
    echo "Defaulting to version $VERSION. This can be changed on the first line of the script."
fi

FILE="Stoat-linux-x64-$VERSION.zip"
RELEASE_URL="https://github.com/stoatchat/for-desktop/releases/download/v$VERSION/Stoat-linux-x64-$VERSION.zip"
ICON_URL="https://raw.githubusercontent.com/stoatchat/assets/refs/heads/main/desktop/icon.ico"
DESKTOP_FILE="$HOME/.local/share/applications/stoat.desktop"

echo "Be sure to have chromium and all the required dependencies installed before proceeding."
echo ""
read -p "Continue ? (Y/n): " ask
if [ "$ask" = "n" ]; then
    echo "Exiting."
    exit
fi
wget -O $FILE $RELEASE_URL && echo "Downloaded $FILE" && output="success" || output="failed"
if [ "$output" != "success" ]; then
    echo "Download failed. Check for release version or create an issue in the repo."
    rm -rf $FILE
    echo "Exiting."
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
echo "Comment=Open source user-first chat platform." >> $DESKTOP_FILE
echo "Icon=$ICON_PATH" >> $DESKTOP_FILE
echo "Exec=$INSTALL_PATH/Stoat-linux-x64/stoat-desktop" >> $DESKTOP_FILE
echo "Categories=Network;InstantMessaging;" >> $DESKTOP_FILE
echo "Terminal=false" >> $DESKTOP_FILE
echo "Keywords=Chat;Messaging;Stoat;" >> $DESKTOP_FILE
echo ""
echo "Installation/update complete. You can now launch Stoat. You can also use this script to update the application by running the script again when there is a new release."
