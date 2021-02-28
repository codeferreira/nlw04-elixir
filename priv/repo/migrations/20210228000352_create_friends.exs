defmodule Rocketpay.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all), null: false
      add :addresse_id, references(:users, type: :binary_id)
      add :accepted, :boolean, default: :false, null: false

      timestamps()
    end

  end
end
