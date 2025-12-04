class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  belongs_to :branch, optional: true
  belongs_to :department, optional: true
  belongs_to :position, optional: true

  # Validations
  validates :first_name, :last_name, :age, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }
  validates :status, inclusion: { in: %w[Active Suspended] }

  # Callbacks 
  after_create :assign_default_role
  before_save :set_baptismal_status

  def full_name
    "#{first_name} #{middle_name} #{last_name}".squeeze(' ')
  end

  private

  def assign_default_role
    add_role(:member) if roles.blank?
  end

  def set_baptismal_status
    if baptismal_date.present?
      self.baptismal_status = "Baptized"
    else
      self.baptismal_status = "Unbaptized"
    end
  end
end
