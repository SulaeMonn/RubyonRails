class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile

  validates :name, presence: true
  validates :phone, presence: true
  validates :dob, presence: true
  validates :address, presence: true
  validates :profile, presence: true
  validates :email, presence: true
  validates :password, confirmation: true

  validates :name, :length => {:maximum => 255}
  validates :email, :uniqueness => {:message => "already taken" }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    Rails.logger.debug("success")
    UserMailer.forgot_password(self).deliver_now# This sends an e-mail with a link for the user to reset the password
  end
  # This generates a random password reset token for the user
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
