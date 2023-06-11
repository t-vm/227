extends Node2D
var f = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if f :
		$af.play("f")
	

func _on_afd_area_entered(area):
	if area == $'../../light_and_body/db':
		$af.hide()
		f=0
		$StaticBody2D.collision_layer = 2
		$"../../light_and_body/db".angal = 0.1
	
	



func _on_afd_area_exited(area):
	if area == $'../../light_and_body/db':
		$af.show()
		f = 1
		$StaticBody2D.collision_layer = 1
		$"../../light_and_body/db".angal = 0.01
