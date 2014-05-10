class MoneyCalculator
	attr_accessor :ones, :fives, :tens, :twenties, :fifties, :hundreds, :five_hundreds, :thousands


  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
  	@ones = ones.to_i*1
  	@fives = fives.to_i*5
  	@tens = tens.to_i*10
  	@twenties = twenties.to_i*20
  	@fifties = fifties.to_i*50
  	@hundreds = hundreds.to_i*100
  	@five_hundreds = five_hundreds.to_i*500
  	@thousands = thousands.to_i*1000

    @total= @ones + @fives + @tens + @twenties + @fifties + @hundreds + @five_hundreds + @thousands
    # each parameter represents the quantity per denomination of money
    # these parameters can be assigned to instance variables and used for computation

    # add a method called 'change' that takes in a parameter of how much an item costs
    # and returns a hash of how much change is to be given
    # the hash will use the denominations as keys and the amount per denomination as values
    # i.e. {:fives => 1, fifties => 1, :hundreds => 3}
  end

  def change(price)
    @change = @total.to_i - price.to_i
  if @change != 0
    remainder=@change
    if @change >=1000
      thousands = @change/1000
      remainder = @change%1000
    end
    if remainder >=500
      fivehundreds= remainder/500
      remainder = remainder%500
    end
    if remainder>=100
      hundreds = remainder/100
      remainder = remainder%100
    end
    if remainder >=50
      fifties = remainder/50
      remainder = remainder%50
    end
    if remainder>=20
      twenties = remainder/20
      remainder = remainder%20
    end
    if remainder >=10
      tens = remainder/10
      remainder = remainder%10
    end
    if remainder >=5 
      fives = remainder/5
      remainder=remainder%5
    end
    if remainder>=1
      ones = remainder/1
    end

  	@money = {
      :thousands => thousands.to_i, 
      :five_hundreds => fivehundreds.to_i, 
      :hundreds => hundreds.to_i,
      :fifties => fifties.to_i,
      :twenties => twenties.to_i,
      :tens => tens.to_i, 
      :fives => fives.to_i,
      :ones => ones.to_i
      }
  return @money
else
  thousands2 = '0'
  fivehundreds2 = '0'
  hundreds2 = '0'
  fifties2 = '0'
  twenties2 = '0'
  tens2 = '0'
  fives2 = '0'
  ones2 = '0'

  @money2 = {
    :thousands => thousands2.to_i,
    :five_hundreds => fivehundreds2.to_i,
    :hundreds => hundreds2.to_i,
    :fifties => fifties2.to_i,
    :twenties => twenties2.to_i,
    :tens => tens2.to_i,
    :fives => fives2.to_i,
    :ones => ones2.to_i
  }
  return @money2
end
  end
end