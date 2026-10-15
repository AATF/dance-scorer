# frozen_string_literal: true

class ChangeAllTableIdsToUuids < ActiveRecord::Migration[8.1]
  def up
    # Step 1: Add new UUID columns
    [:groups, :dancers, :users, :scores, :settings].each do |table|
      add_column table, :uuid, :string, limit: 36
    end
    add_column :dancers, :new_group_id, :string, limit: 36
    add_column :scores, :new_dancer_id, :string, limit: 36
    add_column :scores, :new_user_id, :string, limit: 36

    # Step 2: Backfill UUIDs for existing rows
    [Group, Dancer, User, Score, Setting].each do |model|
      model.reset_column_information
      model.find_each do |record|
        record.update_column(:uuid, SecureRandom.uuid)
      end
    end

    Dancer.find_each do |dancer|
      grp = Group.find_by(id: dancer.group_id)
      dancer.update_column(:new_group_id, grp&.uuid || SecureRandom.uuid)
    end

    Score.find_each do |score|
      d = Dancer.find_by(id: score.dancer_id)
      u = User.find_by(id: score.user_id)
      score.update_columns(
        new_dancer_id: d&.uuid || SecureRandom.uuid,
        new_user_id: u&.uuid || SecureRandom.uuid
      )
    end

    # Step 3: Remove foreign keys
    remove_foreign_key :scores, :dancers if foreign_key_exists?(:scores, :dancers)
    remove_foreign_key :scores, :users if foreign_key_exists?(:scores, :users)
    remove_foreign_key :dancers, :groups if foreign_key_exists?(:dancers, :groups)

    # Step 4: Drop old PKs and swap to UUID
    [:scores, :dancers, :groups, :users, :settings].each do |table|
      remove_column table, :id
      rename_column table, :uuid, :id
      change_column_null table, :id, false
      execute("ALTER TABLE #{quote_table_name(table)} ADD PRIMARY KEY (id)")
    end

    remove_column :dancers, :group_id
    rename_column :dancers, :new_group_id, :group_id
    change_column_null :dancers, :group_id, false

    remove_column :scores, :dancer_id
    rename_column :scores, :new_dancer_id, :dancer_id
    change_column_null :scores, :dancer_id, false

    remove_column :scores, :user_id
    rename_column :scores, :new_user_id, :user_id
    change_column_null :scores, :user_id, false

    change_column :settings, :thing_id, :string, limit: 36 if column_exists?(:settings, :thing_id)

    # Step 5: Re-add indexes & foreign keys
    add_index :dancers, :group_id, name: "fk_rails_051c369b06" unless index_exists?(:dancers, :group_id, name: "fk_rails_051c369b06")
    add_index :scores, :dancer_id, name: "fk_rails_5b03197483" unless index_exists?(:scores, :dancer_id, name: "fk_rails_5b03197483")
    add_index :scores, :user_id, name: "fk_rails_f5dcd5d06f" unless index_exists?(:scores, :user_id, name: "fk_rails_f5dcd5d06f")

    add_foreign_key :dancers, :groups
    add_foreign_key :scores, :dancers, on_update: :cascade, on_delete: :cascade
    add_foreign_key :scores, :users, on_update: :cascade, on_delete: :cascade
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
