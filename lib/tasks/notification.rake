namespace :notification do
  desc "Sends SMS notification to employees asking to log if they had overtime"
  task sms: :environment do
  	# --> Schedule to run at Sunday 5pm
  	# --> Iterate over all employees
  	# --> Skip AdminUsers
  	# --> Send a notification message with instructions and link to log time
  	# User.all.each do |user|
  	# 	SmsTool.send_sms()
  	# end
  end

  desc "Sends mail notification to managers asking to review pending overtime requests"
  task manager_email: :environment do
    submitted_posts = Post.submitted
    admin_users = AdminUser.all
    if submitted_posts.count > 0
      admin_users.each do |admin|
        ManagerMailer.email(admin).deliver_now
      end
    end
  end
end
