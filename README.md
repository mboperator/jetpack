# jetpack
> Strap in, we're launching some product.

Jetpack is a Procore OS boilerplate that:
  - Handles OAuth flow
  - Manages Access Tokens and Refresh Tokens
  - Proxies API requests and attaches access tokens
  - Sets up Webpack builds for client applications

## Endpoints
### /sessions/create
Redirects client to start Procore OAuth flow

### /oauth/procore/callback
Takes OAuth code, retrieves an access_token, and stores that access_token in the session.

### /api/v2/:path
Paths preceeded by `/api/v2` will be routed to `https://app.procore.com/vapid/:path`.
This controller adds the `access_token` to all requests that it routes.

## Getting Started
To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
