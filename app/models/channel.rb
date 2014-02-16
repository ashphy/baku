class Channel < ActiveRecord::Base
  has_many :messages
  belongs_to :server

  scope :joins, -> { where(joined: true) }

  def name_without_sign
    self.name.delete('#')
  end
end
