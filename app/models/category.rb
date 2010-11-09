class Category < ActiveRecord::Base
  has_many :chips
  validates_uniqueness_of :name


  def to_s
    name
  end
end
