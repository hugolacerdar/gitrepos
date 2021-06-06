defmodule Gitrepos.Users.Create do
  alias Gitrepos.{Error, Repo, User}

  def call(params) do
    changeset = User.changeset(params)

    case Repo.insert(changeset) do
      {:ok, %User{} = user} -> {:ok, user}
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end
end
