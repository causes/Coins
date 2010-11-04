class Category < ActiveRecord::Base
  has_many :chips

  def to_s
    name
  end
end
