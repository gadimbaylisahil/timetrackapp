AdminUser.create(email: "admin@admin.com", 
				 password: "123456", 
				 password_confirmation: "123456", 
				 first_name: "Admin", 
				 last_name: "AdminSurname",
				 phone: "0034631703581",
				 ssn: 123456,
				 company: "Test Company")

puts "Admin user has been created"

@employee = Employee.create(email: "regular@regular.com",
					password: "123456",
					password_confirmation: "123456",
					first_name: "Regular", 
					last_name: "RegularSurname",
					phone: "0034631703581",
					ssn: 123456,
					company: "Test Company")
puts "Regular user has been created"

AuditLog.create!(user_id: @employee.id, status: 0, start_date: (Date.today - 6.days))
AuditLog.create!(user_id: @employee.id, status: 0, start_date: (Date.today - 13.days))
AuditLog.create!(user_id: @employee.id, status: 0, start_date: (Date.today - 20.days))

puts "3 audit logs have been created"

25.times do |post|
	Post.create!(date: Date.today, rationale: "#{post} rationale", user_id: @employee.id, overtime_request: 2.5)
end
puts "25 posts have been created"

