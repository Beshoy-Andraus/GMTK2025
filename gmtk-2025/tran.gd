extends CanvasLayer
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer
signal fade
func _ready() -> void:
	print(get_node_or_null("ColorRect"))
	color_rect.hide()
	animation_player.animation_finished.connect(on)
func on(anim_name):
	if anim_name == "dark":
		fade.emit()
		animation_player.play("light")
	elif anim_name == "light":
		color_rect.show()
func trans():
	color_rect.show()
	animation_player.play("dark")
