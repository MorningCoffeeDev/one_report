require 'one_report/engine'
require 'one_report/base'
require 'active_support/concern'


module OneReport
  module Model
    extend ActiveSupport::Concern

    included do
      has_one :report_list, as: :reportable
      has_many :report_lists, as: :reportable
    end

    module ClassMethods

      def define_report(name)

        define_method "#{name}_id" do
          self.report_lists.find_or_create_by_reportable_name(name).id
        end

      end

    end

  end

  module Combine
    extend ActiveSupport::Concern

    included do
      has_one :combine, as: :reportable
      has_many :combines, as: :reportable
    end


  end
end

def ENV.table; end
