Sequel.migration do
  up do
    add_column :posts, :published, TrueClass, default: false, null: false
    add_column :posts, :published_at, DateTime

    from(:posts).update(published: true, published_at: :created_at)
  end

  down do
    drop_column :posts, :published
    drop_column :posts, :published_at
  end
end
