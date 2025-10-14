extends GraphNode


@export var versionEdit: PackedScene


var ID = null


const typeReferences = {"Audio":0,"Graphic":1,"Text":2}


#Potential additions: Add button for versions
# collapsable versions (just setting $MediaList.visible to true and false starting with false)



func setID(mediaID):
	ID = mediaID

