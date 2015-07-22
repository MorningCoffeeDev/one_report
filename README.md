# OneReport
OneReport is used to generate report, It can format to csv, pdf, html, xml and more

## Features
- Easy to use, Just config it;
- Separate pdf style and data;
- Strong, even data processing break off, It can be restore easily;

## Functions
- sidekiq job;
- report file store;
- send email notice user after finished sidekiq job;

## Usage
Consider a table, It's as:
- A row's data all relative to one object;
- The object has many columns directly or indirectly;
- There is a collection includes each object, they are same model;

So, just to config them:

### First, define a subclass inherit from OneReport::Base

```ruby
class ExampleTable < OneReport::Base
end
```

### Config Collections
 
- Firstly, you should defined a scope for the Model, like this

```ruby
# consider a User model
class ExampleTable < OneReport::Base

  def config(size)
    User.class_eval do
      scope :one_report_scope, -> { limit(size) }
    end
  end
  
end
````

- secondly, need pass two params
  1. a collection class, It used for dynamic generate column method for object;
  2. the defined scope, scope can be a Array, all scope will be used;

```ruby
# with one scope
collect User, :all

# with more scope, notice that the scope will be called orderly
collect User, :all, :one_report_scope
```

### Config Each Column
- use for each collection element's method, to pass a method name or a lambda

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

**notice: the order is important, all columns order by It's defined order**
