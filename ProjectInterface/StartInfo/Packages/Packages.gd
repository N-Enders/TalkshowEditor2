extends VBoxContainer

var packages = {}
var dictRef = null
var currentID = 0

@onready var mediaCell = load("res://ProjectInterface/StartInfo/Media/media_edit.tscn")

# Just checks if it should hide the none label
func _process(delta):
	$NoneLabel.visible = len(packages) == 0


func addPackage(packageData):
	var splitdata = Array(packageData.split("|"))
	var newMedia = mediaCell.instantiate()
	medias[splitdata[0]] = newMedia
	if int(splitdata[0]) > currentID:
		currentID = int(splitdata[0])
	newMedia.setup_from_export(dictRef,currentVID,splitdata)
	$ContentScroll/Content.add_child(newMedia)
