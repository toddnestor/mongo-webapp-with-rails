class Student
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :grades
  has_and_belongs_to_many :parents

  field :name, type: String
  field :birthday, type: Date

  validates_uniqueness_of :name
end
