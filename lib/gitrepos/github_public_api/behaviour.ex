defmodule Gitrepos.GithubPublicApi.Behaviour do
  alias Gitrepos.Error

  @callback get_repos_by_username(String.t()) :: {:ok, map()} | {:error, Error.t()}
end
