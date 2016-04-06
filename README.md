# strava_tfl
[![Build Status](https://travis-ci.org/macwadu/strava_tfl.svg?branch=master)](https://travis-ci.org/macwadu/strava_tfl) [![Heroku](https://heroku-badge.herokuapp.com/?app=stravatfl&root=healthcheck)](https://stravatfl.herokuapp.com)

Strava TFL - How much i can save cycling instead of getting the tube

The Application is using Strava Web Application Flow to request access token

## WEB APP

**http://stravatfl.herokuapp.com**
  

## API

`GET` **/healthcheck** 
  
  `{ status: "ok" }`

`GET` **/auth/token** 
  
  `{ access_token: "272db38b165784e076758bcb90ecf4467585ca0a99fec9" }`

`GET` **api/v1/athlete**

  `{ id: 590326, username: "user1", firstname: "user_firstname", lastname: "user_lastname", ... }`

`GET` **/api/v1/activities**

  `[ { id: 535719699, resource_state: 2, external_id: "6DD68F3C-BEA7-4F65-BC92-3FAA88DF9C01", ... } ]`

## DOCS

https://stravatfl.herokuapp.com/docs/v1.json

## Used Dependencies
- strava-api-v3 - https://github.com/jaredholdcroft/strava-api-v3.git
