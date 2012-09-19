# test by ruby 1.9.2

class Account
end

class UserInfo
  attr_reader(:age)
  attr_accessor(:name)
  
  def initialize(name, age)
    @name = name
    @age = age
  end
end

acct = Account.new

# below shows how to define method with instance
def acct.initialize(userInfo, number, name, balance)
  @userInfo = userInfo
  @number = number
  @name = name
  @balance = balance
end

def acct.userInfo
  @userInfo
end
def acct.number
  @number
end

def acct.name
  @name
end

def acct.balance
  @balance
end

def acct.deposit(money)
  if money <= 0
      raise  ArgumentError, "必須是正數"
  end
  @balance += money
end

def acct.withdraw(money)
  if money > @balance
      raise  RuntimeError, "餘額不足"
  end
  @balance -= money
end

acct.initialize(UserInfo.new("luc", 30), "123-456-789", "Justin", 0)
puts acct.userInfo.name
puts acct.userInfo.age
puts acct.number    # 123-456-789
puts acct.name      # Justin

acct.deposit(100)
puts acct.balance   # 100
acct.withdraw(50)
puts acct.balance   # 50
puts acct.userInfo.name = acct.name

puts 5.times