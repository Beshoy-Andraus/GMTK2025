extends StaticBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var flag: Area2D = $flag
@export var next_level: PackedScene
func _ready() -> void:
	var pos = Vector2(round(position.x/32) * 32 +16, round(position.y/32)*32-16)
	self.position = pos
	animated_sprite_2d.play("default")
func _on_flag_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): 
		Global.player.hide()
		Global.t += 1
		animated_sprite_2d.play("active")
		Sfx.flags()
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.hide()
		if next_level != null:
			Global.tick = 0
			Tran.trans()
			await Tran.fade
			get_tree().change_scene_to_packed(next_level)
		else:
			print("No next level assigned!")
