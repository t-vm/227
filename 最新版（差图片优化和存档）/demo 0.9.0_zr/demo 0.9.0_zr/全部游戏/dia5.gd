extends Area2D
@onready var animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	animation_player.play("转场2")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://全部游戏/第二关.tscn")
