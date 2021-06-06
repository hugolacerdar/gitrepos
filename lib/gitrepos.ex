defmodule Gitrepos do
  alias Gitrepos.GithubPublicApi.Client

  defdelegate get_filtered_repo_data(username), to: Client, as: :get_repos_by_username
end
