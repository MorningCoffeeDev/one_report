FactoryGirl.define do

  factory :user do

  end

  factory :report_list do

    association :reportable, factory: :user
  end

end
