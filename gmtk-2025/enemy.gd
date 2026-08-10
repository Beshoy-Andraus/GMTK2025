extends CharacterBody2D
@export var left = false
@export var right = false
@export var up = false
@export var down = false
@export var moves = 0
var blinking = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var moves_madeu = 0
var moves_maded = 0
var moves_madel = 0
var moves_mader = 0
var movedl = false
var movedr = false
var movedu = false
var movedd = false
const SPEED = 32
var pos = self.position
var gt = 0
var tick = 0
var ticks_left
var ppos
@export var max_tick = 0
func _ready() -> void:
	gt = 0
	pos = Vector2(round(position.x/32) * 32 +16, round(position.y/32)*32-16)
	self.position = pos
func _physics_process(delta: float) -> void:
	ppos = self.position
	pos = ppos
	if Global.Game_over:
		return
	if Global.tick > gt:
		gt += 1
		tick += 1
	if tick == max_tick:
		tick = 0
		move()
func move():
	pos = self.position
	animated_sprite_2d.play("up")
	if left:
		if !movedl:
			moves_madel += 1
			pos = Vector2(pos.x + (SPEED*-1), pos.y)
			if moves_madel == moves:
				movedl = true
		elif movedl:
			moves_madel -= 1
			pos = Vector2(pos.x + (SPEED), pos.y)
			if moves_madel == 0:
				movedl = false
	if right:
		if !movedr:
			moves_mader += 1
			pos = Vector2(pos.x + (SPEED), pos.y)
			if moves_mader == moves:
				movedr = true
		elif movedr:
			moves_mader -= 1
			pos = Vector2(pos.x + (SPEED*-1), pos.y)
			if moves_mader == 0:
				movedr = false
	if up:
		if !movedu:
			moves_madeu += 1
			pos = Vector2(pos.x, pos.y + (SPEED * -1))
			if moves_madeu == moves:
				movedu = true
		elif movedu:
			moves_madeu -= 1
			pos = Vector2(pos.x, pos.y + (SPEED))
			if moves_madeu == 0:
				movedu = false
	if down:
		if !movedd:
			moves_maded += 1
			pos = Vector2(pos.x, pos.y + (SPEED))
			if moves_maded == moves:
				movedd = true
		elif movedd:
			moves_maded -= 1
			pos = Vector2(pos.x, pos.y + (SPEED * -1))
			if moves_maded == 0:
				movedd = false
	Sfx.emove()
	self.position = pos
	adjust()
func blink():
	if blinking:
		return
	blinking = true
func adjust():
	pos = Vector2(round(pos.x/32) * 32 +16, round(pos.y/32)*32-16)
	await  animated_sprite_2d.animation_finished
	animated_sprite_2d.play("default")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("no") and not area.is_in_group("open"):
		position = ppos
