extends Sprite2D
var po = 0
var flag = 0
var t = 1
var i = 1
signal  feedback4
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flag:
		$"../AudioStreamPlayer2D2".play()
		if i:
			emit_signal("feedback4",1,0,0)
			i = 0
		if po < 1500  :
			self.position.x-= 4
			po += 4
		elif po>=1500 and po<2000 :
			self.position.x-= 2
			po += 2
		
		elif t:
			t=0
			$"../Test".f9_()
			$"../Test/dia2/AnimationPlayer".play("转场0.5")
			await $"../Test/dia2/AnimationPlayer".animation_finished
			get_tree().change_scene_to_file("res://全部游戏/转场2.tscn")
		
	

