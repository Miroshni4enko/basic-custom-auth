class User < ApplicationRecord
  attr_accessible :email, :password, :password_confirmation

  attr_accessor :password

  before_save :encrypt_password

  validates_confirmation_of :password
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def self.authenticate(email, pass)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(pass, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      #In cryptography, a salt is random data that is used as an additional input to a one-way function
      #that "hashes" data, a password or passphrase. Salts are closely related to the concept of nonce
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
