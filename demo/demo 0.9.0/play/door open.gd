extends Sprite2D
@onready var door_open = $"."




func _on__body_entered(body):
	door_open.visible = true


func _on__body_exited(body):
	door_open.visible = false
