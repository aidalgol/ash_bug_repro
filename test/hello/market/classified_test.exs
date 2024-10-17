defmodule Hello.Market.ClassifiedTest do
  use Hello.DataCase, async: true

  alias Hello.Market.Classified

  test "boom" do
    Ash.Generator.action_input(Classified, :create)
    |> Enum.take(10)
    |> Ash.bulk_create!(Classified, :create)

    Classified
    |> Ash.Query.limit(5)
    |> Ash.bulk_update!(:expire, %{}, stop_on_error?: true)
  end
end
