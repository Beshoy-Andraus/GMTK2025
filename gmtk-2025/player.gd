extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var tile_map: TileMap = $"../TileMap"
@onready var timer: Timer = $Timer
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
const SPEED = 32
signal swap
var pos = self.position
var can_move = false
var ppos
var moves = 0
var a
var alive = true
func _ready() -> void:
	a = true
	moves = 0
	timer.start(Global.t)
	Global.player = self
	print("player = self")
	print(Global.player)
	pos = Vector2(round(position.x/32) * 32 +16, round(position.y/32)*32-16)
	self.position = pos
	Global.tick = 0
func _physics_process(delta: float) -> void:
	adjust()
	ppos = self.position
	pos = ppos
	if alive:
		if Input.is_action_just_pressed("respawn"):
			Global.Game_over = true
			alive = false
			die()
		if Input.is_action_just_pressed("left"):
			moves += 1
			detect_map(-1, 0)
			if can_move:
				Sfx.p_move()
				animated_sprite_2d.frame = 0
				animated_sprite_2d.stop()
				animated_sprite_2d.play("jump")
				pos = Vector2(pos.x + (SPEED*-1), pos.y)
		if Input.is_action_just_pressed("right"):
			moves += 1
			detect_map(1, 0)
			if can_move:
				Sfx.p_move()
				animated_sprite_2d.frame = 0
				animated_sprite_2d.stop()
				animated_sprite_2d.play("jump")
				pos = Vector2(pos.x + (SPEED), pos.y)
		if Input.is_action_just_pressed("up"):
			moves += 1
			detect_map(0, -1)
			if can_move:
				Sfx.p_move()
				animated_sprite_2d.frame = 0
				animated_sprite_2d.stop()
				animated_sprite_2d.play("jump")
				pos = Vector2(pos.x, pos.y + (SPEED * -1))
		if Input.is_action_just_pressed("down"):
			moves += 1
			detect_map(0, 1)
			if can_move:
				Sfx.p_move()
				animated_sprite_2d.frame = 0
				animated_sprite_2d.stop()
				animated_sprite_2d.play("jump")
				pos = Vector2(pos.x, pos.y + (SPEED)) 
		else:
			play()
		
		self.position = pos
func play():
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.play("default") 
func adjust():
	pos = Vector2(round(pos.x/32) * 32 +16, round(pos.y/32)*32-16)
func detect_map(direcx, direcy):
	var at
	var tp = Vector2i(floor(pos.x / 32), floor(pos.y/32))
	var check = tp + Vector2i(direcx, direcy)
	at = tile_map.get_cell_atlas_coords(0, check)
	if at == Vector2i(-1,-1):
		can_move = false
	else:
		can_move = true
	return can_move


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		print("ded")
		Global.Game_over = true
		alive = false
		die()
	if area.is_in_group("no") and not area.is_in_group("open"):
		position = ppos
func die():
	if a:
		Sfx.explo()
		a = false
		self.hide()
		timer.stop()
		var explosion = preload("res://explosion_particles.tscn").instantiate()
		explosion.global_position = global_position
		get_parent().add_child(explosion)
		explosion.emitting = true
		await explosion._ready()
		Global.player = null
		Global.Game_over = false
		Tran.trans()
		await Tran.fade
		print("get_tree(): ", get_tree())
		get_tree().reload_current_scene()
	else: 
		pass
	
func tp():
	Sfx.swa()
	animated_sprite_2d_2.show()
	animated_sprite_2d_2.play("default")
	await animated_sprite_2d_2.animation_finished
	emit_signal("swap")
	animated_sprite_2d_2.hide()
func _on_timer_timeout() -> void:
	Global.tick += Global.tt
