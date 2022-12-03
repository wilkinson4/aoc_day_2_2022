defmodule AC do
  @player_1_choice_mappings %{
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors
  }

  @player_2_choice_mappings %{
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors
  }

  def calc(path) do
    with {:ok, binary} <- File.read(path) do
      rounds =
        binary
        |> String.split("\n", trim: true)
        |> Enum.map(fn round -> String.split(round, " ") end)

      Enum.reduce(rounds, 0, fn round, acc ->
        player_1_choice = Map.get(@player_1_choice_mappings, Enum.at(round, 0))
        player_2_choice = Map.get(@player_2_choice_mappings, Enum.at(round, 1))
        p2_choice_score = choice_score(player_2_choice)

        case result(player_1_choice, player_2_choice) do
          :win -> p2_choice_score + 6 + acc
          :loss -> p2_choice_score + acc
          :tie -> p2_choice_score + 3 + acc
        end
      end)
    end
  end

  defp result(:rock, :paper), do: :win
  defp result(:paper, :scissors), do: :win
  defp result(:scissors, :rock), do: :win
  defp result(p1, p2) when p1 == p2, do: :tie
  defp result(_, _), do: :loss

  defp choice_score(:rock), do: 1
  defp choice_score(:paper), do: 2
  defp choice_score(:scissors), do: 3
end
