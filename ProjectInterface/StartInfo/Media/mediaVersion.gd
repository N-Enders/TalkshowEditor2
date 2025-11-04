extends GraphNode


var dictValue = null
var tagValue = null
var vidIDRef = null

signal updated

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#Setup for importing, do not call when creating a new version
func setup(id,locale,dict,tags,type):
	#Sets values with their starting data
	id_changed(str(id),$IdInfo/Id/IdEdit)
	$IdInfo/Id/IdEdit.text = str(id)
	$IdInfo/Locale/LocaleEdit.text = str(locale)
	$DictEdit.text = str(dict)
	$FileInfo/Tags/TagEdit.text = str(tags)
	$FileInfo/Type/TypeEdit.text = str(type)


#Setup for dictionary stuff
func setup_dictionary(dictRef:DictionaryList,vidCounter:SharedCounter,dict="",tags=""):
	dictValue = DictionaryValue.new(dictRef,str(dict))
	tagValue = DictionaryValue.new(dictRef,str(tags))
	$DictEdit.text_changed.connect(dict_value_change.bind(dictValue,$DictEdit)) #Setup for dictionary class for dictionary
	$FileInfo/Tags/TagEdit.text_changed.connect(dict_value_change_line.bind(tagValue,$FileInfo/Tags/TagEdit)) #Setup for dictionary class for tags
	vidIDRef = vidCounter
	$IdInfo/Id/IdEdit.text_changed.connect(id_changed.bind($IdInfo/Id/IdEdit))


#Used for sending the data to the DictionaryList (this is only for box edit)
func dict_value_change(value,valueRef):
	value.setValue(valueRef.text)

#Used for sending the data to the DictionaryList (this is only for line edit)
func dict_value_change_line(new_value,value,valueRef):
	value.setValue(new_value)


func getDict():
	return dictValue.getValue()


func setid(id):
	$IdInfo/Id/IdEdit.text = str(id)
	id_changed(str(id),$IdInfo/Id/IdEdit)

func id_changed(value,valueRef):
	if value.is_valid_int():
		vidIDRef.addNumber(int(value))
		valueRef.modulate = Color.WHITE
		valueRef.tooltip_text = ""
	else:
		valueRef.modulate = Color.RED
		valueRef.tooltip_text = "Text must be a valid integer!"


func _to_string():
	return $IdInfo/Id/IdEdit.text+"|"+$IdInfo/Locale/LocaleEdit.text+"|"+str(tagValue.getIndex())+"|"+str(dictValue.getIndex())+"|" + $FileInfo/Type/TypeEdit.text


func save_as_object():
	return {"id":int($IdInfo/Id/IdEdit.text),
	"locale":$IdInfo/Locale/LocaleEdit.text,
	"tags":tagValue.getValue(),
	"dict":dictValue.getValue(),
	"type":$FileInfo/Type/TypeEdit.text}


func filter(filter_text):
	if filter_text in dictValue.getDisplayValue():
		return true
	return false
