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



func _on_du_qu_cun_dang_button_down():
	var file = FileAccess.open("res://存档.txt",FileAccess.READ)
	var k = file.get_var()
	get_tree().change_scene_to_file(k)
	file.close()

