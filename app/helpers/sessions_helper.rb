module SessionsHelper

	def set_session(user, remember_me)
		session[:user_id] = user.id
		if remember_me
			cookies.permanent[:user_id] = user.id
		else
			cookies.delete(:user_id)
		end
	end

	def current_user
		if cookies[:user_id]
			session[:user_id] = cookies[:user_id]
		end
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		end
	end

    def logged_in?
        !current_user.nil?
    end

    def log_out
    	session[:user_id] = nil
    	cookies.delete(:user_id)
    	@current_user = nil
  	end

end
