extends VBoxContainer

var projects = {}
var dictRef = null
var currentID = 0

signal updated

@onready var projectCell = load("res://ProjectInterface/StartInfo/Projects/project_edit.tscn")

# Just checks if it should hide the none label
func _process(delta):
	$NoneLabel.visible = len(projects) == 0


func addProject(projectData):
	var splitdata = Array(projectData.split("|"))
	var newProject = projectCell.instantiate()
	projects[splitdata[0]] = newProject
	if int(splitdata[0]) > currentID:
		currentID = int(splitdata[0])
	newProject.setup_from_export(dictRef,splitdata)
	newProject.updated.connect(func():
		updated.emit())
	$ContentScroll/Content.add_child(newProject)
	updated.emit()

func removeProject(id):
	projects[str(id)].start_removal()
	projects[str(id)].queue_free()
	projects.erase(str(id))
	updated.emit()

func getProject(id):
	return projects[str(id)]

func getProjectList():
	return projects.values().map(func(value): return {"id":value.getID(),"text":value.get_presentable_text()})


func filter(filter_text = ""):
	if filter_text == "":
		for a in projects.values():
			a.visible = true
	else:
		for a in projects.values():
			a.filter(filter_text)


func setup(dictList):
	dictRef = dictList


func _on_add_pressed():
	var newProject = projectCell.instantiate()
	currentID += 1
	newProject.setup(dictRef,str(currentID))
	projects[str(currentID)] = newProject
	$ContentScroll/Content.add_child(newProject)
	updated.emit()


func save_as_object():
	var object = {}
	for a in projects:
		object[a] = projects[a].save_as_object()
	return object

func build_talkshow():
	var project_string = ""
	var didCarotSkip = false #change if a better idea comes up
	for a in projects.values():
		if didCarotSkip:
			project_string = project_string + "^"
		didCarotSkip = true
		project_string = project_string + str(a)
	return project_string
