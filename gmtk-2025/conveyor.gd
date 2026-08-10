extends StaticBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var left = false
@export var right = false
@export var up = false
@export var down = false
@export var starter = false
var active = {}
var pos
@export var max_tick = 0
var SPEED = 32
var go = true
var gt = 0
var tick = 0
var ticks_left
func _ready() -> void:
	adjust()
	pos = self.position
	if starter:
		go = true
	else:
		go = false
	if left:
		rotation_degrees = 90
	elif right:
		rotation_degrees = 270
	elif up:
		rotation_degrees = 180
	elif down:
		rotation_degrees = 0
	self.position = Vector2(round(position.x/32) * 32-16, round(position.y/32)*32-16)
func _physics_process(delta: float) -> void:
	adjust()
	if max_tick == 1:
		go = true
	if go == false:
		animated_sprite_2d.modulate = Color("#ffffff")
		animated_sprite_2d.pause()
	else:
		animated_sprite_2d.modulate = Color("#ffff00")
		animated_sprite_2d.play("default")
	if Global.Game_over:
		return
	if Global.tick > gt:
		gt += 1
		tick += 1
	if tick == max_tick:
		tick = 0
		flip()
func flip():
	go = !go
	if go:
		for body in active.keys():
			
			call_deferred("move", body)
	else:
		
		pass
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("con"):
		active[body] = true
		if go:
			if body.is_in_group("player"):
				Sfx.tread()
			call_deferred("move", body)
		
func move(body: Node2D):
	if not body:
		return
	var movev = Vector2.ZERO
	if left:
		rotation_degrees = 90
		body.position = Vector2(position.x + (SPEED*-1), position.y)
	elif right:
		rotation_degrees = 270
		body.position = Vector2(position.x + (SPEED), position.y)
	elif up:
		rotation_degrees = 180
		body.position = Vector2(position.x, position.y+ (SPEED*-1))
	elif down:
		rotation_degrees = 0
		body.position = Vector2(position.x, position.y+ (SPEED*1))
	else:
		body.position += movev
	await get_tree().create_timer(0.1).timeout
	active.erase(body)
func _on_area_2d_body_exited(body: Node2D) -> void:
	active.erase(body)
func adjust():
	pos = Vector2(round(position.x/32) * 32 +16, round(position.y/32)*32-16)
	await  animated_sprite_2d.animation_finished
	animated_sprite_2d.play("default")
