# CrossOver Ticket System Challenge

[![Build Status](http://drone.niltonvasques.com.br/api/badges/niltonvasques/pms-rails/status.svg)](http://drone.niltonvasques.com.br/niltonvasques/crossover-ticket-system)
[![Coverage](https://img.shields.io/badge/coverage-97%25-brightgreen.svg)](https://img.shields.io/badge/coverage-97%25-brightgreen.svg)

### Setup

#### Requirements

* rvm
* libmysqlclient-dev
* A mysql database (Or using the docker compose file to create one)

#### Production setup

    export MYSQL_ROOT_PASSWORD=SOMEPASS
    export AMAZON_S3_BUCKET=somebucket
    export AMAZON_ACCESS_KEY=somekey
    export AMAZON_SECRET_KEY=somesecret
    export SECRET_KEY_BASE=somesecretkeybase
    export HOST_URL=someurl.com
    export CDN_HOST_URL=some.cdn.host
    export GOOGLE_MAPS_API_KEY=somegmapsapikey

#### Preparing environment 

Using RVM to safetly install ruby and rails through it

First of all, install required libs to use some gems

    apt-get install libmysqlclient-dev libmagic-dev cmake pkg-config

Installing ruby with RVM

    curl -L https://get.rvm.io | bash -s stable # sometimes you need to import gpg keys, for it, see https://rvm.io/rvm/install 

Enabling RVM

    source ~/.rvm/scripts/rvm

Loading RVM

    rvm requirements

Installing ruby in version that we use now, with RVM

    rvm install 2.2.3

Install rails with RVM

    gem install rails -v 4.2.4 --no-rdoc --no-ri

Clone repo

    git clone https://github.com/USER/pms-rails

Updating git submodules

    cd pms-rails
    git submodule update --init --recursive


If you wish to use docker, you shall download the specific container

    docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=pms-rails-pwd -d mysql:latest

Export the required enviroment variables with some infos:

To avoid too many edits in database file I put environments variables there too. So, for launch the app in development mode is required export these env vars:

    export MYSQL_HOST=IP_DO_HOST
    export PMS_MYSQL_PASSWORD=MY_UNBREAKABLE_PASS
    export GOOGLE_MAPS_API_KEY=somegmapsapikey

Install gems

    bundle install --jobs 5 --verbose --retry 4 # Jobs enable paralels gems download

Create database if it still not exists and run migrations and seed.

    rake db:create
    rake db:migrate
    rake db:seed

#### Useful rake tasks

Populate a development database with some data for test purposes:

    rake db:populate

Create a random request in database:

    rake db:create_request

Update the i18n js locales:

    rake i18n:js:export

#### Translate locales

    i18n-tasks translate-missing --from pt-BR -l en
    i18n-tasks translate-missing --from en -l ru, pl, nl, es, fr, de

#### Running tests

Start the guard server, that is a file monitor that run the tests when the files changes.

  rspec

Inside guard if you want run all tests you can just type: `all`


###Team

* Nilton Vasques [mailto:nilton.vasques@openmailbox.org]
* Tiago Gonçalves [mailto:santos.tiago@kaefer.com]
* Vinicius Lins [mailto:gesteiravl@openmailbox.org]


###Contribute with the project

Fork me

Clone your fork

Add the original project as upstream 

    git remote add  upstream https://github.com/niltonvasques/pms-rails

Fetch updates from upstream

    git fetch upstream --all --prune

Go to master branch

    git checkout upstream/master

Create a new branch to start solve a new issue 

    git checkout -b iss666-issue-name 

Do what you need

`Commit` the changes and `push` it to your `branch` with:

    git push origin iss666-issue-name

Verify code style with rubocop:

    rubocop -R --auto-gen-config --auto-correct
    
To detail offenses in `.rubocop_todo.yml` 

    rubocop -R --only the_rubocop_offence_type` to detail offenses

Squash your commits using 

    git rebase -i upstream/master

Rebase your changes with upstream/master with:

    git fetch upstream --all --prune
    git rebase upstream/master

Create a `Pull Request`

Wait the tests results in CI server 

Wait the team members evaluate your PR 

## Code Style

* [Ruby Code Style](https://github.com/bbatsov/ruby-style-guide#dont-hide-exceptions)
* [Rubocop Defaults](https://github.com/bbatsov/rubocop/blob/master/config/enabled.yml)
