extends StaticBody

var scale0 = Vector3(2.0,2.0,2.0)
var scale1 = Vector3(0.1,0.1,0.1)
var lerpValue = 0.5

var activated = false

func _ready():
	pass 


func _process(delta):
	if(activated):
		lerpValue += delta
		if(lerpValue > 1.0):
			lerpValue = 0.0
			var tmp = scale0
			scale0 = scale1
			scale1 = tmp
			
		var scale = lerp(scale0, scale1, lerpValue)
		$MeshInstance.scale = scale
		print("Sphere is active")
	else:
		print("Sphere is inactive")
	
		
