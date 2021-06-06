defmodule Gitrepos.Users.Get do
  alias Gitrepos.{Error, Repo, User}

  def by_id(id) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.build(:not_found, "User not found")}
    end
  end
end
