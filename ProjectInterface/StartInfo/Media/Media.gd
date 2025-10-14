extends VBoxContainer


var medias = {}

@onready var mediaCell = null #TODO: make media cell


# Just checks if it should hide the none label
func _process(delta):
	$NoneLabel.visible = len(medias) == 0


func addMedia():
	pass

func removeMedia():
	pass

func getMedia(id):
	return medias[str(id)]

func getMediaList(id):
	return medias.values.map(func(value): return {"id":value.id,"text":value.get_presentable_text})

func filter():
	pass
