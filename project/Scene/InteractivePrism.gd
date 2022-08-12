extends StaticBody

var color0 = Color(0.0,1.0,1.0,1.0)
var color1 = Color(1.0,0.0,1.0,1.0)
var lerpValue = 0.0

var activated = false

func _ready():
	pass 


func _process(delta):
	if(activated):
		lerpValue += delta
		if(lerpValue > 1.0):
			lerpValue = 0.0
			var tmp = color0
			color0 = color1
			color1 = tmp
			
		var material = $MeshInstance.get_surface_material(0)
		material.albedo_color = lerp(color0, color1, lerpValue)
		$MeshInstance.set_surface_material(0, material)
		
