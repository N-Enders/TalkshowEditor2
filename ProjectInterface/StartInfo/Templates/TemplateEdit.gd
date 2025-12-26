extends GraphNode


@export var fieldEdit: PackedScene


var ID = null
var fields = []
var dictReference = null
var vidReference = null
var projectRef = null

var nameValue = null

var recordSetIdx = null
var recordIdIdx = null

signal updated

#id| parent| name| parameters (this one is literally always "recordSet" and "recordId") | fields

func setup_from_export(dictRef:DictionaryList,vidCounter:SharedCounter,data,projects):
	dictReference = dictRef
	vidReference = vidCounter
	projectRef = projects
	projectRef.updated.connect(update_project_select.bind(projectRef))
	update_project_select(projectRef)
	var id = data.pop_front()
	setID(id)
	var parentID = int(data.pop_front())
	$ParentSelect.selected = $ParentSelect.get_item_index(parentID)
	nameValue = DictionaryValue.new(dictRef,str(dictRef.getValueIndex(int(data.pop_front()))))
	$NameEdit.text = nameValue.getDisplayValue()
	nameValue.connectValueEdit($NameEdit) #Setup for dictionary class for tags
	
	var params = data.pop_front() # this pretty much goes unused since its all "recordSet" and "recordId"
	recordSetIdx = DictionaryValue.new(dictRef,"recordSet")
	recordIdIdx = DictionaryValue.new(dictRef,"recordId")
	
	var fields = data.pop_front() # this pretty much goes unused since its all "recordSet" and "recordId"
	
	for a in fields.split("!"):
		var new_field = fieldEdit.instantiate()
		
		#id,name (dict), type, default, dict(variable)
		
		var field_split = a.split(",")
		var fid = data[0]
		var name = data[1]
		var type = data[2]
		var default = data[3]
		var variable = data[4]
		
		new_field.setup(dictRef,fid,name,type,default,variable)
		$FieldsList.add_child(new_field)
		
		fields.append(new_field)


func setup(dictRef:DictionaryList,vidCounter:SharedCounter,id):
	dictReference = dictRef
	vidReference = vidCounter
	setID(id)


func setID(id):
	ID = int(id)
	name = id
	title = "Template (" + str(id) + ")"

func getID():
	return ID


func get_presentable_text():
	return "(" + str(ID) + ") " + nameValue.getDisplayValue()


func filter(filter_text):
	if filter_text in nameValue.getDisplayValue():
		visible = true
		return
	if filter_text in str(ID):
		visible = true
		return
	visible = false
	return

#id| parent| name| parameters (this one is literally always "recordSet" and "recordId") | fields

func _to_string():
	var stringify_list = [str(ID)+"|"+str(projectRef.getProject(get_selected_parent_id()).getID())+"|"+str(nameValue.getIndex())+"|"+str(recordSetIdx.getIndex())+"!"+str(recordIdIdx.getIndex())]
	var field_strings = "!".join(fields.map(func(field):return str(field)))
	stringify_list.append(field_strings)
	return "|".join(stringify_list)


#func _on_add_version_pressed():
#	var new_version = versionEdit.instantiate()
#	
#	new_version.setup_dictionary(dictReference,vidReference)
#	new_version.setid(vidReference.getNextCount())
#	$Medias/MediaList.add_child(new_version)
#	
#	versions.append(new_version)

func save_as_object():
	return {"id":ID,
	"parent":projectRef.getProject(get_selected_parent_id()).getID(),
	"name":nameValue.getValue(),
	"versions":fields.map(
		func(version):return version.save_as_object()
	)}

func update_project_select(projects):
	var savedID = get_selected_parent_id()
	$ParentSelect.clear()
	for a in projects.getProjectList():
		$ParentSelect.add_item(a.text,a.id)
	if savedID != null:
		$ParentSelect.selected = $ParentSelect.get_item_index(savedID)

func get_selected_parent_id():
	if $ParentSelect.selected == -1:
		return null
	return $ParentSelect.get_item_id($ParentSelect.selected)
