class Quote < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum :status, { draft: 0, sent: 1, accepted: 2, rejected: 3 }, default: :draft

  before_validation :calculate_amounts
  before_validation :assign_quote_no, on: :create

  private

  def calculate_amounts
    self.tax = subtotal.to_i * 0.1
    self.total = subtotal.to_i + tax.to_i
  end

  def assign_quote_no
    self.quote_no ||= "Q-#{Time.current.strftime('%Y%m%d')}-#{SecureRandom.hex(2).upcase}"
  end
end
