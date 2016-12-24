class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy, :approve]
	def index
		# post_by method in the post.rb model
		# kaminari pagination
		@posts = Post.posts_by(current_user).page(params[:page]).per(10)
	end

	def new
		@post = Post.new
	end

	def approve
		authorize @post
		@post.approved!
		redirect_to root_path, alert: "The post has been approved!"
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			redirect_to @post, notice: 'Post has been created successfully!'
		else
			render :new
		end
	end

	def edit
		#punpit authorizes method
		authorize @post
	end

	def update
		#punpit authorizes method
		authorize @post

		if @post.update(post_params)
			redirect_to @post, notice: 'Post has been updated successfully!'
		else 
			render :edit
		end
	end

	def show
	end

	def destroy
		@post.delete
		redirect_to posts_path, notice: 'Post has been deleted successfully!'
	end

	private
		def post_params
			params.require(:post).permit(:date, :rationale, :status, :overtime_request)
		end

		def set_post
			@post = Post.find(params[:id])
		end
end
