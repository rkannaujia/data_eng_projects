#indexing and sclicing
text = "Python"
#extract the first character
print(text[0]) # print(-6) will also work
#extract the last character
print(text[-1]) # print(5) will also work
date= "2026-03-15"
#extract the year
print(date[0:4]) # print(date[:4]) will also work

#extract the month
print(date[5:7])

text = " Engineering"
print(text.lstrip()) # remove leading whitespace
text = "Engineering "
print(text.rstrip()) # remove trailing whitespace
text = " Engineering "
print(text.strip()) # remove leading and trailing whitespace
no_of_spaces= len(text)-len(text.strip())
if (len(text) == len(text.strip())):
    print("no leading or trailing spaces")
else:    print(f"there are {no_of_spaces} leading or trailing spaces")

#challenge
text = "968-Maria, (D@t@ Engineer );; 27y  "
#clean the string (this messy string should be clean into a single clean)
# output=> name : maria | role: data engineer | age: 27
cleaned_text = text.replace()