extends HBoxContainer

var dictValue

signal data_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_text(text):
	$Text.text = text

func _on_delete_pressed():
	data_changed.emit(null)

func _on_text_text_changed(new_text):
	data_changed.emit(new_text)
