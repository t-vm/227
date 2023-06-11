extends Sprite2D
@onready var door_close = $"."
@onready var static_body_2d = $StaticBody2D





func _on__body_entered(body):
	door_close.visible = false
	static_body_2d.collision_layer = 2

func _on__body_exited(body):
	door_close.visible = true
	static_body_2d.collision_layer = 1
