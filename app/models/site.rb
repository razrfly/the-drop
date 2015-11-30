class Site < ActiveRecord::Base
  has_many :accounts
  has_many :products

  #has_many :products do
  #  def << (value)
  #    get_products
  #    super value
  #  end
  #end



end
