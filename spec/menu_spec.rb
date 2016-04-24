load 'menu.rb'

describe Menu do

let(:menu){ described_class.new }

  it "knows whats on the menu" do
    expect(menu.display).to eq ({ pepperoni: 50, vegetariana: 50, mexicana: 50, deluxe: 100 })
  end

  it "displays prices" do
    expect(menu.show_price("vegetariana")).to eq 50
  end

end
