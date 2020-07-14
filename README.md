# ActsInSequence

Adds sequencing to the database records.

Often we want to keep a record `sequence`/`order` in the database. This gem takes care of adding sequence (auto-incremented) to newly added records.

Tough its not just auto-increment, you can do [scoped sequencing](#scope) and more with this gem.

## Usage

### Install

```ruby
gem 'acts_in_sequence'
```

```ruby
bundle install
```

### Create Migration

```ruby
bin/rails generate migration AddSequenceTo{MODEL_NAME} sequence:integer
```

### Enable Sequencing

By default, `acts_in_sequence` assumes the records sequence is stored in `sequence` column of type `integer`.

```ruby
class Task < ActiveRecord::Base
  acts_in_sequence
end
```

#### Scope
This attribute allows us to track sequencing with a scope.

```ruby
class TodoList < ActiveRecord::Base
  has_many :tasks
end

class Task < ActiveRecord::Base
  acts_in_sequence scope: :todo_list

  belongs_to :todo_list
end
```

You can scope on any column ( Yeah, thats right! )

```ruby
class Task < ActiveRecord::Base
  acts_in_sequence scope :name
end
```

#### Custom column name
With `:column_name` we can use custom column names instead of using `sequence`.

```ruby
class Task < ActiveRecord::Base
  acts_in_sequence column_name: :display_order
end
```

#### Default order
When sequencing is applied, records will be sorted with `ASC` sequence by default. Use `default_order` attribute to change it when you need to.
Use scope `without_sequence_order` when you want to remove the default ordering.

```ruby
class Task < ActiveRecord::Base
  acts_in_sequence
end

class Item < ActiveRecord::Base
  acts_in_sequence default_order: :desc
end

Task.all                        # => 1, 2, 3, 4, 5
Item.all                        # => 5, 4, 3, 2, 1
Item.without_sequence_order.all # => 1, 2, 3, 4, 5
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

