class_name DictionaryList

#The reason this system is in place is so then I can use less resources when changing the list

var value_dict = {} #Used to keep track if things should be removed from values
var values = [] #List of all original values
var current_id = 0 #incremented each time a new value is added

#If there is prexisting dictionary data it will get passed here on init.
func _init(starting_dict = []):
	values = Array(starting_dict)

#Adds a value and hooks up its signal to the data changed function
#Also starts the value off with an ID and sets its value in value_dict
func addValue(ref):
	current_id += 1
	ref.setID(current_id)
	value_dict[str(ref)] = null
	valueChanged(null,ref.getValue(),ref)
	ref.value_changed.connect(valueChanged.bind(ref))

#Called when the value is changed, will remove the old value if no other items have it and will add the new value if it isnt already in the list
func valueChanged(old,new,ref):
	if new == null:
		new = ""
	value_dict[str(ref)] = new
	if not old in value_dict.values() and old != null:
		values.erase(old)
	if not new in values:
		values.append(new)

#Used by DictionaryValue to get its own position in the dictionary
func getIndex(value):
	return values.find(value)

#Used to delete an item's value and if no other item has its value removes it from the list
func deleteRef(ref):
	var item = value_dict[str(ref)]
	value_dict.erase(str(ref))
	if not item in value_dict.values():
		values.erase(item)

#This is literally the exact thing needed to export the data to Talkshow's dict string
func _to_string():
	return "^".join(values)

#Used to get a full list of values
func get_values():
	return values

#Used to get a specific value, mainly used for importing.
func getValueIndex(index):
	if index == "":
		return ""
	if int(index) > len(values) - 1:
		return null
	else:
		return values[int(index)]

func getDisplayValueIndex(index):
	if index == "":
		return ""
	if int(index) > len(values) - 1:
		return null
	else:
		return values[int(index)].replace("&#8248;","^")
