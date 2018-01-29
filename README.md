# techCore: Growing the tech community

### Find - Learn - Connect - Share

![alt text](https://github.com/Shaun-Schwartz/tech-core/blob/integration/app/assets/images/techcore-logo.png "techCore")



We are tasked with creating an application ('Mission Control') for a local non profit organization [Force Of Nature Alliance](http://www.forceofnaturealliance.ca/). The App will be used to create coordination for various Teams, their 'Missions', Users and Subtasks. There is an emphasis on accessability and ease-of-use considering the various generations of potential users of the app.

The App revolves around our integrated calender, allowing all visiters to view and search for upcoming or past events, while allowing signed in users to create and host their own events. Event leaders will be able to add users to the event, create tasks for volenteers to complete and edit specific details about the event. A mailer system is set in place which will notify leaders when they create an event and remind users of upcoming events they are a part of.

## Setup:
```
Run the following commands in the project directory:

$ bundle
$ rails db:create
$ rails db:migrate
$ rails db:seed
$ rails s

Follow instuctions at '/config/initializers/app_keys_test.rb.example'

Open on localhost:3000
```

## Technologies used:
- Ruby on Rails
  - Gems used: simple_calender, simple_form, cancancan, friendly_id, cocoon, chosen-rails
- Bootstrap
- jQuery

## Team Members:
* Ian (Team Leader)
* Calvin (CSS Guru)
* Sam (Mr. CanCan)
* James (Power User)
* Conor (Git Keeper)
* Steve (Master)
