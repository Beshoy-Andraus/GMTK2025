extends TileMap
var t = 0
var ft = 0.2
var f = false
func _ready() -> void:
	self.modulate = Color("#ffffff")
func _physics_process(delta: float) -> void:
	if Global.tick != t:
		t = Global.tick
		self.modulate = Color("#264653")
		f = true
		ft = 0.1
	if f:
		ft -= delta
		if ft <= 0:
			self.modulate = Color("#ffffff")
			f = false
