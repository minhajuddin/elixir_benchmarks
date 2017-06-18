(fn ->
  path = "/haha/index.html"
  IO.inspect String.splitter(path, "/") |> Enum.drop(1)

  subdomain_rx = ~r(^\/[^\/]+)

  Benchee.run(%{
    "pattern_match_bytes" => fn ->
      len = byte_size("/haha")
      <<_::bytes-size(len), rest :: binary >> = path
      rest
    end,
    "pattern_match" => fn -> "/haha" <> rest = path; rest end,
    "slice" => fn -> String.slice(path, String.length("/haha")..-1) end,
    "replace_prefix" => fn -> String.replace_prefix(path, "/haha", "") end,
    "split" => fn -> String.splitter(path, "/") |> Enum.drop(1) |> Enum.join("/") end,
    "regex" => fn -> String.replace(path, subdomain_rx, "") end,
  })
end).()
