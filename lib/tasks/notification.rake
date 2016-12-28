namespace :notification do
  desc "Sends SMS notification to employees asking to log if they had overtime"
  task sms: :environment do
    if Time.now.sunday?
      employees = Employee.all
      notification_message = "Please login to dashboard to request overtime or confirm your hours for previous week: https://tise-overtime.herokuapp"
      employees.each do |employee|
        SmsTool.send_sms(number: employee.phone, message:notification_message)
        AuditLog.create!(user_id: employee.id)
      end
    end

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
