password = "1234a"
if len(password) < 8 :
    print("password is too short!")

text = """Python is easy to learn,
Python is powerful,
Manypeaople love python."""
print(text.count("python") ) # count will be one because it is case sensitive

#tranformation
price = "1234,56"
print(price.replace(",","."))

phone= "123-456-7890"
print(phone.replace("-",""))

price = "$1,299.99"
print(price.replace("$","").replace(",",""))

price_list = ["$1,299.99", "$2,499.99", "$3,999.99"]
cleaned_prices = []
for price in price_list:
    cleaned_prices.append(price.replace("$","").replace(",",""))
print(cleaned_prices)

#convert the messy phone number into a clean number format with only digits
phone = "+49 (176) 123-4567"
cleaned_phone_number = phone.replace("+","").replace(" ","").replace("(","").replace(")","").replace("-","");
print(cleaned_phone_number)

#concatenation
folder = "C:/Users/Rahul/Documents/"
filename = "report.csv"
full_path = folder + filename
print(full_path)

stamp  = "2026-03-15 12:30:45"
[date,time] = stamp.split(" ")
print("date:", date)
print("time:", time)