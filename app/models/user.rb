class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable,
         :validatable, :timeoutable,
         authentication_keys: [:username]

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
