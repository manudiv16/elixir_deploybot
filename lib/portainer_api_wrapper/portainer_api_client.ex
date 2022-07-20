defmodule PortainerApiWrapper.PortainerApiClient do
  @adapter Tesla.Adapter.Hackney

  defp system_env_host(),
    do: Application.get_env(:elixir_deploybot, :portainer_user)

  defp system_env_user(),
    do: Application.get_env(:elixir_deploybot, :portainer_user)

  defp system_env_password(),
    do: Application.get_env(:elixir_deploybot, :portainer_user)

  def client_auth(
        host \\ system_env_host(),
        user \\ system_env_user(),
        password \\ system_env_password()
      ) do
    mid = first_middleware(host)

    mid
    |> get_client()
    |> get_jwt(user, password)
    |> get_auth_middleware(mid)
    |> get_client()
  end

  defp get_jwt(client, user, password) do
    {:ok, response} = Tesla.post(client, "/auth", %{password: password, username: user})
    response.body["jwt"]
  end

  defp get_client(middleware) do
    Tesla.client(middleware, @adapter)
  end

  defp get_auth_middleware(jwt, middleware) do
    [
      {Tesla.Middleware.Headers, [{"Authorization", "Bearer #{jwt}"}]}
    ] ++ middleware
  end

  defp first_middleware(host) do
    [
      {Tesla.Middleware.BaseUrl, host <> "/api"},
      {Tesla.Middleware.Timeout, timeout: 10000},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"Content-Type", "application/json"}]}
    ]
  end
end
