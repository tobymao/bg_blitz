Sequel.migration do
  change do
    create_enum :post_type, %w[blog podcast youtube]

    create_table :posts do
      primary_key :id
      String :title, null: false
      String :text, null: false
      post_type :type, null: false, index: true
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end

    create_enum :item_type, %w[image audio youtube]

    create_table :items do
      primary_key :id
      String :title, null: false
      String :description, null: false
      String :file_data
      String :external_url
      item_type :type, null: false, index: true
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
