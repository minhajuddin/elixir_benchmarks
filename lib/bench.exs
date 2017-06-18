(fn ->
  path = "/haha/index.html"
  IO.inspect String.splitter(path, "/") |> Enum.drop(1)

  Benchee.run(%{
    "split" => fn -> String.splitter(path, "/") |> Enum.drop(1) |> Enum.join("/") end,
  })
end).()
