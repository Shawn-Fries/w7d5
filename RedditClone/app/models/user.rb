class User < ApplicationRecord
    #FIGVAPER
    after_initialize :ensure_session_token
    validates :username, presence: true, uniqueness: true
    validates :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    has_many :subs,
        primary_key: :id, 
        foreign_key: :moderator_id, 
        class_name: :Sub

    attr_reader :password

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user.is_password?(password)
            user
        else
            nil
        end
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def ensure_session_token
        self.session_token ||= SecureRandom.base64(16) 
    end

    def reset_session_token
        self.session_token = SecureRandom.base64(16)
        self.save!
        self.session_token
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end
end
