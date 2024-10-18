defmodule Hello.Market.ClassifiedTest do
  use Hello.DataCase, async: true

  alias Hello.Market.Classified

  test "boom" do
    classified = Ash.create!(Classified, %{title: "foo"})
    assert Ash.load!(classified, [:status])
  end
end
