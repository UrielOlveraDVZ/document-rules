defmodule UtilitiesFiles do
  def handle do
    # fetch req
    # read file
    # path_file = ~s(/home/dozenth/Codes/DVZ/documentRules/insumosXML/registros_prueba.csv)
    path_file = ~s(/home/dozenth/Codes/DVZ/documentRules/insumosXML/data_sample \(1\).xlsx)

    # path_file
    # |> File.stream!
    # |> Stream.map(&row_proccess(&1))
    # |> Stream.run
    {:ok, page} = Xlsxir.multi_extract(path_file, 1)
    [head | values] = Xlsxir.get_list(page)
    values
    # |> Enum.each(fn data -> IO.inspect data end)
  end

  def row_proccess(line) do
    data = line
      |> String.replace("\n", "")
      |> String.split(",")
      # validation proccess
      # save row
      # send mail
      IO.inspect data
  end
end
