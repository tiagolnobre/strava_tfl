# strava_tfl
[![Build Status](https://travis-ci.org/tiagolnobre/strava_tfl.svg?branch=master)](https://travis-ci.org/tiagolnobre/strava_tfl) [![Heroku](https://heroku-badge.herokuapp.com/?app=stravatfl&root=healthcheck)](https://stravatfl.herokuapp.com)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ftiagolnobre%2Fstrava_tfl.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Ftiagolnobre%2Fstrava_tfl?ref=badge_shield)

Strava TFL - How much i can save cycling instead of getting the tube

The Application is using Strava Web Application Flow to request access token

## WEB APP

**http://stravatfl.herokuapp.com**

(in progress ...)  

## API

`GET` **/healthcheck** 
  
  `{ status: "ok" }`

`GET` **/auth/token** 
  
  `{ access_token: "272db38b165784e076758bcb90ecf4467585ca0a99fec9" }`

`GET` **api/v1/athlete**

  `{ id: 590326, username: "user1", firstname: "user_firstname", lastname: "user_lastname", ... }`

`GET` **/api/v1/activities**

  `[ { id: 535719699, resource_state: 2, external_id: "6DD68F3C-BEA7-4F65-BC92-3FAA88DF9C01", ... } ]`

`GET` **api/v1/activities/count?before=1462060799&after=1459468800&price=6**  (Needs better naming params)
 
 `{ activities: 30, weekends: false, price: 6, total: 180 }`

## DOCS

https://stravatfl.herokuapp.com/docs/v1.json

## Used Dependencies
- strava-api-v3 - https://github.com/jaredholdcroft/strava-api-v3.git


## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ftiagolnobre%2Fstrava_tfl.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Ftiagolnobre%2Fstrava_tfl?ref=badge_large)