module PagesHelper
 require "money"
 def format_currency(salary)
    Money.new(salary, "USD")
 end

end
