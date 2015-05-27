require 'rails/all'
require 'active_record_batteries'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
ActiveRecord::Schema.verbose = false

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :author do |t|
    t.string :name

    t.timestamps null: false
  end

  create_table :articles do |t|
    t.string :title
    t.text   :body
    t.references :author

    # Sluggable
    t.string :slug

    # Deletable
    t.datetime :deleted_at

    t.timestamps null: false
  end
end

class Author < ActiveRecord::Base
  batteries! :sluggable, :paginable, :filterable, :relationship_scopes

  has_many :articles
end

class Article < ActiveRecord::Base
  batteries! :sluggable, :paginable, :filterable, :relationship_scopes, :deletable

  belongs_to :author
end
