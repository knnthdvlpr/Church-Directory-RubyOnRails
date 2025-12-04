class Branch < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :departments, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
