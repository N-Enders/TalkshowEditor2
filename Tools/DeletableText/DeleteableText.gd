extends HBoxContainer

var dictValue

signal data_changed

\
func set_text(text):
	$Text.text = text

func _on_delete_pressed():
	data_changed.emit(null)

func _on_text_text_changed(new_text):
	data_changed.emit(new_text)
