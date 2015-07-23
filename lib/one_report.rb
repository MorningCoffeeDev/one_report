require 'one_report/engine'
require 'one_report/base'
require 'active_support/concern'
require 'pdfs/table_pdf'

module OneReport
  module Model
    extend ActiveSupport::Concern

    included do
      has_one :report_list, as: :reportable, dependent: :destroy
      has_many :report_lists, as: :reportable, dependent: :destroy
    end

    module ClassMethods

      def define_report(name)

        define_method "#{name}_id" do
          self.report_lists.find_or_create_by_reportable_name(name).id
        end

        define_method "#{name}_report_list" do
          rl = self.report_lists.where(reportable_name: name).first
          if rl.present?
            rl.add_to_worker
          else
            self.report_lists.create(reportable_name: name)
          end
        end

      end

    end

  end

  module Combine
    extend ActiveSupport::Concern

    included do
      has_one :combine, as: :reportable, dependent: :destroy
      has_many :combines, as: :reportable, dependent: :destroy
    end

  end
end

def ENV.table; end
