extends Sprite2D
var flag = 0
var po = 1
var count = 0
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		flag^=1
		if not $a1.is_playing():
			if count:
				po *= (-1)**count
				count = 0
				$a1.speed_scale = 1
			if flag and po>0:
				$a1.play("test1_action")
				count+=1
			if not flag and po<0:
				$a1.play("test2_action")
				count+=1
		else:
			$a1.speed_scale*=-1
			count+=1
		print(flag,po,count)
