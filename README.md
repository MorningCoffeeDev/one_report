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

## How it works
* there is a Model ReportList Associate to the model which has a report, ReportList records information as bellow:

| column name | column type | explain |example |
|--|--|--|--|
| reportable_id | integer | association id | 1 |
| reportable_type | string | association type | StudentReport |
| reportable_name | string | the defined report name | sports_report |
| file_id || report file information, use refile admin file | |
| file_filename |||
| file_size |||
| file_content_type | ||
| notice_email ||notice Functions |
| notice_body ||
| done | |status Functions |
| published |||
```


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


  * add method: `sports_report_id`, this method will get report list's id
  * add method: `sports_report_report_list`, this method will get report list model, for addition, It will generate a queue job;

- Define table
[Define Report Table](doc/define-report-table.md)

- Define report method
[Define Report Method](doc/define-report-method.md)
