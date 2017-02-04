# CrossOver Ticket System Challenge

[![Build Status](http://drone.niltonvasques.com.br/api/badges/niltonvasques/pms-rails/status.svg)](http://drone.niltonvasques.com.br/niltonvasques/crossover-ticket-system)
[![Coverage](https://img.shields.io/badge/coverage-97%25-brightgreen.svg)](https://img.shields.io/badge/coverage-94%25-brightgreen.svg)

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

### Use cases

* Use Case: Signup   
  1. A non signed in user open the app
  2. A non signed in user click in signup button
  3. A non signed in user fills his personal information (name; email; password)
  4. System create a new user and redirect to sign in page
* Alternative: Missing information
  - At step 4, when the user not fill some information
  - System no create a new user and stay on signup page
  
* Use Case: Signin   
  1. A non signed in user open the app
  2. A non signed in user click in signin button
  3. A non signed in user fills login information (email; password)
  4. System redirect to main page
* Alternative: Authorization failed
  - At step 3, when the login information is wrong
  - System display a error message
  
* Use Case: Signin   
  1. A non signed in user open the app
  2. A non signed in user click in signin button
  3. A non signed in user fills login information (email; password)
  4. System redirect to main page
* Alternative: Authorization failed
  - At step 3, when the login information is wrong
  - System display a error message
  
* Use Case: Signin   
  1. A non signed in user open the app
  2. A non signed in user click in signin button
  3. A non signed in user fills login information (email; password)
  4. System redirect to requests page
* Alternative: Authorization failed
  - At step 3, when the login information is wrong
  - System display a error message  
* Alternative: Admin user
  - At step 4, when the user is admin, redirect to admin panel
  
* Use Case: Requests page   
  1. After Signin Use Case
  2. User see their own requests and can create a new request 
  3. User click in some request
  4. User is redirect to request detail page
* Alternative: Agent user
  - At step 2, when the user is an agent, he see all requests
  - Agent can't create a request
  - Agent can also export a report with requests closed in last month  
* Alternative: Admin user
  - At step 2, when the user is an admin, he see all requests
  - Admin can remove any requests
  - Admin can't create a request
  - Admin can also export a report with requests closed in last month 
  
* Use Case: Request detail page   
  1. After user choose some request from Requests page
  2. User see request informations (title, content)
  3. User see request comments
  4. User can add comments
  5. User can close the request
* Alternative: Request closed
  - At step 5, when the request is closed, the user can't close it again
  - User can't add comments
  
* Use Case: Admin panel  
  1. After admin signin
  2. Admin see a panel with options for manage users and requests
  3. Admin click in users and is redirect to users manage page
* Alternative: Manage requests
  - At step 3, when the admin click in requests, he is redirect to requests page
  
* Use Case: Users page
  1. After admin choose users options in Admin panel
  2. Admin see a list with all users from system
  3. Admin can remove any user
* Alternative: Create agent
  - At step 2, admin also see the fields to create a new agent
  - Admin fills in those fields the new agent information
  - System create a new agent
* Alternative: Create agent failed because missing/invalid information
  - When Admin fills wrong or missing information to create a new agent
  - System not create a new agent and display a failure message

## Design Architecture

#### High Level Architecture

![High Level Architecture](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/docs/High%20Level%20Arquitecture.jpg)

##### Explanation

REST API's has a lot of issues very well known, like the multi request problem, that is when a client application need
rebuild the information stored on server through multiple REST resource routes. Thus, the main reason to adopt a GraphQL 
Query instead a REST API approach, was because GraphQL has a very elegant way to handle and solve REST issues, and probably 
will be the default "way to go" for next years in backend development. Another less strong reason was for learning purposes,
give a try to this new technology through the challenge (increasing a little bit the efforts) and see the results.

The whole architecture can be splited in three points, the database; the GraphQL rails application; the hybrid frontend app.
The MySQL database was choosed because it was in the requirements of the challenge, but also for have a strong and smoothly
integration with Rails and Active Record. The rails application was created using the new API mode (`--api`), that has a
minimal stack of Rails modules focused in serving JSON responses.

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

