class_name SharedCounter

var count = 0

func _init():
	count = 0

func getNextCount():
	count += 1
	return count

func addNumber(number):
	if number > count:
		count = number
	print(number)
