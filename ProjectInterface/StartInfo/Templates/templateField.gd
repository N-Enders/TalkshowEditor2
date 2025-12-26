extends GraphNode

var dictionaryRef = null

#Needed dict values (name,default value(some times),variable)

var nameValue = null
var variableValue = null

var defaultValue = null

var field_id = null

#fData = i.split(DELIMITER_FIELD_DATA); - ,
#type = fData[2];
#def = type == "A" || type == "G" ? fData[3] : dict.lookup(fData[3]);
#f = new TemplateField(int(fData[0]),dict.lookup(fData[1]),type,def,dict.lookup(fData[4]));
#fields["F" + f.id] = f;

#TemplateField(id:int, name:String, type:String, def:String, variable:String)
#id,name (dict), type, default, dict(variable)

signal updated

const typeReferences = {"Audio":0,"Boolean":1,"Graphic":2,"Number":3,"String":4,"A":0,"B":1,"G":2,"N":3,"S":4}


# Called when the node enters the scene tree for the first time.
func _ready():
	$TypeSelect.item_selected.connect(type_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#Fields (id ,name ,type ,default value ,variable)


#Setup for importing, do not call when creating a new version
func setup(dictRef:DictionaryList,id,field_name,type,default,variable):
	dictionaryRef = dictRef
	#Sets values with their starting data
	nameValue = DictionaryValue.new(dictRef,str(dictRef.getValueIndex(int(field_name))))
	$NameEdit.text = nameValue.getDisplayValue()
	nameValue.connectValueEdit($NameEdit)
	variableValue = DictionaryValue.new(dictRef,str(dictRef.getValueIndex(variable)))
	$VarEdit.text = variableValue.getDisplayValue()
	variableValue.connectValueEdit($VarEdit)
	setid(id)
	$TypeSelect.selected = typeReferences[type]
	
	if $TypeSelect.selected in [0,2]:
		defaultValue = DictionaryValue.new(dictRef,str(dictRef.getValueIndex(int(default))))
		$DefaultEdit.text = defaultValue.getDisplayValue()
		defaultValue.connectValueEdit($DefaultEdit)
		$DefaultEdit.visible = true
		$DefaultBoolean.visible = false
	elif $TypeSelect.selected == 1:
		if default == 1:
			$DefaultBoolean.button_pressed = true
		else:
			$DefaultBoolean.button_pressed = false
		$DefaultEdit.visible = false
		$DefaultBoolean.visible = true
	else:
		$DefaultEdit.text = str(default)
		$DefaultEdit.visible = true
		$DefaultBoolean.visible = false
	
	$TypeSelect.item_selected.connect(type_changed)


#DefaultValueText
	#Audio & graphic just use a number
	#If it switches to audio or graphic then erase and delete dict value

func type_changed(selection):
	if $TypeSelect.selected in [0,2]:
		defaultValue = DictionaryValue.new(dictionaryRef,$DefaultEdit.text)
		defaultValue.connectValueEdit($DefaultEdit)
		$DefaultEdit.visible = true
		$DefaultBoolean.visible = false
	elif $TypeSelect.selected == 1:
		$DefaultEdit.visible = false
		$DefaultBoolean.visible = true
		if defaultValue is DictionaryValue:
			defaultValue.delete()
			defaultValue = null
	else:
		if defaultValue is DictionaryValue:
			defaultValue.delete()
			defaultValue = null
		$DefaultEdit.visible = true
		$DefaultBoolean.visible = false

func setid(id):
		field_id = id


func _to_string():
	var default_value = get_default_value() #TODO: Figure out how to export default values
	return field_id+","+str(nameValue.getIndex())+","+["A","B","G","N","S"][$TypeSelect.selected]+","+default_value+","+str(variableValue.getIndex())


func save_as_object():
	var default_value = "" #TODO: Figure out how to export default values
	return {"id":int(field_id),
	"name":nameValue.getValue(),
	"type":$TypeSelect.selected,
	"default":default_value,
	"var":variableValue.getValue()}

func get_default_value():
	if $TypeSelect.selected in [0,2]:
		return defaultValue.getIndex()
	if $TypeSelect.selected == 1:
		if $DefaultBoolean.button_pressed:
			return 1
		else:
			return 0
	return int($DefaultEdit.text)

