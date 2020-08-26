require "activerecord/enum_sti/version"
require "active_support/concern"
require "active_support/core_ext/string/inflections"

module ActiveRecord
  module EnumSti
    extend ActiveSupport::Concern

    class Error < StandardError; end

    class_methods do
      def find_sti_class(type)
        type_name = enum_items.key(type)
        prefix = if superclass == ActiveRecord::Base || superclass.abstract_class
                   name
                 else
                   superclass.name
                 end
        "#{prefix}::#{type_name.to_s.camelize}".constantize
      end

      def sti_name
        enum_items[name.demodulize.underscore]
      end

      def enum_items
        public_send(inheritance_column.pluralize)
      end
    end
  end
end
