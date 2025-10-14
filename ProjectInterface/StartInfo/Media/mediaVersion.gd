extends GraphNode


var dictValue = null
var tagValue = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Setup for importing, do not call when creating a new version
func setup(id,locale,dict,tags,type):
	#Sets values with their starting data
	$IdInfo/Id/IdEdit.text = str(id)
	$IdInfo/Locale/LocaleEdit.text = str(locale)
	$DictEdit.text = str(dict)
	$FileInfo/Type/TagEdit.text = str(tags)
	$FileInfo/Type/TypeEdit.text = str(type)

#Setup for dictionary stuff
func setup_dictionary(dictRef:DictionaryList,dict="",tags=""):
	dictValue = DictionaryValue.new(dictRef,dict)
	tagValue = DictionaryValue.new(dictRef,tags)
	$DictEdit.text_changed.connect(dict_value_change.bind(dictValue,$DictEdit)) #Setup for dictionary class for dictionary
	$FileInfo/Tags/TagEdit.text_changed.connect(dict_value_change.bind(tagValue,$FileInfo/Tags/TagEdit)) #Setup for dictionary class for tags

#Used for sending the data to the DictionaryList
func dict_value_change(value,valueRef):
	value.setValue(valueRef.text)


func _to_string():
	return $IdInfo/Id/IdEdit.text+"|"+$IdInfo/Locale/LocaleEdit.text+"|"+str(tagValue.getIndex())+"|"+str(dictValue.getIndex())+"|" + $FileInfo/Type/TypeEdit.text

func save_as_object():
	return {"id":0} #TODO: Finish this
