extends Area

export(String) var nodePath = ""

func _ready():
	connect("body_entered", self, "_on_body_enter")
	connect("body_exited", self, "_on_body_exit")

func _on_body_enter(body):
	print(body.get_name() + " entered the area")
	if(body.get_name() == "Player"):
		get_node(nodePath).activated = true
	
	
func _on_body_exit(body):
	print(body.get_name() + " exited the area")
	if(body.get_name() == "Player"):
		get_node(nodePath).activated = false
