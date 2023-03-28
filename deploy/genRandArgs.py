import random
length = 100
myString = ""
for i in range(0,100):
	myString += " " + str(random.randint(1, 10000))
myString = str(length) + myString

print(myString)