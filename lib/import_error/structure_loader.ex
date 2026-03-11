defmodule ImportError.StructureLoader do
  @sql_path Path.join([:code.priv_dir(:import_error), "static", "data.create.sql"])

  @doc """
  Loads `priv/static/data.create.sql` into the configured database via
  `Ecto.Adapters.MyXQL.structure_load/2`.
  """
  def load do
    config = ImportError.Repo.config() |> Keyword.put(:dump_path, @sql_path)
    Ecto.Adapters.MyXQL.structure_load(nil, config)
  end
end
