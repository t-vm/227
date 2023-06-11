extends Area2D
@onready var animation_player = $AnimationPlayer
@onready var bg_2 = $"../../bg2"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):#播放动画并转场
	$"../../player".stop()
	bg_2.layer = -1
	animation_player.play("转场1")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://全部游戏/转场1.tscn")
	
	
