
1. Add one_report to you Gemfile:

```ruby
gem 'one_report'
```

2. Define report for you model

```ruby
class StudentReport < ActiveRecord::Base
  define_report :sports_report
end
```
Through the definition, there are several meaning：

- there is a Model ReportList Associate to this model, ReportList records infomation as bellow:

```ruby
# assocation
:reportable_id, :integer
:reportable_type, :string

# the defined reportname
:reportable_name, :string

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
- add method: `sports_report_id`, this method will get report list's id
- add method: `sports_report_report_list`, this method will get report list model, for addition, It will generate a queue job;

3. Define a Table
[Define Report Table](define-report-table.md)

4. Define report method
