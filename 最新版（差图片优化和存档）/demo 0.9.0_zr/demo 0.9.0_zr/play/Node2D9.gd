extends Node2D




func _on_area_2d_body_entered(body):
	if body.name == 'player':
		$"../Node2D7/Sprite2D5/light_sub4".symbol['type'] = 'light_move'
		$"../Node2D7/Sprite2D5/light_sub4".flag = 1
		self.queue_free()
