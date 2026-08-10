extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var tile_map: TileMap = $"../TileMap"
@export var max_tick = 0
@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
@export var swa = false
@export var cand = false
const SPEED = 32
var pos = self.position
var can_move = false
var tickable = true
var tick = 0
var ppos
@export var hide = false
func _ready() -> void:
	if swa == false:
		rich_text_label.hide()
	lab()
	animated_sprite_2d.play("default") 
	pos = Vector2(round(position.x/32) * 32 +16, round(position.y/32)*32-16)
	self.position = pos
func _physics_process(delta: float) -> void:
	ppos = self.position
	pos = ppos
	if Global.Game_over:
		return
	lab()
	if Input.is_action_just_pressed("left"):
		detect_map(-1, 0)
		if can_move:
			Sfx.emove()
			animated_sprite_2d.frame = 0
			animated_sprite_2d.stop()
			animated_sprite_2d.play("jump")
			pos = Vector2(pos.x + (SPEED*-1), pos.y)
	if Input.is_action_just_pressed("right"):
		detect_map(1, 0)
		if can_move:
			Sfx.emove()
			animated_sprite_2d.frame = 0
			animated_sprite_2d.stop()
			animated_sprite_2d.play("jump")
			pos = Vector2(pos.x + (SPEED), pos.y)
	if Input.is_action_just_pressed("up"):
		detect_map(0, -1)
		if can_move:
			Sfx.emove()
			animated_sprite_2d.frame = 0
			animated_sprite_2d.stop()
			animated_sprite_2d.play("jump")
			pos = Vector2(pos.x, pos.y + (SPEED * -1))
	if Input.is_action_just_pressed("down"):
		detect_map(0, 1)
		if can_move:
			Sfx.emove()
			animated_sprite_2d.frame = 0
			animated_sprite_2d.stop()
			animated_sprite_2d.play("jump")
			pos = Vector2(pos.x, pos.y + (SPEED))  
	else:
		play()
	self.position = pos
	if max_tick > 0  and Global.player and Global.player.moves > max_tick and swa:
		tick += 1
		if tick == max_tick:
			tick = 0
			Global.player.moves = 0
			await get_tree().process_frame
			Global.player.tp()
			tp()
			await Global.player.swap
			swap()
	adjust()
func play():
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.play("default") 
func adjust():
	pos = Vector2(round(pos.x/32) * 32 +16, round(pos.y/32)*32-16)
	tickable = true
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
func tp():
	animated_sprite_2d_2.show()
	animated_sprite_2d_2.play("default")
	await animated_sprite_2d_2.animation_finished
	animated_sprite_2d_2.hide()
func swap():
	if Global.player and Global.player != self:
		
		var ppos = Global.player.position
		Global.player.position = self.position
		self.position = ppos
func lab():
	if Global.player:
		var val = max_tick - Global.player.moves
		rich_text_label.clear()
		rich_text_label.append_text(str(val))


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("key") and hide == true:
		queue_free()
	if area.is_in_group("no") and not area.is_in_group("open"):
		position = ppos
