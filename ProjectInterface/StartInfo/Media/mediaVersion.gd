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
	dictValue.connectValueEdit($DictEdit)
	tagValue.connectValueEdit($FileInfo/Tags/TagEdit)
	vidIDRef = vidCounter
	$IdInfo/Id/IdEdit.text_changed.connect(id_changed.bind($IdInfo/Id/IdEdit))




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
