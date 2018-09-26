# README

## Development setup

```sh
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev yarn

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
echo 'export PATH=$PATH:/home/buhrmi/.rbenv/bin' >> ~/.bashrc
echo 'eval "$(rbenv init -)"'  >> ~/.bashrc

rbenv install 2.5.1
rbenv global 2.5.1

gem install bundler

bundle install
yarn install

rbenv rehash

rails db:migrate
rails s
```