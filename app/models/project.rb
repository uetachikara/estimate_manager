class Project < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :quotes, dependent: :destroy

  enum :status, { lead: 0, active: 1, closed: 2 }
  
  def status_label
    I18n.t("activerecord.attributes.project.statuses.#{status}")
  end

  def status_badge_class
    case status
    when "lead"
      "bg-secondary"
    when "active"
      "bg-primary"
    when "closed"
      "bg-dark"
    end
  end
  
end
