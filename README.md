# CrossOver Ticket System Challenge

[![Build Status](http://drone.niltonvasques.com.br/api/badges/niltonvasques/pms-rails/status.svg)](http://drone.niltonvasques.com.br/niltonvasques/crossover-ticket-system)
[![Coverage](https://img.shields.io/badge/coverage-97%25-brightgreen.svg)](https://img.shields.io/badge/coverage-97%25-brightgreen.svg)

## Contents

- [Requirements](#requirements)
- [Design Architecture](#design-architecture)
- [Setup](#setup)
- [Code Style](#code-style)
- [Screenshots](#screenshots)

## Requirements

### Functional

#### Customers

* The user should be able to create customer accounts
* The user should be able to authenticate in the system
* The customer can create a request
* The customer can add comments in your own requests
* The customer can see their own requests (and cannot see requests created by others customers)
* The agent can close own requests

#### Agents

* The agent can authenticate in the system
* The agent cannot create a request
* The agent can add comments in any request
* The agent can generate reports that contains requests closed in last month (i.e last 30 days) in pdf format       
* The agent can close any request

#### Admins


* The admin can authenticate in the system
  - In web frontend the admin should be redirect to admin panel to manage system objects (requests and users)
* The admin can generate reports that contains requests closed in last month (i.e last 30 days) in pdf format

### Non Functional

* Database: MySQL server
* Backend: server framework Ruby on Rails on back end
  - GraphQL API (~~REST API~~)
  - Rspec
  - Code style and quality tools (rubocop, brakeman, flay, fasterer)
  - Coverage > 30% 
* Frontend: React Native JS framework to build hybrid applications
  - Single Page Application pattern with responsive design with React Native (JS) Framework
  - Tests with Qunit/Jasmine/Karma.
  
* Secure the applications and services.

## Design Architecture

#### High Level Architecture

![High Level Architecture](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/docs/High%20Level%20Arquitecture.jpg)

#### Frontend Architecture

![Frontend Architecture](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/docs/Frontend%20Arquitecture.jpg)

#### Data Model

![Data model](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/docs/Data%20Model.png)

## Setup

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

## Running tests

  rspec

## Code Style

* [Ruby Code Style](https://github.com/bbatsov/ruby-style-guide#dont-hide-exceptions)
* [Rubocop Defaults](https://github.com/bbatsov/rubocop/blob/master/config/enabled.yml)


## Screenshots

![Android Main scene](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/docs/android%20main%20scene.png)
![Web Main scene](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/docs/web%20main%20scene.png)
![Web Admin Panel](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/docs/web%20admin%20panel.png)
![Web Requests](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/docs/admin%20request%203.png)

