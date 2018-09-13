# Deployment Blocker

As simple application which records blocking/unblocking a service

## Slack Integration

The integration with slack is available via the slash command `/blinkistservice`

### Usage
* * *

#### `/blinkistservice help`

Shows the help section with usage details
* * *

#### `/blinkistservice status`

Show the status of sevices available
* * *

#### `/blinkistservice block <service-shortname>`

Blocks a service for the current user. If the service has already been blocked, then this shows an error.
* * *

#### `/blinkistservice unblock <service-shortname>`

Unblocks a service. The service should have been blocked previously by the same user or should have been blocked for more than 4 hours. 
* * *
