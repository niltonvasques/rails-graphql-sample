# CrossOver Ticket System Challenge

[![Build Status](http://drone.niltonvasques.com.br/api/badges/niltonvasques/crossover-ticket-system/status.svg)](http://drone.niltonvasques.com.br/niltonvasques/crossover-ticket-system)
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

![High Level Architecture](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/High%20Level%20Arquitecture.jpg)

##### Explanation

REST APIs have a lot of issues very well known, like the multi request problem, that is when a client application need
rebuild the information stored on server through multiple REST resource routes. Thus, the main reason to adopt a GraphQL 
Query instead a REST API approach, was because GraphQL has a very elegant way to handle and solve REST issues, and probably 
will be the default "way to go" for next years in backend development. Another less strong reason was for learning purposes,
to give a try to this new technology through the challenge, increasing a little bit the efforts, but also allow get the hands
dirty on the state of the art of backend JSON APIs and evaluate it.

The whole architecture can be splited in three points, the database; the GraphQL rails application; the hybrid frontend app.
The MySQL database was choosed because it was in the requirements of the challenge, but also for have a strong and smoothly
integration with Rails and Active Record. The rails application was created using the new **API mode** (`--api`), that has a
minimal stack of Rails modules focused in serving JSON responses. The server has only one route, the **GraphQL Endpoint** 
(`POST /graphql`), that receives all queries and mutations and delivery them to **GraphQL Schema**. This Schema is built
using a declarative approach with `graphql-ruby gem`, and holds all possible queries (requests, users and report) and 
mutations (create, remove and auth) of the application. The queries are intended to handle read only requests, whereas the
mutations are responsible to change the data.

Authorization mechanism was built by scratch, because the cannonical gems for that job (i.e. devise, clearance), not are
built with focus on API mode only, and because that they have a lot of code using the html rendering stack of 
a traditional rails app. Thus, the authorization approach used is very straightforward, and is done in two steps, a) sending
a signIn mutation with user login (email, password); b) sending the auth token, that comes from signIn mutation, 
through `Authorization HTTP Header` as we can see below.

```
POST /graphql?query=query MyQuery { requests { id, open, user { name }, comments { id, comment } } } HTTP/1.1
Host: localhost:3000
Authorization: Token token="3l1OxrFfTd_aygqD0Avtvg"
Cache-Control: no-cache
Postman-Token: 5c90cf63-83b1-4b5c-c2e3-db4bd7ebea52
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
```
#### Frontend Architecture

![Frontend Architecture](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/Frontend%20Arquitecture.jpg)

The main goal that I have in mind, when are thinking about the frontend archictecture, was design it in way that
maximize the amount of code and logic, and minimize the efforts for build a hybrid app for web and mobile clients. Therefore,
considering the recent advances in web development and the **Single Page Application pattern** that emerged in the last
years and all the ecosystem that are arising around that, and my background experience, I have decide to use the **Redux** 
to handle app state logic, by considering it to be easy and predictive approach for the job. In the client view layer, the
**react-native** framework was used, because it provide a easy and very elegant way to build hybrid applications. By the way,
the communication layer between the rails graphql api and the client app was assigned to awesome **apollo-client**, that has
a strong integration with redux.

React native view components was organized in way that allows we share almost all of them between web, android and in the
future also IOS code. Since, this approach for build a frontend client is very new, and still don't have a solid and default
organization of the modules, I decided to organize them in such way that increase the isolation between modules and thus
increasing the single responsability too much as possible. The full organization is showed below:

```
app/
├── components // shared components between web and mobile
│   └── *.js
├── constants // holds static variables
│   └── *.js
├── native // specific mobile components
│   └── components
│       └── *.js
├── scenes // application pages
│   └── *.js
├── store // app state and communication layer
│   └── *.js
└── web // specific web components
    └── components
        └── *.js
 ```

#### Data Model

![Data model](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/Data%20Model.png)

## Setup

#### Requirements

* [docker](https://docs.docker.com/engine/installation/)
* [docker-compose](https://docs.docker.com/compose/install/)

#### Run with docker

    export MYSQL_ROOT_PASSWORD=somepass
    export SECRET_KEY_BASE=ea615c8f1f9a136075a6711d185e45f96dbebea0db80f53373a2f1147ef8d8b28ca3051bb2e132d22178ad40212a43177930d94f2f7670c1f6301567e13aa19c
    export HOST_URL=someurl.com
    export RAILS_ENV=production

    docker-compose up --build
    
Get docker IP

    docker exec -it ticketsystem-web hostname -I # 172.17.0.2

Try create a user
    
    curl --request POST --url http://172.17.0.3/graphql --header 'cache-control: no-cache' \
         --header 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
         --header 'postman-token: 7c56d213-4033-6315-3aac-c45af10e45d9' \
         --form 'query=mutation registerUser($input: RegisterUserInput!) { registerUser(input: $input) { user { id, name, email } } }' \
         --form 'variables={ "input": { "name": "John Doe", "email": "johndoe@test.com", "password": "123456", "password_confirmation": "insano00" } }'
         
Authenticate

    curl --request POST \
         --url http://172.17.0.3/graphql \
         --header 'cache-control: no-cache' \
         --header 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
         --header 'postman-token: c9bfea4b-901f-9083-a979-7b34397e9491' \
         --form 'query=mutation signIn($input: SignInInput!) { signIn(input: $input) { data { token, user { name } } } }' \
         --form 'variables={ "input": { "email": "johndoe@test.com", "password": "123456"} }'
         
List requests where $TOKEN comes from Authenticate step above

     curl --request POST \
          --url http://172.17.0.3/graphql \
          --header 'authorization: Token token=\"$TOKEN\"' \
          --header 'cache-control: no-cache' \
          --header 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
          --header 'postman-token: e707ca42-f408-c989-d06b-233622971277' \
          --form 'query=query MyQuery { requests { id, open, user { name }, comments { id, comment } } }'

#### Codestyle

    pronto run

* [Ruby Code Style](https://github.com/bbatsov/ruby-style-guide#dont-hide-exceptions)
* [Rubocop Defaults](https://github.com/bbatsov/rubocop/blob/master/config/enabled.yml)

## Running tests

  rspec

## Screenshots

![Android Main scene](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/android%20main%20scene.png)
![Web Main scene](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/web%20main%20scene.png)
![Web Admin Panel](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/web%20admin%20panel.png)
![Web Requests](https://github.com/niltonvasques/crossover-ticket-system/blob/docs/admin%20request%203.png)

