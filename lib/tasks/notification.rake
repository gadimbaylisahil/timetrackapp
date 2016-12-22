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

end
