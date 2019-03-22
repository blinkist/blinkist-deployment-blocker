# Deployment Blocker

This project implements displays the blocked/unblocked status of services. It integrates with Slack.

## Development
### Setup Rails

```shell
# Install Ruby 2.5.1 via RVM / rbenv
$ rvm install 2.5.1

# Install bundler
$ gem install bundler

# Install all gems
$ bundle install
```

### Setup Development App
Change the `.env.sample` file to `.env.development` replace the info in `.env` file.

### CSS Framework
...

### Run the App locally

```shell
$ rails s
```

Now visit [http://0.0.0.0:3000](http://0.0.0.0:3000) in your favourite browser.

## Tests
### Run Tests

...

## Deployment

Continues integration via Codeship is setup. It also deploys the code to Heroku automatically.

Visit: [https://deployment-blocker.herokuapp.com](https://deployment-blocker.herokuapp.com)

## Statuses

|Tool  | Codeship CI/CD  |
|------|-----------------|
|**Status**|[![Build Status](https://app.codeship.com/projects/b3478420-98f0-0136-6617-1ad007865680/status?branch=master)](https://app.codeship.com/projects/305384)|

## 🌟 Ideas for improvements
