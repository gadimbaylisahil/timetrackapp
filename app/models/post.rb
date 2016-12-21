class Post < ActiveRecord::Base
	enum status: { submitted: 0, approved: 1, rejected: 2}
	validates_presence_of :date, :rationale, :overtime_request 

	validates :overtime_request, numericality: { greater_than: 0.0 }
	
	belongs_to :user

	scope :posts_by, ->(user) { where(user_id: user.id) }
end