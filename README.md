# OneReport
OneReport is used for generating complex report, It can export to many format, Like: csv, pdf, html, xml and more

## Features
- Easy to use, Just config it;
- Separate pdf style and data;
- Strong, even data processing break off, It can be restore easily;

## Functions
- sidekiq job;
- report file store;
- send email notice user after finished sidekiq job;


## Getting Started

- Add one_report to you Gemfile:

```ruby
gem 'one_report'
```

- Run migrations

```ruby
rake db:migrate
```

- Define report in model

```ruby
class StudentReport < ActiveRecord::Base
  define_report :sports_report
end
```
Since the definition, there are several meaning：

  * there is a Model ReportList Associate to this model, ReportList records infomation as bellow:

```ruby
# assocation
:reportable_id, :integer  # 1
:reportable_type, :string  # "StudentReport"

# the defined reportname
:reportable_name, :string  # "sports_report"

# report file infomation, use refile admin file
:file_id
:file_filename
:file_size
:file_content_type

# notice Functions
:notice_email
:notice_body

# status Functions
:done
:published
```
  * add method: `sports_report_id`, this method will get report list's id
  * add method: `sports_report_report_list`, this method will get report list model, for addition, It will generate a queue job;

- Define table
[Define Report Table](doc/define-report-table.md)

- Define report method
[Define Report Method](doc/define-report-method.md)
