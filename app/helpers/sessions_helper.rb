module SessionsHelper
   
	def log_in(user)
		session[:user_id] = user.id
	end

	def remember(user)
		user.remember
		cookies.permanent.encrypted[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	#Forgets a persistant session
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def log_out
		forget(current_user)
		reset_session
		#Security related
		@current_user = nil
	end

	def current_user
		# Returns the current logged-in user (if any).
		if (user_id = session[:user_id])
			## This works the same as @current_user = @current_user || User.find_by(id: session[:user_id]), where the first expression is evaluated, and if it turns nil (AKA hasn't run before, the executes User.find_by...)
		  @current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.encrypted[:user_id]) #Checks if its true aka exists
		  user = User.find_by(id: user_id)
		  if user && user.authenticated?(:remember, cookies[:remember_token])
			log_in user
			@current_user = user
		  end
		end
	end

	def logged_in?
		#Bang negates it, so "If the user is not NOT logged"
		!current_user.nil?
	end

	def current_user?(user)
		user == current_user
	end

	#Stores the URL trying to be accessed.
	def store_location
		session[:forwarding_url] = request.original_url if request.get? #if makes sure patch requests cant be sent though (Or something like that..?)
	end
end