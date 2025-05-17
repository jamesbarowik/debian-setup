sudo apt install nala -y

sudo nala update
sudo nala upgrade -y

sudo nala remove firefox-esr zutty kate sweeper kmag kmousetool kwrite kmouth kaddressbook knotes xterm kwalletmanager juk dragonplayer konqueror imagemagick-6.q16 kmail kdeconnect akregator kontrast gwenview korganizer -y

sudo nala install curl libgtkglext1 fonts-liberation libu2f-udev git gh -y

TEMP_DIR=$(mktemp -d)
cd $TEMP_DIR

sudo rm -fv /etc/apt/sources.list.d/thorium.list
sudo curl http://dl.thorium.rocks/debian/dists/stable/thorium.list -o /etc/apt/sources.list.d/thorium.list
sudo nala update
sudo nala install -y thorium-browser

curl -Lo discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo nala install -y discord.deb
