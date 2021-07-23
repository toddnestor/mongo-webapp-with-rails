class Grade
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :student

  field :course, type: String
  field :term, type: String
  field :value, type: String

  validates_presence_of :course, :term, :value
  validates_inclusion_of :value, in: %w[A B C D F]
end
