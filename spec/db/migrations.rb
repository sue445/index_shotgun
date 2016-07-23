ActiveRecord::Schema.verbose = false

ActiveRecord::Schema.define(version: 1) do
  create_table :users do |t|
    t.string :name
    t.text   :description

    t.timestamps null: false
  end

  create_table :articles do |t|
    t.string :title
    t.text   :description

    t.timestamps null: false
  end

  create_table :comments do |t|
    t.references :user,    index: true
    t.references :article, index: true
    t.text       :message

    t.timestamps null: false
  end

  create_table :user_stocks do |t|
    t.references :user,    index: true
    t.references :article, index: false
    t.boolean    :already_read
    t.text       :message

    t.timestamps null: false
  end
  add_index :user_stocks, [:user_id, :article_id], unique: true, name: "user_id_article_id"
  add_index :user_stocks, [:user_id, :article_id, :already_read], name: "user_id_article_id_already"
end
