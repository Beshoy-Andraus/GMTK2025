extends CharacterBody2D
var pos = self.position
var gt = 0
var tick = 0
var activated = false
var shake_amount = 1.0
var shake_speed = 50.0
@export var max_tick = 0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
func _ready() -> void:
	process_priority = -2
	pos = Vector2(round(position.x/32) * 32 +16, round(position.y/32)*32-16)
	self.position = pos
func _physics_process(delta: float) -> void:
	if Global.Game_over:
		return
	if Global.tick > gt:
		gt += 1
		tick += 1
	if tick == max_tick:
		tick = 0
		speed()
	if activated:
		position = pos + Vector2(
			randf_range(-shake_amount, shake_amount),
			randf_range(-shake_amount, shake_amount)
		)
	else:
		position = pos
		pass
func speed():
	if !activated:
		Global.tt += 1
		activated = true
		animated_sprite_2d.play("active")
	elif activated:
		Global.tt -= 1
		activated = false
		animated_sprite_2d.play("default")
