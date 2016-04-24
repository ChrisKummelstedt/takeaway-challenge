load 'waiter.rb'

describe Waiter do

let (:waiter){described_class.new}
let (:menu){double :menu, display: { pepperoni: 50, vegetariana: 50, mexicana: 50, deluxe: 100 }}

  context "Taking orders" do

    it "takes orders and inputs them into the array current_orders if they are correct" do
      waiter.new_order 'vegetariana,3,pepperoni,3@Street 123@300', 72323
      expect(waiter.current_orders.size).to eq 1
    end


    it "notifies users that they have entered the wrong balance" do
        expect(STDOUT).to receive(:puts).with("The total is wrong, please add up again")
        waiter.new_order 'vegetariana,3,pepperoni,3@Street 123@301', 72323
    end

    it "notifies users that they have entered the item " do
        expect(STDOUT).to receive(:puts).with("Please check items and input correct names and numbers")
        waiter.new_order 'vegetariana,3,peppzeroni,3@Street 123@300', 72323
    end


  end
end
