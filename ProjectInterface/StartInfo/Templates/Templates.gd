extends VBoxContainer

var templates = {}
var dictRef = null
var currentID = 0
var projectRef = null

signal updated

@onready var templateCell = load("res://ProjectInterface/StartInfo/Packages/package_edit.tscn")

# Just checks if it should hide the none label
func _process(delta):
	$NoneLabel.visible = len(templates) == 0


func addTemplate(templateData):
	var splitdata = Array(templateData.split("|"))
	var newTemplate = templateCell.instantiate()
	templates[splitdata[0]] = newTemplate
	if int(splitdata[0]) > currentID:
		currentID = int(splitdata[0])
	newTemplate.setup_from_export(dictRef,splitdata,projectRef)
	newTemplate.updated.connect(func():
		updated.emit())
	$ContentScroll/Content.add_child(newTemplate)
	updated.emit()

func removeTemplate(id):
	templates[str(id)].start_removal()
	templates[str(id)].queue_free()
	templates.erase(str(id))
	updated.emit()

func getTemplate(id):
	return templates[str(id)]

func getTemplateList():
	return templates.values().map(func(value): return {"id":value.getID(),"text":value.get_presentable_text()})


func filter(filter_text = ""):
	if filter_text == "":
		for a in templates.values():
			a.visible = true
	else:
		for a in templates.values():
			a.filter(filter_text)


func setup(dictList,projects):
	dictRef = dictList
	projectRef = projects


func _on_add_pressed():
	var newTemplate = templateCell.instantiate()
	currentID += 1
	newTemplate.setup(dictRef,str(currentID),projectRef)
	templates[str(currentID)] = newTemplate
	$ContentScroll/Content.add_child(newTemplate)
	updated.emit()


func save_as_object():
	var object = {}
	for a in templates:
		object[a] = templates[a].save_as_object()
	return object

func build_talkshow():
	var template_string = ""
	var didCarotSkip = false #change if a better idea comes up
	for a in templates.values():
		if didCarotSkip:
			template_string = template_string + "^"
		didCarotSkip = true
		template_string = template_string + str(a)
	return template_string
