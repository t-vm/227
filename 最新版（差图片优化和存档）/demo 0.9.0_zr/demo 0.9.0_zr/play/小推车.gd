extends RigidBody2D
@onready var player = $"../../../player"




func _on_area_2d_body_entered(body):
	if body == player:
		var pos = self.position.x
		var pos1 = player.position.x
		self.position.x += (pos - pos1)/abs(pos - pos1)*8
