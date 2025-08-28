#!/bin/bash
set -e

GREEN='\033[0;32m'
NC='\033[0m'

MYSQL_RPM_URL="https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm"

echo -e "${GREEN}=== Update system & install MySQL ===${NC}"
sudo dnf update -y
sudo dnf install -y wget git

if [ ! -f mysql80-community-release-el9-1.noarch.rpm ]; then
  sudo wget $MYSQL_RPM_URL
fi

# Add mysql repository
sudo dnf install -y mysql80-community-release-el9-1.noarch.rpm
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023

# Install mysql client only
sudo dnf install -y mysql

mysql -V

echo -e "${GREEN}=== Clone app from Github ===${NC}"
if [ ! -d "AWS-FCJ-Management" ]; then
  git clone https://github.com/AWS-First-Cloud-Journey/AWS-FCJ-Management
fi

cd AWS-FCJ-Management

echo -e "${GREEN}=== Create .env file ===${NC}"
cat <<EOF > .env
DB_HOST=$DB_HOST
DB_NAME=$DB_NAME
DB_USER=$DB_USER
DB_PASS=$DB_PASS
EOF

echo -e "${GREEN}=== Install NodeJS & NPM ===${NC}"
# Load nvm if available
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if ! command -v nvm &> /dev/null; then
  # Install nvm
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  source ~/.nvm/nvm.sh
fi

nvm install 22
nvm use 22

node -v
npm -v

npm install -g npm@latest

if [ ! -f package.json ]; then
  npm init -y
  echo -e "${GREEN}Added package.json.${NC}"
fi

echo -e "${GREEN}Installing npm packages...${NC}"
npm install -y express dotenv express-handlebars body-parser mysql semver
npm install -y

echo -e "${GREEN}Installing nodemon...${NC}"
npm install --save-dev nodemon
npm install -g nodemon




echo -e "${GREEN}=== Init DB ===${NC}"
mysql -h "$DB_HOST" -P 3306 -u "$DB_USER" -p"$DB_PASS" < /tmp/init_db.sql

echo -e "${GREEN}=== Start App ===${NC}"
cd ~/AWS-FCJ-Management
npm start 