extends GraphEdit


#Needed Info
var actions = {}
var importedFlows = {}
var localDictionary = []
var startData = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func setupRef(startRef):
	startData = startRef


func load_details():
	print("display throbber")
