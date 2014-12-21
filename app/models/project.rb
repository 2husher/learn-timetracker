class Project < ActiveRecord::Base
  belongs_to :company
  belongs_to :owner, class_name: "User"
  has_many :works
  has_many :users, through: :works

  validates :name, length: { minimum: 5 }
  validates :company_id, presence: true
  validates :owner_id, presence: true
  validates :default_rate, numericality: { only_integer: true,
                                           greater_than_or_equal_to: 50 }
  validates :slug, presence: true,
                   uniqueness: true

  scope :lowdefaultrate, -> { where('default_rate < 100') }

  def to_s
    "#{name} (#{company})"
  end

  def self.export_csv(projects)
    CSV.generate() do |csv|
      csv << ['name', 'company', 'default_rate', 'created_at', 'owner', 'most recent work item']
      projects.each do |project|
        csv << [
                  project.name,
                  project.company,
                  project.default_rate,
                  project.created_at,
                  project.owner,
                  project.works.order('created_at desc').first
                ]
      end
    end
  end
end
