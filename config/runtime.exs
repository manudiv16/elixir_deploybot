import Config

portainer_user = System.get_env("PORTAINER_USER", "admin")
portainer_pass = System.get_env("PORTAINER_PASS", "Pass123@")
portainer_host = System.get_env("PORTAINER_HOST", "localhost")

if config_env() == :dev do
  config :elixir_deploybot,
    portainer_user: portainer_user,
    portainer_pass: portainer_pass,
    portainer_host: portainer_host
end
