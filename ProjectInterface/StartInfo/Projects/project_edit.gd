extends GraphNode

var ID = null
var dictReference = null
var nameValue = null

signal updated

func setup_from_export(dictRef:DictionaryList,data):
	dictReference = dictRef
	var id = data.pop_front()
	setID(id)
	nameValue = DictionaryValue.new(dictRef,str(dictRef.getValueIndex(int(data.pop_front()))))
	$NameEdit.text = nameValue.getDisplayValue()
	nameValue.connectValueEdit($NameEdit,func():
		updated.emit()) #Setup for dictionary class for tags


func setup(dictRef:DictionaryList,id):
	dictReference = dictRef
	setID(id)
	nameValue = DictionaryValue.new(dictRef,"")
	nameValue.connectValueEdit($NameEdit,func():
		updated.emit()) #Setup for dictionary class for tags

func setID(id):
	ID = int(id)
	name = id
	title = "Project (" + str(id) + ")"

func getID():
	return ID

func get_presentable_text():
	return "(" + str(ID) + ") " + nameValue.getDisplayValue()

func filter(filter_text):
	if filter_text in str(ID):
		visible = true
		return
	if filter_text in nameValue.getDisplayValue():
		visible = true
		return
	visible = false
	return


func _to_string():
	return str(ID)+"|"+str(nameValue.getIndex())


func save_as_object():
	return {"id":ID,
	"name":nameValue.getValue()}
