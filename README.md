# CrossOver Ticket System Challenge

[![Build Status](http://drone.niltonvasques.com.br/api/badges/niltonvasques/pms-rails/status.svg)](http://drone.niltonvasques.com.br/niltonvasques/crossover-ticket-system)
[![Coverage](https://img.shields.io/badge/coverage-97%25-brightgreen.svg)](https://img.shields.io/badge/coverage-97%25-brightgreen.svg)

### Setup

#### Requirements

* rvm
* libmysqlclient-dev
* A mysql database (Or using the docker compose file to create one)

#### Production setup

    export SECRET_KEY_BASE=somesecretkeybase

#### Preparing environment 

Using RVM to safetly install ruby and rails through it

First of all, install required libs to use some gems

    apt-get install libmysqlclient-dev cmake pkg-config

Installing ruby with RVM

    curl -L https://get.rvm.io | bash -s stable # sometimes you need to import gpg keys, for it, see https://rvm.io/rvm/install 

Enabling RVM

    source ~/.rvm/scripts/rvm

Loading RVM

    rvm requirements

Installing ruby in version that we use now, with RVM

    rvm install 2.2.5

Install rails with RVM

    gem install rails -v 5.0.1 --no-rdoc --no-ri

Clone repo

    git clone https://github.com/niltonvasques/crossover-ticket-system

Updating git submodules

    cd crossover-ticket-system
    git submodule update --init --recursive


If you wish to use docker, you shall download the specific container

    docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=password -d mysql:latest

Export the required enviroment variables with some infos:

To avoid too many edits in database file I put environments variables there too. So, for launch the app in development mode is required export these env vars:

    export MYSQL_HOST=IP_DO_HOST
    export MYSQL_PASSWORD=MY_UNBREAKABLE_PASS

Install gems

    bundle install --jobs 5 --verbose --retry 4 # Jobs enable paralels gems download

Create database if it still not exists and run migrations and seed.

    rake db:create
    rake db:migrate
    rake db:seed

#### Running tests

  rspec

## Code Style

* [Ruby Code Style](https://github.com/bbatsov/ruby-style-guide#dont-hide-exceptions)
* [Rubocop Defaults](https://github.com/bbatsov/rubocop/blob/master/config/enabled.yml)
