extends GraphNode


@export var versionEdit: PackedScene


var ID = null
var versions = []
var dictReference = null
var vidReference = null

const typeReferences = {"Audio":0,"Graphic":1,"Text":2,"A":0,"G":1,"T":2}

signal updated

#Potential additions: Add button for versions
# collapsable versions (just setting $MediaList.visible to true and false starting with false)


func setup_from_export(dictRef:DictionaryList,vidCounter:SharedCounter,data):
	dictReference = dictRef
	vidReference = vidCounter
	print(data)
	var id = data.pop_front()
	setID(id)
	var type = data.pop_front()
	$Types.selected = typeReferences[type]
	var count = int(data.pop_front())
	
	for a in range(count):
		var new_version = versionEdit.instantiate()
		
		var vid = data.pop_front()
		var locale = data.pop_front()
		var tag = dictRef.getDisplayValueIndex(int(data.pop_front()))
		var dict = dictRef.getDisplayValueIndex(int(data.pop_front()))
		var vtype = data.pop_front()
		
		
		new_version.setup_dictionary(dictRef,vidCounter,dict,tag)
		new_version.setup(vid,locale,dict,tag,vtype)
		$Medias/MediaList.add_child(new_version)
		
		versions.append(new_version)


func setup(dictRef:DictionaryList,vidCounter:SharedCounter,id):
	dictReference = dictRef
	vidReference = vidCounter
	setID(id)


func setID(id):
	ID = int(id)
	name = id
	title = "Media (" + str(id) + ")"

func getID():
	return ID


func get_presentable_text():
	if len(versions) > 0:
		return "(" + str(ID) + ") " + versions[0].getDict()
	return "(" + str(ID) + ") No versions"


func filter(filter_text):
	print(filter_text)
	print(str(ID))
	if filter_text in str(ID):
		visible = true
		return
	for a in versions:
		if a.filter(filter_text):
			visible = true
			return
	visible = false
	return

func _to_string():
	var stringify_list = [str(ID)+"|"+["A","G","T"][$Types.selected]+"|"+str(len(versions))]
	var version_strings = versions.map(func(version):return str(version))
	stringify_list.append_array(version_strings)
	return "|".join(stringify_list)


func _on_add_version_pressed():
	var new_version = versionEdit.instantiate()
	
	new_version.setup_dictionary(dictReference,vidReference)
	new_version.setid(vidReference.getNextCount())
	$Medias/MediaList.add_child(new_version)
	
	versions.append(new_version)

func save_as_object():
	return {"id":ID,
	"type":["A","G","T"][$Types.selected],
	"versions":versions.map(
		func(version):return version.save_as_object()
	)}
