hash = {}
sum = 0
total = 0

loop do 
  puts "Enter the product name or stop for exit: "
    purchase = gets.chomp.to_s
  
  break if purchase == "stop"
  if hash.include?(purchase) == true
    puts "Purchase already presence! Please new enter: "
    redo
  end   

    
  puts "Enter the price of the goods: "
    price = gets.chomp.to_f
  puts "Enter the quantity of the goods"    
    quantity = gets.chomp.to_f

  if hash.include?(purchase) == true
    hash[purchase] = hash[purchase + "a"] 
  end
    
  hash[purchase] = {price: price, quantity: quantity}
  
  sum = price * quantity  
  total += sum
end  

puts hash
puts "Total price: #{total}"

