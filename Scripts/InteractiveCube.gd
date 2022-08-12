extends StaticBody

const ROTATION_SPEED = 2.0
var activated = false

func _ready():
	pass 


func _process(delta):
	if(activated):
		$MeshInstance.rotate(Vector3(0.0,1.0,0.0), ROTATION_SPEED * delta)
