phone = "+91 750-602-4841"
if phone.startswith("+91"):
    print("This is an Indian phone number.")
else:
    print("This is not an Indian phone number.")


email = "john.doe@example.com"
print(email.endswith("@gmail.com"))

file = "report.csv"
print(file.endswith(".csv"))

#search using in
print("@" in email)
print(email.find("@"))

phone1 = "+91-750-602-4841"
phone2= "91-750-602-4841"
phone3 = "0091-750-602-4841"
print(phone1.find("-")) # returns the index of the first occurrence of "-" :3
print(phone1[phone1.find("-")+1:]) # print(phone1[3:])
print(phone2[phone2.find("-")+1:])
print(phone3[phone3.find("-")+1:])