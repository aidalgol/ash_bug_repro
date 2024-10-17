defmodule Hello.Market.Classified do
  use Ash.Resource,
    domain: Hello.Market,
    data_layer: AshPostgres.DataLayer

  require Ash.Query

  postgres do
    table "classifieds"
    repo Hello.Repo
  end

  resource do
    plural_name :classifieds
  end

  attributes do
    uuid_primary_key :id
    attribute :title, :string, allow_nil?: false
    attribute :description, :string
    attribute :expires, :datetime, allow_nil?: false
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      primary? true
      accept [:title, :description]
      change set_attribute(:expires, &DateTime.utc_now/0)
    end

    update :update do
      primary? true
      accept [:title, :description]
    end

    update :expire do
      argument :date, :datetime, default: &DateTime.utc_now/0
      change atomic_update(:expires, expr(^arg(:date)))
    end

    read :by_id do
      argument :id, :uuid, allow_nil?: false
      get? true
      filter expr(id == ^arg(:id))
    end
  end

  calculations do
    calculate :expired, :boolean, expr(expires <= now())
  end
end

