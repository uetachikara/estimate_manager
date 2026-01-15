class Project < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :quotes, dependent: :destroy

  enum :status, { lead: 0, active: 1, closed: 2 }

  def status_i18n
    I18n.t("activerecord.attributes.project.statuses.#{status}")
  end
  
end
