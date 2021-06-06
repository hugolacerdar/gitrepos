defmodule GitreposWeb.UsersView do
  use GitreposWeb, :view

  def render("create.json", %{user: user, token: token}),
    do: %{message: "User created successfully", user: user, token: token}

  def render("sign_in.json", %{token: token}),
    do: %{token: token}
end
