extends HSplitContainer

@onready var dictValues = DictionaryList.new(["","value2","gronk"])
@onready var deleteable_text = preload("res://Tools/DeletableText/deleteable_text.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Text.text = str(dictValues)


func dict_value_change(change,value,ref):
	if change == null:
		value.delete()
		ref.queue_free()
	else:
		value.setValue(change)


func _on_add_pressed():
	var new_text = deleteable_text.instantiate()
	$Items.add_child(new_text)
	var DictVal = DictionaryValue.new(dictValues)
	new_text.data_changed.connect(dict_value_change.bind(DictVal,new_text))
