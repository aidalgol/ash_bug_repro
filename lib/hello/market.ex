defmodule Hello.Market do
  use Ash.Domain

  resources do
    resource Hello.Market.Classified
  end
end

