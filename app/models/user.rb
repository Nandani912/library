class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :books
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { owner: 0, customer: 1 }
  def owner?
    role=="owner"
    end
    def customer?
      role=="customer"
    end
end
