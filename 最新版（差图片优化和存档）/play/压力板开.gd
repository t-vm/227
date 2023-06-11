extends Sprite2D
@onready var 压力板关 = $"../压力板关"
@onready var 压力板开 = $"."



func _on__body_entered(body):
	压力板开.visible = true


func _on__body_exited(body):
	压力板开.visible = false
