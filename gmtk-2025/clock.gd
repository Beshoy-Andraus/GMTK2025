extends AnimatedSprite2D
var t = 0
var f = 0
func _ready() -> void:
	self.pause()
	self.set_frame_and_progress(f, 0.0)
func _physics_process(delta: float) -> void:
	if Global.hide:
		self.hide()
	else:
		self.show()
	if Global.tick != t:
		t = Global.tick
		f +=1
		
		if f >= 4:
			f = 0
		self.set_frame_and_progress(f, 0.0)
