class ApplicationController < ActionController::Base
    #CELLL
    def current_user
        @current_user ||= User.find_by(session: session[:session_token])
    end

    def ensure_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def login!(user)
        @current_user = user
        session[:session_token] = user.reset_session_token
    end

    def logout!
        current_user.reset_session_token if logged_in?
        @current_user = nil
        session[:session_token] = nil
    end

    def logged_in?
        !!current_user
    end
end
