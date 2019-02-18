require 'rails/all'
require 'active_record_batteries'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
ActiveRecord::Schema.verbose = false

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :authors do |t|
    t.string :name

    # Sluggable
    t.string :slug

    t.timestamps null: false
  end

  create_table :articles do |t|
    t.string :title
    t.text   :body
    t.references :author

    # Sluggable
    t.string :slug

    # Deleteable
    t.datetime :deleted_at

    t.timestamps null: false
  end
end

class Author < ActiveRecord::Base
  include ActiveRecordBatteries::Concerns::Sluggable,
          ActiveRecordBatteries::Concerns::Paginable,
          ActiveRecordBatteries::Concerns::Filterable

  has_many :articles

  filter_add :by_slug
end

class Article < ActiveRecord::Base
  include ActiveRecordBatteries::Concerns::Sluggable,
          ActiveRecordBatteries::Concerns::Paginable,
          ActiveRecordBatteries::Concerns::Filterable,
          ActiveRecordBatteries::Concerns::Deleteable

  belongs_to :author

  slug_base_column :title

  filter_add :by_slug
  filter_add :by_title, ->(title) { where(title: title) }

  page_items 5
end
