class AuditLogsController < ApplicationController
	def index
		@audit_logs = AuditLog.page(params[:page]).per(10)
		authorize @audit_logs
	end

	def confirm
		audit_log = AuditLog.find(params[:id])
		authorize audit_log
		audit_log.confirmed!
		redirect_to root_path, alert: "Thank you! Your confirmation has been successful!"
	end
end
