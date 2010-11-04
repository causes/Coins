class Chip < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  named_scope :recent, lambda { |days| 
    {:conditions => ["date(created_at) > date(?)", days.ago]} 
  }

  named_scope :last_month,
    :conditions => ["date(created_at) > date(?)", 1.month.ago]
  
  def self.today
    chips = Chip.all(:conditions => {
      :created_at => Date.today .. Date.tomorrow
    }).group_by(&:user)
    
    # now group sets of user chips by category
    chips.inject({}) do |h, (user, chips)|
      h[user] = chips.group_by(&:category)
      h
    end
  end

  def to_s 
    "Chip: #{self.user} #{self.category} #{self.created_at.getlocal}"
  end
end
