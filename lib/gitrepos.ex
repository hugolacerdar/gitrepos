defmodule Gitrepos do
  alias Gitrepos.GithubPublicApi.Client
  alias Gitrepos.Users.Create, as: CreateUser
  alias Gitrepos.Users.Get, as: GetUser

  defdelegate get_filtered_repo_data(username), to: Client, as: :get_repos_by_username
  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
end
