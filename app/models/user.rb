class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [ :login ]

  attr_accessor :login

  validates :username, presence: true
  validates :email, presence: true

  # def login
  #   @login || self.username || self.email || self.password
  # end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login) then
      where(conditions).where([ "username = :value OR email = :value", { value: login } ]).first
    else
      where(conditions).first
    end
  end
end
