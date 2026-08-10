extends StaticBody2D
var pos
var is_pressed = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var door: NodePath
@export var door2: NodePath
@export var door3: NodePath
func _ready() -> void:
	pos = Vector2(round(position.x/32) * 32 +16, round(position.y/32)*32-16)
	self.position = pos


func _on_area_2d_area_entered(area: Area2D) -> void:
	Sfx.click()
	if area.is_in_group("but") and not is_pressed:
		is_pressed = true
		animated_sprite_2d.play("pressed")
		_unlock_doors()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("but") and is_pressed:
		is_pressed = false
		animated_sprite_2d.play("default")
		_lock_doors()

func _unlock_doors():
	for door_path in [door, door2, door3]:
		var doorn = get_node_or_null(door_path)
		if doorn: doorn.unlock()

func _lock_doors():
	await get_tree().create_timer(0.2).timeout
	var still_on_button = false
	for body in $Area2D.get_overlapping_areas():
		if body.is_in_group("but"):
			still_on_button = true
			break
	if not still_on_button:
		for door_path in [door, door2, door3]:
			var doorn = get_node_or_null(door_path)
			if doorn: doorn.lock()
