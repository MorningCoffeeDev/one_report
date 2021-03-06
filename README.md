# OneReport
OneReport is a Rails Engine used for generating complex report, It can export to many format, Like: csv, pdf, html, xml and more

## Features
- Easy to use, Just config;
- Separate pdf style and data;
- Strong, even data processing break off, It can be restore easily;

## Functions
- sidekiq job;
- report file store;
- send email notice user after finished sidekiq job;

## Getting Started

#### step-1: Add one_report to you Gemfile:

```ruby
gem 'one_report'
```

#### step-2: Run migrations

```ruby
rake db:migrate
```

## Work with Report

#### step-1: Define table
this step is important, it format the report's data format

[Define Report Table](doc/define-report-table.md)

#### step-2: Define report method
[Define Report Method](doc/define-report-method.md)

#### step-3: (optional) Define report pdf's style
[Define report pdf style](doc/define-pdf-style)

#### step-4: Define report in model

```ruby
class StudentReport < ActiveRecord::Base
  define_report :sports_report
end
```
Since the definition, there are several meaning：

  * add method: `sports_report_id`, this method will get report list's id
  * add method: `sports_report_report_list`, this method will get report list model, for addition, It will generate a queue job;


