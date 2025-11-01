extends GraphNode


@export var versionEdit: PackedScene


var ID = null
var dictReference = null
var projectRef = null

const typeReferences = {"Internal":0,"SWF":1,"Code":2,"I":0,"S":1,"C":2}


#Potential additions: Add button for versions
# collapsable versions (just setting $MediaList.visible to true and false starting with false)


func setup_from_export(dictRef:DictionaryList,data):
	dictReference = dictRef
	var id = data.pop_front()
	setID(id)
	var project_name = data.pop_front() #TODO: Create dictionart value for this
	var type = data.pop_front()
	$NameType/Type/TypeSelect.selected = typeReferences[type]
	var parentID = data.pop_front()
	$ParentSelect.selected = projectRef.get_project_index(parentID)


func setup(dictRef:DictionaryList,id,projects):
	dictReference = dictRef
	setID(id)
	projectRef = projects


func setID(id):
	ID = int(id)
	name = id
	title = "Package (" + str(id) + ")"


#TODO: Change to new thing
func filter(filter_text):
	print(filter_text)
	print(str(ID))
	if filter_text in str(ID):
		visible = true
		return
	visible = false
	return


#TODO: Change to new thing
func _to_string():
	#var stringify_list = [str(ID)+"|"+["A","G","T"][$Types.selected]+"|"+str(len(versions))]
	#var version_strings = versions.map(func(version):return str(version))
	#stringify_list.append_array(version_strings)
	#return "|".join(stringify_list)
	return



#TODO: Change to new thing
func save_as_object():
	return {"id":ID,
	"name":"",
	"type":["I","S","C"][$NameType/Type/TypeSelect.selected],
	"Parent":$ParentSelect.selected}
