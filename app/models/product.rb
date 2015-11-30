class Product < ActiveRecord::Base
  belongs_to :site

  delegate :currency, to: :site
  monetize :price_cents
end
