# BooApi

To start the server:

* Install dependencies with `mix deps.get`
* Create a `.env` file, and supply the following environment variables:
```
export DB_USERNAME='<your_db_username>'
export DB_PASSWORD='<your_db_password>'
```
* Load environment variables with `source .env`
* Create and migrate the database with `mix ecto.setup`
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
