class Quote < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum :status, { draft: 0, sent: 1, accepted: 2, rejected: 3 }, default: :draft

  before_validation :calculate_amounts
  before_validation :assign_quote_no, on: :create

  validates :subtotal, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :issued_on, presence: true
  validates :quote_no, presence: true, uniqueness: true

  private

  def calculate_amounts
    s = subtotal.to_i
    self.tax   = (s * 10) / 100
    self.total = s + tax.to_i
  end

  def assign_quote_no
    self.quote_no ||= "Q-#{Time.current.strftime('%Y%m%d')}-#{SecureRandom.hex(2).upcase}"
  end
end
