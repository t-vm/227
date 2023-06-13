extends CanvasLayer

var dialogs= []
var index = 0
var _text_ = ''
var i = 0
signal normal_lens
@onready var content = $content
func _ready():
	content.hide()
func show_line(ind):#使对话框出现
	_text_ = dialogs[ind].name+dialogs[ind].text
	$content/Timer.start()
	
func _unhandled_input(event):#鼠标左键控制对话快速进行
	if event.is_action_pressed("left_click"):
		if i>0:
			$content/Timer.stop()
			i=0
			content.text = _text_
		elif index+1<dialogs.size():
			content.text = ''
			index+=1
			show_line(index)
		else:
			content.hide()
			content.text = ''
			index = 0
			emit_signal('normal_lens')
func show_dialogbox(t):#使对话框出现
	dialogs = t
	content.show()
	show_line(0)





	


func _on_content_visibility_changed():
	get_tree().paused = content.visible

func show_next():
	if i < _text_.length():
		content.text+=_text_[i]
		i+=1
	else:
		i=0
		$content/Timer.stop()
		
