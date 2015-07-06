defmodule Chira.Watcher do
  use GenServer

  def start_link(url, pid) do
    GenServer.start_link(__MODULE__, [url, pid])
  end

  def init([url, pid]) do
    Process.send_after self, :tick, 5000
    {:ok, {url, pid}}
  end

  def handle_info(:tick, state = {url, pid}) do
    Process.send_after self, :tick, 30*1000
    send pid, {url, get_status_code(url)}

    {:noreply, state}
  end

  defp get_status_code(url) do
    case HTTPoison.get(url) do
      {:ok, response} -> response.status_code
      {:error, error} -> error.reason
    end
  end
end
