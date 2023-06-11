extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func gamestart():
	get_tree().change_scene_to_file("res://全部游戏/第一关.tscn")
 

func gameover():
	get_tree().quit()

