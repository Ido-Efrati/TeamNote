class User < ActiveRecord::Base
	before_create :create_remember_token
  #User validation 
  #validate that a user has a username, that this username is unique and that its length is between 4-20 chars
	validates :name, presence: true, length: { in: 4..20 }, uniqueness:true

  #validate that a user has an email, that it fits a valid email format, and that the email adress is unique.
  # The uniqueness is also not case sensitive (IDO@MIT.EDU is the same as ido@mit.edu)
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX } , uniqueness: { case_sensitive: false }

  #verify that the password is secured (encrypted) to prevent plain text passwords in the db. velidate the existence of a password
  #, and validate that a password is at least 6 chars
  has_secure_password
  validates :password, length: { minimum: 6 }

  #relationship between a user to notes. A user has many notes, and if a user will get deleted (not supported in phase 2)
  # all of its note will be deleted as well.
  has_many :notes, dependent: :destroy


  #methods to encrypt the users session
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
