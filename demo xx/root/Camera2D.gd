
extends Camera2D
@onready var player = get_node('../player')
var init_positionx = self.position.x
var init_positiony = self.position.y
# Called every frame. 'delta' is the elapsed time since the previous frame.
func a():
	self.position.x = player.position.x  + init_positionx-player.init_pox
	self.position.y = player.position.y + init_positiony-player.init_poy
