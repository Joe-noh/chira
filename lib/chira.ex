defmodule Chira do
  use Application

  import Supervisor.Spec

  def start(_type, _args) do
    children = [worker(Chira.Watcher, [])]

    opts = [strategy: :simple_one_for_one, name: Chira.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_child(url, pid) do
    Supervisor.start_child(Chira.Supervisor, [url, pid])
  end
end
