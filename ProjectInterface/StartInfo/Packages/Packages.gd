extends VBoxContainer

var packages = {}
var dictRef = null
var currentID = 0
var projectRef = null

signal updated

@onready var packageCell = load("res://ProjectInterface/StartInfo/Packages/package_edit.tscn")

# Just checks if it should hide the none label
func _process(delta):
	$NoneLabel.visible = len(packages) == 0


func addPackage(packageData):
	var splitdata = Array(packageData.split("|"))
	var newPackage =  packageCell.instantiate()
	packages[splitdata[0]] = newPackage
	if int(splitdata[0]) > currentID:
		currentID = int(splitdata[0])
	newPackage.setup_from_export(dictRef,splitdata,projectRef)
	newPackage.updated.connect(func():
		updated.emit())
	$ContentScroll/Content.add_child(newPackage)
	updated.emit()

func removePackage(id):
	packages[str(id)].start_removal()
	packages[str(id)].queue_free()
	packages.erase(str(id))
	updated.emit()

func getPackage(id):
	return packages[str(id)]

func getPackageList():
	return packages.values().map(func(value): return {"id":value.getID(),"text":value.get_presentable_text()})


func filter(filter_text = ""):
	if filter_text == "":
		for a in packages.values():
			a.visible = true
	else:
		for a in packages.values():
			a.filter(filter_text)


func setup(dictList,projects):
	dictRef = dictList
	projectRef = projects


func _on_add_pressed():
	var newPackage = packageCell.instantiate()
	currentID += 1
	newPackage.setup(dictRef,str(currentID),projectRef)
	packages[str(currentID)] = newPackage
	$ContentScroll/Content.add_child(newPackage)
	updated.emit()


func save_as_object():
	var object = {}
	for a in packages:
		object[a] = packages[a].save_as_object()
	return object

func build_talkshow():
	var package_string = ""
	var didCarotSkip = false #change if a better idea comes up
	for a in packages.values():
		if didCarotSkip:
			package_string = package_string + "^"
		didCarotSkip = true
		package_string = package_string + str(a)
	return package_string
