load 'CashMachine.rb'
require 'socket'
require 'rack'
require 'rack/utils'

server = TCPServer.new 3000
puts('Server started!')

while (connection = server.accept)

  atm = CashMachine.new
  method = 'main'
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

  answer += case method
            when 'main'
                '
                <a href="http://localhost:3000/withdraw?value=10">/withdraw?value=10</a><br>
                <a href="http://localhost:3000/deposit?value=10">/deposit?value=10</a><br>
                <a href="http://localhost:3000/balance">/balance</a><br>
                '
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