module SalesHelper 
  def active_sale?
    Sale.active.any?
    # pass the logic to a class in sale.rb
    # Sale.where("sales.starts_on <= ? AND sales.edn_on >= ?", Date.current, Date.current).any?
  end
end