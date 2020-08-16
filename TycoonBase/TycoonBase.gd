extends Spatial


export var color = Color()

onready var material = SpatialMaterial.new()



func _ready():
	material.albedo_color = color
	colorObjects()



#Colors all meshinstances that are in the group 'Colored'
func colorObjects():
	var childrenCount = self.get_child_count()
	for i in range(childrenCount):
		var child = self.get_child(i)
		for k in range(child.get_child_count()):
			var grandChild = child.get_child(k)
			if grandChild.get_child_count() > 0:
				for j in range(grandChild.get_child_count()):
					var otherChild = grandChild.get_child(j)
					if otherChild.is_in_group("Colored"):
						otherChild.set_surface_material(0, material)
			
