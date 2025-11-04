class_name DictionaryValue

#Dictionary Value, allows for code to ask this class for its value and index for building purposes.

var saved_value:String = "" #String of the value.
var parent_dictionary_list:DictionaryList = null #the parent dictionary
var id = null #used to make sure it isn't a different piece of data

signal value_changed

#Hooks up the reference for the DictionaryList and gives it some start data aswell
func _init(ref:DictionaryList,start_value:String = ""):
	saved_value = start_value
	parent_dictionary_list = ref
	ref.addValue(self)

#Sets the value to a string which tells the DictionaryList to update its values
func setValue(value:String):
	value = value.replace("^","&#8248;") # This allows for "^" to still be used in the dictionary lists
	value_changed.emit(saved_value,value)
	saved_value = value

#Returns the string value
func getValue():
	return saved_value

#Used to display the value that contains "^"
func getDisplayValue():
	return saved_value.replace("&#8248;","^")

#Returns the index of the value in DictionaryList (used for building)
func getIndex():
	return parent_dictionary_list.getIndex(saved_value)

#Tells the BaseDictionary to remove the reference to this class
func delete():
	parent_dictionary_list.deleteRef(self)

#Used by BaseDictionary to keep each value seperate
func setID(setter):
	id = setter

#Used by BaseDictionary as a name for the value, all outside code must use either "getIndex()" or "getValue()"
func _to_string():
	return str(id)

