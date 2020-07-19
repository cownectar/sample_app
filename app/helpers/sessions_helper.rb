module SessionsHelper
   
  def log_in(user)
    session[:user_id] = user.id
  end

	def log_out
		reset_session
		#Security related
		@current_user = nil
	end

	def current_user
		# Returns the current logged-in user (if any).
		if session[:user_id]
			## This works the same as @current_user = @current_user || User.find_by(id: session[:user_id]), where the first expression is evaluated, and if it turns nil (AKA hasn't run before, the executes User.find_by...)
			@current_user ||= User.find_by(id: session[:user_id])
		end
	end
	
	def logged_in?
		#Bang negates it, so "If the user is not NOT logged"
		!current_user.nil?
	end
end
