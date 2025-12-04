class Department < ApplicationRecord
  belongs_to :branch
  has_many :positions, dependent: :destroy
  has_many :users, dependent: :nullify

  validates :name, presence: true
end
