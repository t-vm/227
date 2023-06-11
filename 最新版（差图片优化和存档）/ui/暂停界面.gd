extends Node2D

var flag = -1
@onready var player = get_node('../player')
@onready var v_box = $Control/VBoxContainer
@onready var color_rect = $Control/ColorRect

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x = player.position.x+500
	self.position.y = player.position.y-400
func _input(event):
	if Input.is_action_just_released("esc"):
		v_box.visible = -1*int(v_box.visible)+1
		get_tree().paused = not get_tree().paused
		


func _on_button_button_down():
	v_box.visible = -1*int(v_box.visible)+1
	get_tree().paused = not get_tree().paused



func _on_button_2_button_down():
	get_tree().change_scene_to_file("res://全部游戏/开始界面/开始界面.tscn")
	get_tree().paused = not get_tree().paused
