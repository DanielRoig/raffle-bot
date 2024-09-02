module PriceFormatter
  def self.format_price(cents)
    Money.from_cents(cents, 'EUR').format
  end
end
