class User < ApplicationRecord
    #FIGVAPER
    after_initialize :ensure_session_token
    validates :username, presence: true, uniqueness: true
    validates :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true

    attr_reader :password
    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def ensure_session_token
        self.session_token ||= SecureRandom.base64(16) 
    end

end
