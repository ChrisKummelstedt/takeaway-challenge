class Menu

  def initialize menu =  { pepperoni: 50, vegetariana: 50, mexicana: 50, deluxe: 100 }
    @list = menu
  end

  def display
    list.dup
  end

  def show_price item
  item = item.to_sym
  @list[item]
end

  def pretty_list
    list.each {|key, value| puts "#{key.capitalize} - #{value} SEK" }
  end

  attr_reader :list


end
