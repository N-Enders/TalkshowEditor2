extends Node

var id = null
var parents = []
var children = {}
var start_ref = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func setID(CellID:String):
	id = CellID

func getID():
	return id

func setComment(value):
	pass #TODO later

func getComment():
	pass #TODO later

func resetRefs():
	parents = []
	children = {}

func setChild(slot,ref):
	children[str(slot)] = ref
	ref.setParent(self)

func removeChild(slot):
	pass #TODO later

func getChild(slot):
	return children[str(slot)]

#Might need to change to allow for removal?
func setParent(ref):
	parents.append(ref)

func removeParent(ParentID):
	pass #TODO later

func getParents():
	return parents

func getLocation():
	pass #TODO later

func setStartRef(ref):
	start_ref = ref
