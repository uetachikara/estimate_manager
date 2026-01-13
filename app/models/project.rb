class Project < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :quotes, dependent: :destroy

  enum :status, { lead: 0, active: 1, won: 2, lost: 3 }, default: :lead
end
