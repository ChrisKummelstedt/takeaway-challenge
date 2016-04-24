
class Order

  def initialize id, adress, array, total, phonenumber
    @phonenumber = phonenumber
    @id = id
    @adress = adress
    @array = array
    @total = total
  end

  attr_reader :id, :adress, :array

end
