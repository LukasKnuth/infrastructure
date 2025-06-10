# Infrastructure

This repository holds all infrastructure configuration for my personal and hobby projects.

It's organized by having one project per folder.

Any sensitive information (e.g. API Keys) is provided via environment variables.
These are loaded via [direnv](https://direnv.net/), which also makes them all available in any subdirectory.

## Porkbun

Because I'm paranoid, I usually remove the API key once the changes are done.
I don't often make changes here, so it's not a big inconvenience.

1. Log into the admin UI
2. Click "Account > API Access" and create a API key/secret key pair
3. Add the configuration to `.envrc`
4. Ensure the domain under management has the "API Access" toggle set to **ON**
