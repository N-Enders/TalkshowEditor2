extends HSplitContainer

#Will be removed upon addition of of either start data or flowchart


@onready var dictValues = DictionaryList.new(["","value2","gronk"])
@onready var deleteable_text = preload("res://Tools/DeletableText/deleteable_text.tscn")


func _ready():
	pass


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
