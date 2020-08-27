require 'active_record'
require 'active_record/enum_sti'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define do
  create_table :payments do |t|
    t.integer :type
  end

  create_table :users do |t|
    t.integer :role
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class User < ApplicationRecord
  self.inheritance_column = :role
  enum role: { member: 0 , admin: 20}
  include ActiveRecord::EnumSti
end

class User::Member < User
  def my_role
    "member"
  end
end

class User::Admin < User
  def my_role
    "admin"
  end
end

class Payment < ApplicationRecord
  include ActiveRecord::EnumSti
  enum type: { credit_card: 0, bank_transfer: 10 }
end

class Payment::CreditCard < Payment
  def my_type
    "credit_card"
  end
end

class Payment::BankTransfer < Payment
  def my_type
    "bank_transfer"
  end
end
