Sequel.migration do
  up do
    add_column :posts, :author, String
  end

  down do
    drop_column :posts, :author
  end
end
