class Parent
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :students

  field :name, type: String

end
