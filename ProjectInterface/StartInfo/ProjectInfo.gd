extends TabContainer



@onready var dictValues = DictionaryList.new([])



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func getMedia():
	pass

func getPackage():
	pass

func getAction():
	pass

func getTemplate():
	pass

func getFlowchart():
	pass

func getProject():
	pass


func setStartingDict(values):
	dictValues = DictionaryList.new(values)
