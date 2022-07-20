defmodule ElixirDeploybot do
  def get_users() do
    PortainerApiWrapper.PortainerApiClient.client_auth()
  end
end
