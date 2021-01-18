defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck generates 20 cards" do
    assert length(Cards.create_deck) == 52
  end

  test "shuffle randomizes a deck" do
    deck = Cards.create_deck()
    assert deck != Cards.shuffle(deck)
  end

end
