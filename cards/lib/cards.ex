defmodule Cards do
  @moduledoc """
    Provides functions to create and handle a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of cards
  """
  def create_deck do
    values = Enum.to_list(1..13)
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for value <- values, suit <- suits do
      val =
        case value do
          1 -> "Ace"
          11 -> "Jack"
          12 -> "Queen"
          13 -> "King"
          _ -> value
        end

      "#{val} of #{suit}"
    end
  end

  @doc """
    Receives a deck of cards and returns the shuffled deck

    iex> deck = Cards.create_deck
    iex> deck == Cards.shuffle(deck)
    false
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Returns `true` if `deck` contains `card` and `false` otherwise

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Splits the deck into a hand of size `hand_size`
    and the remainder of the deck

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} ->
        :erlang.binary_to_term(binary)

      {:error, reason} ->
        "File does not exist: #{reason}"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
