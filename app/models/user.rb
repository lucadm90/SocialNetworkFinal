class User < ActiveRecord::Base
  before_save { self.email = email.downcase}
  #validations
  validates :name, presence: true, length:  {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format:  {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  #uniqueness -> unico  format per il formato presence per dire che deve essere presente
  validates :surname, presence: true, length: {maximum: 50} #aggiunto dopo la migration
  has_secure_password  #grazie alla gemma
  validates :password, length: {minimum: 6}


  #Con data_validator

  validates :birth, date: { before: Proc.new { Time.now - 3.year }, message: 'Troppo piccolo sei' }
end