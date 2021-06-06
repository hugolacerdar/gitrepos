defmodule Gitrepos.GithubPublicApi.Client do
  use Tesla

  alias Gitrepos.{Error, Repository}
  alias Gitrepos.GithubPublicApi.Behaviour
  alias Tesla.Env

  @behaviour Behaviour

  @base_url "https://api.github.com/users/"

  plug(Tesla.Middleware.Headers, [{"user-agent", "Tesla"}])
  plug(Tesla.Middleware.JSON)

  def get_repos_by_username(username, url \\ @base_url) do
    "#{url}#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{body: repos, status: 200}}) do
    response =
      Enum.map(repos, fn repo ->
        %Repository{
          id: repo["id"],
          name: repo["name"],
          description: repo["description"],
          html_url: repo["html_url"],
          stargazers_count: repo["stargazers_count"]
        }
      end)

    {:ok, response}
  end

  defp handle_get({:ok, %Env{body: %{"message" => "Not Found"}}}) do
    {:error, Error.build(:not_found, "Github user not found")}
  end
end
