extends VBoxContainer


var medias = {}
var dictRef = null
var currentID = 0
var currentVID = SharedCounter.new()

@onready var mediaCell = load("res://ProjectInterface/StartInfo/Media/media_edit.tscn")


# Just checks if it should hide the none label
func _process(delta):
	$NoneLabel.visible = len(medias) == 0

func addMedia(mediaData):
	var splitdata = Array(mediaData.split("|"))
	var newMedia = mediaCell.instantiate()
	medias[splitdata[0]] = newMedia
	if int(splitdata[0]) > currentID:
		currentID = int(splitdata[0])
	newMedia.setup_from_export(dictRef,currentVID,splitdata)
	$ContentScroll/Content.add_child(newMedia)

func removeMedia(id):
	medias[str(id)].queue_free()
	medias.erase(str(id))

func getMedia(id):
	return medias[str(id)]

func getMediaList(id):
	return medias.values.map(func(value): return {"id":value.id,"text":value.get_presentable_text})

func filter(filter_text = ""):
	if filter_text == "test":
		print(build_talkshow())
		return
	if filter_text == "testobj":
		print(save_as_object())
		return
	if filter_text == "":
		for a in medias.values():
			a.visible = true
	else:
		for a in medias.values():
			a.filter(filter_text)


func setup(dictList):
	dictRef = dictList


func _on_add_pressed():
	var newMedia = mediaCell.instantiate()
	currentID += 1
	newMedia.setup(dictRef,currentVID,str(currentID))
	medias[str(currentID)] = newMedia
	$ContentScroll/Content.add_child(newMedia)


func save_as_object():
	var object = {}
	for a in medias:
		object[a] = medias[a].save_as_object()
	return object

func build_talkshow():
	var media_string = ""
	var didCarotSkip = false #change if a better idea comes up
	for a in medias.values():
		if didCarotSkip:
			media_string = media_string + "^"
		didCarotSkip = true
		media_string = media_string + str(a)
	return media_string
