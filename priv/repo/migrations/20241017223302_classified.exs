defmodule Hello.Repo.Migrations.Classified do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:classifieds, primary_key: false) do
      add :id, :uuid, null: false, default: fragment("gen_random_uuid()"), primary_key: true
      add :title, :text, null: false
      add :description, :text
      add :expires, :utc_datetime, null: false
    end
  end

  def down do
    drop table(:classifieds)
  end
end
