# Define Table

## A table is:

 - A collection: include many rows;
 - A row: include many columns;
 - A column: a column related to a model object, directly or indirectly;

So, just config them:
- config a collection;
- config each column;

### First, define a subclass inherit from OneReport::Base

```ruby
class ExampleTable < OneReport::Base
end
```

### Config Collections

- call `collect` method, need pass two params
  1. a collection class, It used for dynamic generate column method for object;
  2. the defined scope, scope can be more than one, all scope will be used by order;
- sometimes, you should defined a scope for the Model first

```ruby
# consider a User model
# need define some scope before used it;
class User
  scope :one_report_scope, ->(size) { limit(size) }
end

class ExampleTable < OneReport::Base

  def config(size)

    # with more scope, notice that the scope will be called orderly
    collect -> { User.one_report_scope(size) }

  end

end
````

### Config Each Column
use for each collection element's method, to pass a method name or a lambda
the order is important, all columns order by It's defined order

```ruby
# with default header and default field method
# default header use 'titleize' method to format
# default field method equal column's name
column :name

# with assigned header and default field method
column :name, header: 'My name'

# with assigned header and assigned field method
column :name, header: 'My name', field: -> { name }
```
