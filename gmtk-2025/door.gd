extends StaticBody2D
@onready var area_2d: Area2D = $Area2D
@export var dir_up = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var pos
var dir
func unlock():
	Sfx.odoor()
	animated_sprite_2d.play("open")
	area_2d.add_to_group("open")
	area_2d.remove_from_group("no")
	area_2d.hide()
func lock():
	Sfx.odoor()
	animated_sprite_2d.play("default")
	area_2d.remove_from_group("open")
	area_2d.add_to_group("no")
	area_2d.show()
	if Global.player.position.distance_to(self.position) < 1.0:
		Global.player.position += dir * 32
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos = Vector2(round(position.x/32) * 32 +16, round(position.y/32)*32-16)
	self.position = pos
	if dir_up:
		dir = Vector2(0, -1)
	else:
		dir = Vector2(0, 1)
