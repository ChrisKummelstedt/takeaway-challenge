load './lib/waiter.rb'

waiter = Waiter.new

#p waiter.show_menu
#p waiter.show_price("vegetariana")
#p waiter.current_orders

waiter.new_order 'vegetariana,3,pepperoni,3@Street 123@300', 72323
waiter.new_order 'vegetariana,1,pepperoni,1 @ Street 123 @ 100', 7232
waiter.send_order 1
waiter.current_orders
waiter.order_history
