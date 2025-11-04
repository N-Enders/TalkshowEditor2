extends GraphNode

var ID = null
var dictReference = null
var projectRef = null
var nameValue = null

signal updated

const typeReferences = {"Internal":0,"SWF":1,"Code":2,"I":0,"S":1,"C":2}

#dictRef.get_value_index(int(data.pop_front()))


func setup_from_export(dictRef:DictionaryList,data,projects):
	dictReference = dictRef
	projectRef = projects
	projectRef.updated.connect(update_project_select.bind(projectRef))
	update_project_select(projectRef)
	var id = data.pop_front()
	setID(id)
	nameValue = DictionaryValue.new(dictRef,str(dictRef.getValueIndex(int(data.pop_front()))))
	$NameType/Name/NameEdit.text = nameValue.getDisplayValue()
	$NameType/Name/NameEdit.text_changed.connect(dict_value_change_line.bind(nameValue,$NameType/Name/NameEdit)) #Setup for dictionary class for tags
	var type = data.pop_front()
	$NameType/Type/TypeSelect.selected = typeReferences[type]
	var parentID = int(data.pop_front())
	$ParentSelect.selected = $ParentSelect.get_item_index(parentID)

#Used for sending the data to the DictionaryList (this is only for line edit)
func dict_value_change_line(new_value,value,valueRef):
	value.setValue(new_value)

func update_project_select(projects):
	var savedID = get_selected_parent_id()
	$ParentSelect.clear()
	for a in projects.getProjectList():
		$ParentSelect.add_item(a.text,a.id)
	if savedID != null:
		$ParentSelect.selected = $ParentSelect.get_item_index(savedID)

func setup(dictRef:DictionaryList,id,projects):
	dictReference = dictRef
	setID(id)
	projectRef = projects
	nameValue = DictionaryValue.new(dictRef,"")
	$NameType/Name/NameEdit.text_changed.connect(dict_value_change_line.bind(nameValue,$NameType/Name/NameEdit)) #Setup for dictionary class for tags


func setID(id):
	ID = int(id)
	name = id
	title = "Package (" + str(id) + ")"

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
	return str(ID)+"|"+str(nameValue.getIndex())+"|"+["I","S","C"][$NameType/Type/TypeSelect.selected]+"|"+projectRef.getProject(get_selected_parent_id()).getID()



func save_as_object():
	return {"id":ID,
	"name":nameValue.getValue(),
	"type":["I","S","C"][$NameType/Type/TypeSelect.selected],
	"Parent":projectRef.getProject(get_selected_parent_id()).getID()}


func get_selected_parent_id():
	if $ParentSelect.selected == -1:
		return null
	return $ParentSelect.get_item_id($ParentSelect.selected)
