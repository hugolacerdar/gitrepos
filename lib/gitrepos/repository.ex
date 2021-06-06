defmodule Gitrepos.Repository do
  @derive Jason.Encoder
  defstruct [:description, :html_url, :stargazers_count, :name, :id]
end
