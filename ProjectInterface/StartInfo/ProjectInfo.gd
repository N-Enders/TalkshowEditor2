extends TabContainer



@onready var dictValues = DictionaryList.new()

@onready var tabs = [$Media,$Packages,$Actions,$Templates,$Flowcharts,$Projects]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Media.setup(dictValues)


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


func filter(filter_text):
	tabs[current_tab].filter(filter_text)
