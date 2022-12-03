defmodule AC.PartTwo do
  @player_1_choice_mappings %{
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors
  }

  def calc(path) do
    with {:ok, binary} <- File.read(path) do
      rounds =
        binary
        |> String.split("\n", trim: true)
        |> Enum.map(fn round -> String.split(round, " ") end)

      Enum.reduce(rounds, 0, fn round, acc ->
        player_1_choice = Map.get(@player_1_choice_mappings, Enum.at(round, 0))
        player_2_choice = Enum.at(round, 1)

        choice_score =
          case player_2_choice do
            "X" ->
              get_loss_score(player_1_choice)

            "Y" ->
              choice_score(player_1_choice)

            "Z" ->
              get_winning_score(player_1_choice)
          end

        choice_score + result(player_2_choice) + acc
      end)
    end
  end

  defp get_loss_score(:rock), do: choice_score(:scissors)
  defp get_loss_score(:paper), do: choice_score(:rock)
  defp get_loss_score(:scissors), do: choice_score(:paper)

  defp get_winning_score(:rock), do: choice_score(:paper)
  defp get_winning_score(:paper), do: choice_score(:scissors)
  defp get_winning_score(:scissors), do: choice_score(:rock)

  defp choice_score(:rock), do: 1
  defp choice_score(:paper), do: 2
  defp choice_score(:scissors), do: 3

  defp result("X"), do: 0
  defp result("Y"), do: 3
  defp result("Z"), do: 6
end
