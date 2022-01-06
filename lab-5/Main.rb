load 'CashMachine.rb'
require 'socket'
require 'rack'
require 'rack/utils'

server = TCPServer.new 1080
puts('Server started!')

while (connection = server.accept)

  atm = CashMachine.new
  method = 'balance'
  value = nil

  request = connection.gets
  next if request.nil?

  full_path = request.split(' ')
  next unless full_path[0] == 'GET'

  path = full_path[1].split('/')[1]
  
  if !path.nil? && path.include?('?')
    method = path.split('?')[0]
    value = path.split('?')[1].split('=')[1].to_i
  elsif !path.nil?
    method = path
  end

  answer = "HTTP/1.1 200\r\nContent-Type: text/html\r\n\r\n<title>#{method}</title>"

  menu = '
  <a href="http://localhost:3000/withdraw?value=10">Withdraw</a><br>
  <a href="http://localhost:3000/deposit?value=10">Deposit</a><br>
  <a href="http://localhost:3000/balance">Balance</a><br>
  '
  answer += menu + case method
            when 'deposit'
                atm.deposit(value).to_s
            when 'withdraw'
                atm.withdraw(value).to_s
            when 'balance'
                atm.balance.to_s
            else
              'Error 404. Page not found'
            end

  connection.print answer
  connection.close
  atm.quit

end