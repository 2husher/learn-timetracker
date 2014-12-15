class Work < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  scope :fullday, -> { where('hours >= 8') }
  scope :recent, -> { where('datetimeperformed > ?', Time.now - 7.days) }
  #scope :recent__7, -> { where('datetimeperformed > "#{Time.now - 7.days}"') } DOESN'T WORK
  scope :recent_7, -> { where("datetimeperformed > '#{Time.now - 7.days}'") }
end
