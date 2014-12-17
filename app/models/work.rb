class Work < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  scope :fullday, -> { where('hours >= 8') }
  scope :recent, -> { where('datetimeperformed > ?', Time.now - 7.days) }
  #scope :recent__7, -> { where('datetimeperformed > "#{Time.now - 7.days}"') } DOESN'T WORK
  scope :recent_7, -> { where("datetimeperformed > '#{Time.now - 7.days}'") }

  validates :hours, numericality: { only_integer: true,
                                    greater_than: 0,
                                    less_than_or_equal_to: 8 }
  validates :project, presence: true
  validates :user, presence: true
  validates :datetimeperformed, presence: true
  validate :datetimeperformed_cant_be_in_the_future

  def datetimeperformed_cant_be_in_the_future
    if datetimeperformed.present? && datetimeperformed > Time.now
      errors.add(:datetimeperformed, "can't be in the future")
    end
  end

  def self.recentdays(numdaysago)
    since_date = Time.now - numdaysago.to_i.days
    where('datetimeperformed > ?', since_date)
  end

  def to_s
    "#{user}: #{datetimeperformed.strftime('%m/%d/%Y %H:%M')} - #{hours} hours} "
  end
end
