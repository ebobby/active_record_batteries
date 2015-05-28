# ActiveRecordBatteries

ActiveRecordBatteries is a simple library that aims to provide some basic, useful tools for your models without a lot of complexity.

## Modules

- *Paginable*, provides database pagination.
- *Sluggable*, provides slug support for your models, normally used for pretty urls.
- *Deletable*, provides logical deletes.
- *Filterable*, provides an easy way to filter your results.
- *RelationshipScopes*, provides a way to add scopes for your relationships in a single line.

## Getting started

ActiveRecordBatteries works with Rails 4+. You can add it to your Gemfile with:

```ruby
gem active_record_batteries'
```

Run the bundle command to install it.


## Usage

To load the batteries on your models:

```ruby
class Article < ActiveRecord::Base
  batteries! :sluggable, :paginable, :filterable, :relationship_scopes, :deletable
end
```

You can use any or all of them at the same time.

### Paginable

```ruby
class Article < ActiveRecord::Base
  batteries! :paginable

  page_items 10   # default is 25
end
```

```ruby
Article.pages                     # how many pages with the current page_items configuration.

Article.pages(15)                 # how many pages if we have 15 items per page

@articles = Article.paginate(2)   # Get page 2

@articles.current_page            # What page are we on?
=> 2

@articles.total_items             # How many items do we have in total?
=> 23

@articles.total_pages             # How many pages do we have?
=> 3

```

### Sluggable

```ruby
class Article < ActiveRecord::Base
  batteries! :sluggable        # Requires the model to have a string column named slug.

  slug_base_column :title      # Column to generate the slug from. Default is :name
end
```

```ruby
article = Article.create(title: "Hello, world")     # Create a new article

article.slug                                        # Slug automatically generated
=> "hello-world"

articles = Article.by_slug("hello-world")           # New scope

article  = Article.find_by_slug("hello-world")      # New finder

article = Article.create(title: "Hello, world")     # Create another article with clashing slug

article.slug                                        # Automatically qualified, slugs are unique.
=> "hello-world-kJNLnA"
```

### Deletable

```ruby
class Article < ActiveRecord::Base
  batteries! :deletable        # Requires the model to have a datetime column named deleted_at.
end
```

```ruby
article = Article.create(title: "Hello, world")    # Create a new article

article.deleted?                                   # Not deleted
=> false

article.delete!                                    # Delete the record
article.save!

Article.find_by(title: "Hello, world")             # Can't find deleted records.
=> nil

article = Article.
            including_deleted.
            find_by(title: "Hello, world")         # This scope allows to find it

article.deleted?                                   # This *is* deleted
=> true
```

### Filterable

```ruby
class Article < ActiveRecord::Base
  batteries! :filterable

  # Normal scope
  scope :by_author, ->(author_id) { where(author_id: author_id) }

  # Add a filter and create a scope with it. Filters need to take one parameter.
  add_filter :by_title, ->(title) { where(title: title) }

  # Add a filter with an existing scope.
  add_filter :by_author
end
```

```ruby
 Article.by_title("Hello, world")                   # Filter created a scope.
 => <Article>

 # Filtered takes a hash, the keys are matched against the
 # filter list and the scopes are called with the value concatenating them.
 # It is designed to take the params array from a controller.
 Article.filtered(by_title: "Hello, world", by_author: 1)

```

### RelationshipScopes

```ruby
class Article < ActiveRecord::Base
  batteries! :relationship_scopes

  has_one  :author
  has_many :tags

  # Add relationship scopes
  relationship_scopes :tags

  # Add relationship scopes with a custom suffix
  relationship_scopes :author, :writer
end
```

```ruby
 # with_writer ensures a join with the relationship, so you can filter by it.
 Article.with_writer.merge(Author.by_name("Ramit"))

 # Includes the relationship, avoiding the N+1 queries problem.
 Article.include_tags.all

 # Also includes the relationship, but forces a single query (most of the time) and
 # and INNER JOIN. If your master relationship has no values, this will return null.
 Article.and_tags.all

 # Preload the relationship. Similar to include.
 Article.pload_tags.all

 # Eager load the relationship. Similar to include.
 Article.eload_tags.all
 ```

Relationship scopes are a great way to optimize your queries. Play around with the different scopes and analyze the queries they trigger. The resulting query can be different among the scopes  depending on the situation.

## Final remarks

We wrote this code as we built [Chopeo](https://www.chopeo.mx) because we found most solutions to these problems to be more complicated than they needed to be for our case.

Most people build things in a way that tries to work in every corner case. It is a great goal. For this library, our goal was to keep it as simple as possible. It should cover most situations.

If you have any questions or comments please feel free to contact me at ebobby@ebobby.org. Pull requests are welcome.

## Author

Francisco Soto <ebobby@ebobby.org>

Copyright © 2015 Francisco Soto (http://ebobby.org) released under the MIT license.
