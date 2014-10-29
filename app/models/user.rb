class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts

  # Method called on a given user, which looks at the role stored
  # against said user in the db, and returns either true / false.
  # The role in this method is an implied self, so it could read:
  #
  # self.role == 'admin'
  #
  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end
end
