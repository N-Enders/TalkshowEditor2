extends VSplitContainer

var actionLoaded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not actionLoaded:
		self.split_offset = int(self.size.y)



#TODO
#
#
