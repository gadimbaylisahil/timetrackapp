class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  validates_presence_of :first_name, :last_name, :phone

  PHONE_REGEX = /\A[0-9]*\z/

  validates_format_of :phone, with: PHONE_REGEX

  validates :phone, length: { maximum: 14 }

  def full_name 
  	first_name + ", " + last_name
  end
end
