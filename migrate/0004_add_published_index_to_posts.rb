Sequel.migration do
  up do
    add_index :posts, :published_at
  end

  down do
    drop_index :posts, :published_at
  end
end
