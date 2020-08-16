extends Spatial

export var color = Color()

onready var material = SpatialMaterial.new()



func _ready():
	material.albedo_color = color
	colorObjects()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



# Will color all meshinstances
func colorObjects():
	material.albedo_color = color
	var amountOfChildren = self.get_child_count()
	for i in range(amountOfChildren):
		var child = self.get_child(i)
		#checks if child is a parent to objects and colors 
		#any children that are in the colored group
		if child.get_child_count() > 0:
			for j in range(child.get_child_count()):
				var grandChild = child.get_child(j)
				if grandChild.is_in_group("Colored"):
					grandChild.set_surface_material(0, material)
		elif child.is_in_group("Colored"):
			child.set_surface_material(0, material)
			
		
	
