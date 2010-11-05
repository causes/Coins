class User < ActiveRecord::Base
  has_many :chips

  validates_uniqueness_of :name

  def category_count(category, date = Date.today)
    self.chips.select { |c| c.category == category && c.created_at.getlocal.to_date == date }.size
  end

  def to_s
    name
  end
end
