class Quote < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :quote_items, dependent: :destroy

  accepts_nested_attributes_for :quote_items, allow_destroy: true

  before_validation :calculate_totals

  enum :status, {
    draft: 0,
    sent: 1,
    accepted: 2,
    rejected: 3
  }

  def status_label
    I18n.t("activerecord.attributes.quote.statuses.#{status}")
  end
  
  def status_badge_class
    case status
    when "draft"
      "bg-secondary"
    when "sent"
      "bg-info"
    when "accepted"
      "bg-success"
    when "rejected"
      "bg-danger"
    end
  end

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

  def calculate_totals
    self.subtotal = quote_items.sum { |i| i.quantity.to_i * i.unit_price.to_i }
    self.tax = (subtotal * 0.1).floor
    self.total = subtotal + tax
  end
end
