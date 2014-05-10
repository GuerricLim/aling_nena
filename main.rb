require 'sinatra'
require './boot.rb'
require './money_calculator.rb'

items = []
# ROUTES FOR ADMIN SECTION
get '/' do 
  @products = Item.all
  if @products.count <=10
    @items = @products
  else
    @items = @products.sample(10)
  end 
  erb :home 
end

get '/products' do
  @products = Item.all
  erb :product 
end  

post '/purchase/buy/:id' do 
  @products = Item.all 
  @message2 = params[:quantity].to_i
  @product = Item.find(params[:id])
  @message3 = @product.sold + @message2

  message4= @product.quantity.to_i - @message2
  @total_price = @product.price.to_i * @message2.to_i
  total = params[:ones].to_i*1 + params[:fives].to_i*5 + params[:tens].to_i*10 + params[:twenties].to_i*20+ params[:fifties].to_i*50 + params[:hundreds].to_i*100 + params[:fivehundreds].to_i*500 + params[:thousands].to_i*1000
 if @message2.to_i <= @product.quantity
  if total > @total_price
     @product.update_attributes!(
    quantity: message4,
    sold: @message3
  )
      @change = total.to_i - @total_price.to_i
     @change2 = MoneyCalculator.new params[:ones], params[:fives], params[:tens], params[:twenties], params[:fifties], params[:hundreds], params[:fivehundreds], params[:thousands]
     @money_change = @change2.change(@total_price.to_i)
     erb :change
  elsif total==@total_price
    @product.update_attributes!(
    quantity: message4,
    sold: @message3
  )
    @change = 0
    @change2 = MoneyCalculator.new params[:ones], params[:fives], params[:tens], params[:twenties], params[:fifties], params[:hundreds], params[:fivehundreds], params[:thousands]
    @money_change = @change2.change(@total_price.to_i)
    erb :change
  else 
    redirect to '/error'
  end 
else 
  redirect to '/error2'
end 
end 

get '/error2' do 
  erb :error3
end 
get '/error' do 
  erb :error
end

get '/purchase/:name' do 
  @products = Item.all
  @message3=""
  @message4 = ""
  @message5 = ""
  @products.each do |product|
      if product.name == params[:name]
        @message3 += product.name
        @message4 += product.id.to_s
        @message5 += product.price.to_s
      end
  end
  erb :puchase_form
end 

get '/about' do
  erb :about
end

get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
   Item.create!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
    sold: 0
  )
  redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end
# ROUTES FOR ADMIN SECTION