defmodule OpenAI.Completions do
  @moduledoc false
  alias OpenAI.Client
  alias OpenAI.Config

  @base_url "/v1/completions"
  @engines_base_url "/v1/engines"

  def url(config) do
    api_type = config.api_type || Config.api_type()

    case api_type do
      :azure -> "/completions"
      _ -> @base_url
    end
  end

  def deprecated_url(engine_id), do: "#{@engines_base_url}/#{engine_id}/completions"

  def fetch(params, config \\ %Config{}) do
    url(config)
    |> Client.api_post(params, config)
  end

  def fetch_by_engine(engine_id, params, config \\ %Config{}) do
    deprecated_url(engine_id)
    |> Client.api_post(params, config)
  end
end
