extends CharacterBody2D
@export_enum("clock", "cclock") var direction: String
@export var baf = false
@export_enum("left", "down", "right", "up") var facing: String
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var moves_made = 0
var rot = 0
var moved = false
const SPEED = 32
var pos = self.position
var gt = 0
var tick = 0
var dir
@export var max_tick = 0
func _ready() -> void:
	animated_sprite_2d.set_frame_and_progress(0,0)
	animated_sprite_2d_2.set_frame_and_progress(0,0)
	animated_sprite_2d.play("default")
	animated_sprite_2d_2.play("default")
	if direction == "clock":
		dir = 1
	else: 
		dir = -1
	
	pos = Vector2(round(position.x/32) * 32 +16, round(position.y/32)*32-16)
	self.position = pos
	match facing:
		"left":
			rotation_degrees = 180
		"right":
			rotation_degrees = 0
		"up":
			rotation_degrees = 270
		"down":
			rotation_degrees = 90
	if Global.Game_over:
		return
func _physics_process(delta: float) -> void:
	if Global.tick > gt:
		gt += 1
		tick += 1
	if tick == max_tick:
		tick = 0
		move()
func move():
	if baf:
		dir *= -1
	rotation_degrees += dir * 90
	adjust()
func adjust():
	pos = Vector2(round(pos.x/32) * 32 +16, round(pos.y/32)*32-16)
