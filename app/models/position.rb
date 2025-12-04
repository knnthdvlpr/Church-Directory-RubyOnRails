class Position < ApplicationRecord
  belongs_to :department
  has_many :users, dependent: :nullify

  validates :name, presence: true
  
  # Check if position is already taken (for unique positions)
  def available?
    return true unless unique?
    users.where(status: 'Active').empty?
  end
end