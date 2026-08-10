extends CharacterBody2D
@export_enum("clock", "cclock") var direction: String
@export var size = 0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export_enum("left", "down", "right", "up") var facing: String
var moves_made = 0
var movedl = false
var movedr = false
var movedu = false
var movedd = false
const SPEED = 32
var pos = self.position
var gt = 0
var tick = 0
@export var max_tick = 0
func _ready() -> void:
	pos = Vector2(round(position.x/32) * 32 +16, round(position.y/32)*32-16)
	self.position = pos
	match facing:
		"left":
			animated_sprite_2d.play("left")
			movedl = true
			movedr = false
			movedu = false
			movedd = false
		"right":
			animated_sprite_2d.play("right")
			movedl = false
			movedr = true
			movedu = false
			movedd = false
		"up":
			animated_sprite_2d.play("up")
			movedl = false
			movedr = false
			movedu = true
			movedd = false
		"down":
			animated_sprite_2d.play("down")
			movedl = false
			movedr = false
			movedu = false
			movedd = true
func _physics_process(delta: float) -> void:
	if Global.tick > gt:
		gt += 1
		tick += 1
	if tick == max_tick:
		tick = 0
		move()
func move():
	Sfx.emove()
	pos = self.position
	if movedl:
		animated_sprite_2d.play("left")
		pos.x -= SPEED
		moves_made +=1
		if moves_made >= size:
			moves_made = 0
			if direction == "clock":
				movedu = true
				movedl = false
			else:
				movedd = true
				movedl = false
	elif movedr:
		animated_sprite_2d.play("right")
		pos.x +=SPEED
		moves_made += 1
		if moves_made >= size:
			moves_made = 0
			if direction == "clock":
				movedd = true
				movedr = false
			else:
				movedu = true
				movedr = false
	elif movedu:
		animated_sprite_2d.play("up")
		pos.y -= SPEED
		moves_made +=1
		if moves_made >= size:
			moves_made = 0
			if direction == "clock":
				movedr = true
				movedu = false
			else:
				movedl = true
				movedu = false
	elif movedd:
		animated_sprite_2d.play("down")
		pos.y += SPEED
		moves_made +=1
		if moves_made >= size:
			moves_made = 0
			if direction == "clock":
				movedl = true
				movedd = false
			else:
				movedr = true
				movedd = false
	self.position = pos
	adjust()
func adjust():
	pos = Vector2(round(pos.x/32) * 32 +16, round(pos.y/32)*32-16)
