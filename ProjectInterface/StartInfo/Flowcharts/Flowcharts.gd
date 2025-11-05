extends VBoxContainer

var flowcharts = {}
var dictRef = null
var currentID = 0
var projectRef = null

signal updated

@onready var flowchartCell = load("res://ProjectInterface/StartInfo/Flowcharts/flowhchart_edit.tscn")

# Just checks if it should hide the none label
func _process(delta):
	$NoneLabel.visible = len(flowcharts) == 0


func addFlowchart(flowchartData):
	var splitdata = Array(flowchartData.split("|"))
	var newFlowchart = flowchartCell.instantiate()
	flowcharts[splitdata[0]] = newFlowchart
	if int(splitdata[0]) > currentID:
		currentID = int(splitdata[0])
	newFlowchart.setup_from_export(dictRef,splitdata,projectRef)
	newFlowchart.updated.connect(func():
		updated.emit())
	$ContentScroll/Content.add_child(newFlowchart)
	updated.emit()

func removeFlowchart(id):
	flowcharts[str(id)].start_removal()
	flowcharts[str(id)].queue_free()
	flowcharts.erase(str(id))
	updated.emit()

func getFlowchart(id):
	return flowcharts[str(id)]

func getFlowchartList():
	return flowcharts.values().map(func(value): return {"id":value.getID(),"text":value.get_presentable_text()})


func filter(filter_text = ""):
	if filter_text == "test":
		print(build_talkshow())
		return
	if filter_text == "":
		for a in flowcharts.values():
			a.visible = true
	else:
		for a in flowcharts.values():
			a.filter(filter_text)


func setup(dictList,projects):
	dictRef = dictList
	projectRef = projects


func _on_add_pressed():
	var newFlowchart = flowchartCell.instantiate()
	currentID += 1
	newFlowchart.setup(dictRef,str(currentID),projectRef)
	flowcharts[str(currentID)] = newFlowchart
	$ContentScroll/Content.add_child(newFlowchart)
	updated.emit()


func save_as_object():
	var object = {}
	for a in flowcharts:
		object[a] = flowcharts[a].save_as_object()
	return object

func build_talkshow():
	var flowchart_string = ""
	var didCarotSkip = false #change if a better idea comes up
	for a in flowcharts.values():
		if didCarotSkip:
			flowchart_string = flowchart_string + "^"
		didCarotSkip = true
		flowchart_string = flowchart_string + str(a)
	return flowchart_string
