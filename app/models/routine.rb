class Routine < ApplicationRecord
  
  validates :start_time,  presence: true
  validates :end_time,    presence: true
  validates :content,     presence: true, length: { maximum: 64 }
  validates :user_id,     presence: true
  
  validate :end_time_before_start_time
  
  def end_time_before_start_time()
    if self.start_time.nil? || self.end_time.nil?
      return;
    end
    
    if self.end_time < self.start_time
      errors.add(:end_time, "は開始時刻より前に設定できません。")
    end
  end
  
  def start_time_str
    start_time.nil? ? nil : start_time.strftime("%H:%M")
  end
  
  def end_time_str
    end_time.nil? ? nil : end_time.strftime("%H:%M")
  end
end