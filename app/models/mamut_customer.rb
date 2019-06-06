class MamutCustomer < ActiveRecord::Base
  establish_connection :mamut
  self.table_name = 'dbo.External_Customer'
  self.primary_key = 'CustomerID'

  has_many :matches

  def readonly?
    true
  end
end