print(isinstance(10, int)) # True
email = "rahul@gmail.com"
phone = "+91 750-602-4841"
username = "rahul"
password = ""
print(any([email, phone, username])) # True
print(all([email, phone, username])) # True
print(all([email, phone, username, password])) # False


email=None
print( email is not None or email != "") #True or False = True
# check if user's name is not empty and the age is greater than or equal to 18
name = "Lucy"
age = 25
print( name != "" and age >= 18)

# check if the password is atleast 8 characters long and does not contain spaces
password ="Rahul@8080"
print(len(password) >= 8 and " " not in password)
# check if the user's email is not empty. conatains '@'. and ends with '.com'

email= "test@gmail.com"
print(email != "" and '@' in email and email.endswith('.com'))

# check if the username is a string, is not None, and is longer than 5 characters
username ="Rahulk"
print(isinstance(username,str) and username is not None and len(username) > 5)

