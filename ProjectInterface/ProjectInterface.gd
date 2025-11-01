extends Control


const bar_bounds = [20,500] #This is the bound for the bar, used in _on_split_between_info_dragged


var flowcharts_ref = [] #Charts reference

#StartData (temp till class)
var start_flowchart = null #Starting point for flowchart
var start_cell = null #Starting cell in starting flowchart
var project_name = null #Dict index of name, kinda unimportant tbh
var workspace_name = null #Dict index of name, kinda unimportant tbh
var time_stamp = null #Might be unimportant, but could be handy to reset when building
var dict = [] #Dictionary of all texts, needs index
var child_subroutines = [] #Literally no idea
var child_templates = [] #Literally no idea
var projects = [] #Pretty much wont need to be dealt with, could hide behind advanced?
var packages = [] #Actions are in individual packages, also animations ig
var flowcharts = [] #Individual flow data, will be getting updated a lot
var actions = [] #Functions pretty much, also pain town usa
var templates = [] #Templates, pretty much prompt data, unsure how used it is


var start_data_class = null



# Called when the node enters the scene tree for the first time.
func _ready():
	print("Display menu")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_split_between_info_dragged(offset):
	if offset < bar_bounds[0]:
		$SplitBetweenInfo.split_offset = bar_bounds[0]
	if offset > bar_bounds[1]:
		$SplitBetweenInfo.split_offset = bar_bounds[1]

func startRef():
	return $SplitBetweenInfo/StartInfo

#TODO
#1: Make a loader from json (this is the save file)
