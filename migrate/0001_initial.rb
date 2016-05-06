Sequel.migration do
  change do
    create_table(:posts) do
      primary_key :id
      String :title, null: false
      String :text, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
