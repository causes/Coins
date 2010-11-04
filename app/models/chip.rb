class Chip < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  named_scope :recent, lambda { |days| 
    {:conditions => ["date(created_at) > date(?)", days.ago]} 
  }

  named_scope :last_month,
    :conditions => ["date(created_at) > date(?)", 1.month.ago]
  
  def to_s 
    "Chip: #{self.user} #{self.category} #{self.created_at.getlocal}"
  end
end
