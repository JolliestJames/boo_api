{:ok, _} = Application.ensure_all_started(:ex_machina)
Mox.defmock(BooApi.EncryptionApi.MockBcrypt, for: BooApi.EncryptionApi)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(BooApi.Repo, :manual)
