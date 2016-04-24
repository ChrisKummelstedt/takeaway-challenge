require_relative 'menu.rb'
require_relative 'order.rb'

class Waiter

  def initialize
    @menu = Menu.new
    @order_history = []
    @current_orders = []
    @order_counter = 1
  end


 #SMS Format: Item1,Count1,Item2,Count2@Address@Total
  def new_order sms, phonenumber
    c_phonenumber = phonenumber
    new_order = sms.split("@")
    c_order_array = new_order[0]
    c_adress = new_order[1]
    c_total = new_order[2]

    valid_order = order_validation c_order_array
    valid_balance = balance_validation c_order_array, c_total if valid_order


    take_order c_adress, c_order_array, c_total, c_phonenumber if valid_order && valid_balance
    send "Please check items and input correct names and numbers" unless valid_order
    send "The total is wrong, please add up again" if valid_balance == false && valid_order == true

  end

  #validates items
  def order_validation order_array
    order_check = true

    #splits array into items and item count
    items = order_array.split(",").select.with_index { |_, i| i.even? }
    item_counts = order_array.split(",").select.with_index { |_, i| i.odd? }

    #first check: are all orders valid menu items?
    items.each {|item_name| order_check = false unless menu.list.has_key?(item_name.to_sym)}
    item_counts.each {|number| order_check = false unless number.to_i.is_a? Numeric}
    #returns validation
    order_check
  end

  #validates balance
  def balance_validation order_array, total
    order_check = true
    balance = 0

    #splits array into items and item count
    items = order_array.split(",").select.with_index { |_, i| i.even? }
    item_counts = order_array.split(",").select.with_index { |_, i| i.odd? }

    #second check: does total match balance due?
    items.each_with_index { |item_name,index| balance += item_counts.at(index).to_i*self.menu.show_price(item_name)}
    order_check = false unless balance == total.to_i

    #returns validation
    order_check
  end

  #takes orders and gives them an ID
  def take_order adress, array, total, phonenumber
    order_id = @order_counter
    @current_orders.push (Order.new order_id, adress, array, total, phonenumber)
    @order_counter += 1
  end

  #moves orders from current_orders to order_history and notifies user that food is on the way
  def send_order order_id
    order_to_send = @current_orders.find {|order| order.id.to_i == order_id.to_i}
    @order_history.push(@current_orders.delete(order_to_send))
    if order_to_send != nil
      send "Your order is 1 hour away from arriving"
      puts "For kitchen: #{order_to_send.adress}"
      puts "For driver:  #{order_to_send.array}"
    end
  end

  def send string
    puts string
  end

  def current_orders
    @current_orders.dup
  end

  def order_history
    @order_history.dup
  end


  attr_reader :menu, :order

private

  attr_accessor :order_counter

end
