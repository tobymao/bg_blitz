Sequel.migration do
  up do
    drop_column :posts, :published
  end

  down do
    add_column :posts, :published, TrueClass, default: false, null: false
    from(:posts).update(published: true)
  end
end
