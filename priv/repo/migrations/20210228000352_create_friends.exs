defmodule Rocketpay.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :user_id, references(:users, type: :binary_id)
      add :addresse_id, references(:users, type: :binary_id)
      add :accepted, :boolean, default: :false, null: false

      timestamps()
    end

    create unique_index(:friends, [:user_id, :addresse_id], name: :unique_friendship)
  end
end
