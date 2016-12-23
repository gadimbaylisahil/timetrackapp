class StaticController < ApplicationController
	def homepage
		@pending_approvals = Post.where(status: 0)
	end
end