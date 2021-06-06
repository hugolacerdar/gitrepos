defmodule Gitrepos.GithubPublicApi.ClientTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  alias Gitrepos.{Error, Repository}
  alias Gitrepos.GithubPublicApi.Client

  describe "get_repos_by_username/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when a valid username is given, returns all user's github repositories", %{
      bypass: bypass
    } do
      body = ~s([{"id": 362931861,
          "node_id": "MDEwOlJlcG9zaXRvcnkzNjI5MzE4NjE=",
          "name": "linkly",
          "full_name": "hugolacerdar/linkly",
          "private": false,
          "owner": {
              "login": "hugolacerdar",
              "id": 60700097,
              "node_id": "MDQ6VXNlcjYwNzAwMDk3",
              "avatar_url": "https://avatars.githubusercontent.com/u/60700097?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/hugolacerdar",
              "html_url": "https://github.com/hugolacerdar",
              "followers_url": "https://api.github.com/users/hugolacerdar/followers",
              "following_url": "https://api.github.com/users/hugolacerdar/following{/other_user}",
              "gists_url": "https://api.github.com/users/hugolacerdar/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/hugolacerdar/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/hugolacerdar/subscriptions",
              "organizations_url": "https://api.github.com/users/hugolacerdar/orgs",
              "repos_url": "https://api.github.com/users/hugolacerdar/repos",
              "events_url": "https://api.github.com/users/hugolacerdar/events{/privacy}",
              "received_events_url": "https://api.github.com/users/hugolacerdar/received_events",
              "type": "User",
              "site_admin": false
          },
          "html_url": "https://github.com/hugolacerdar/linkly",
          "description": null,
          "fork": false,
          "url": "https://api.github.com/repos/hugolacerdar/linkly",
          "forks_url": "https://api.github.com/repos/hugolacerdar/linkly/forks",
          "keys_url": "https://api.github.com/repos/hugolacerdar/linkly/keys{/key_id}",
          "collaborators_url": "https://api.github.com/repos/hugolacerdar/linkly/collaborators{/collaborator}",
          "teams_url": "https://api.github.com/repos/hugolacerdar/linkly/teams",
          "hooks_url": "https://api.github.com/repos/hugolacerdar/linkly/hooks",
          "issue_events_url": "https://api.github.com/repos/hugolacerdar/linkly/issues/events{/number}",
          "events_url": "https://api.github.com/repos/hugolacerdar/linkly/events",
          "assignees_url": "https://api.github.com/repos/hugolacerdar/linkly/assignees{/user}",
          "branches_url": "https://api.github.com/repos/hugolacerdar/linkly/branches{/branch}",
          "tags_url": "https://api.github.com/repos/hugolacerdar/linkly/tags",
          "blobs_url": "https://api.github.com/repos/hugolacerdar/linkly/git/blobs{/sha}",
          "git_tags_url": "https://api.github.com/repos/hugolacerdar/linkly/git/tags{/sha}",
          "git_refs_url": "https://api.github.com/repos/hugolacerdar/linkly/git/refs{/sha}",
          "trees_url": "https://api.github.com/repos/hugolacerdar/linkly/git/trees{/sha}",
          "statuses_url": "https://api.github.com/repos/hugolacerdar/linkly/statuses/{sha}",
          "languages_url": "https://api.github.com/repos/hugolacerdar/linkly/languages",
          "stargazers_url": "https://api.github.com/repos/hugolacerdar/linkly/stargazers",
          "contributors_url": "https://api.github.com/repos/hugolacerdar/linkly/contributors",
          "subscribers_url": "https://api.github.com/repos/hugolacerdar/linkly/subscribers",
          "subscription_url": "https://api.github.com/repos/hugolacerdar/linkly/subscription",
          "commits_url": "https://api.github.com/repos/hugolacerdar/linkly/commits{/sha}",
          "git_commits_url": "https://api.github.com/repos/hugolacerdar/linkly/git/commits{/sha}",
          "comments_url": "https://api.github.com/repos/hugolacerdar/linkly/comments{/number}",
          "issue_comment_url": "https://api.github.com/repos/hugolacerdar/linkly/issues/comments{/number}",
          "contents_url": "https://api.github.com/repos/hugolacerdar/linkly/contents/{+path}",
          "compare_url": "https://api.github.com/repos/hugolacerdar/linkly/compare/{base}...{head}",
          "merges_url": "https://api.github.com/repos/hugolacerdar/linkly/merges",
          "archive_url": "https://api.github.com/repos/hugolacerdar/linkly/{archive_format}{/ref}",
          "downloads_url": "https://api.github.com/repos/hugolacerdar/linkly/downloads",
          "issues_url": "https://api.github.com/repos/hugolacerdar/linkly/issues{/number}",
          "pulls_url": "https://api.github.com/repos/hugolacerdar/linkly/pulls{/number}",
          "milestones_url": "https://api.github.com/repos/hugolacerdar/linkly/milestones{/number}",
          "notifications_url": "https://api.github.com/repos/hugolacerdar/linkly/notifications{?since,all,participating}",
          "labels_url": "https://api.github.com/repos/hugolacerdar/linkly/labels{/name}",
          "releases_url": "https://api.github.com/repos/hugolacerdar/linkly/releases{/id}",
          "deployments_url": "https://api.github.com/repos/hugolacerdar/linkly/deployments",
          "created_at": "2021-04-29T19:55:24Z",
          "updated_at": "2021-05-08T16:03:09Z",
          "pushed_at": "2021-05-08T16:03:07Z",
          "git_url": "git://github.com/hugolacerdar/linkly.git",
          "ssh_url": "git@github.com:hugolacerdar/linkly.git",
          "clone_url": "https://github.com/hugolacerdar/linkly.git",
          "svn_url": "https://github.com/hugolacerdar/linkly",
          "homepage": null,
          "size": 25,
          "stargazers_count": 0,
          "watchers_count": 0,
          "language": "Elixir",
          "has_issues": true,
          "has_projects": true,
          "has_downloads": true,
          "has_wiki": true,
          "has_pages": false,
          "forks_count": 0,
          "mirror_url": null,
          "archived": false,
          "disabled": false,
          "open_issues_count": 0,
          "license": null,
          "forks": 0,
          "open_issues": 0,
          "watchers": 0,
          "default_branch": "main"}])

      username = "hugolacerdar"

      Bypass.expect(bypass, "GET", "#{username}/repos/", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      url = endpoint_url(bypass.port)
      response = Client.get_repos_by_username(username, url)

      expected =
        {:ok,
         [
           %Repository{
             description: nil,
             html_url: "https://github.com/hugolacerdar/linkly",
             id: 362_931_861,
             name: "linkly",
             stargazers_count: 0
           }
         ]}

      assert response == expected
    end

    test "when the username doesn't exists, returns an error", %{bypass: bypass} do
      username = ""

      url = endpoint_url(bypass.port)

      body = ~s({
        "message": "Not Found",
        "documentation_url": "https://docs.github.com/rest"
    })

      Bypass.expect(bypass, "GET", "#{username}/repos/", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(400, body)
      end)

      expected = {:error, %Error{result: "Github user not found", status: :not_found}}

      response = Client.get_repos_by_username(username, url)

      assert response == expected
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
