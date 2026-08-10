extends Node2D
@onready var marker_2d: Marker2D = $Marker2D
var mp
func _ready() -> void:
	mp = marker_2d.position
	mp = Vector2(round(mp.x/32) * 32 +16, round(mp.y/32)*32-16)
	Global.tick = 0
	Global.t = 0.3
	var player_scene = preload("res://player.tscn")
	var player = player_scene.instantiate()
	add_child(player)
	print("Player added at position: ", player.position)
	player.position = Vector2(mp)
	await get_tree().create_timer(0.1).timeout
	Global.Game_over = false


func _on_texture_button_18_pressed() -> void:
	Tran.animation_player.animation_finished.connect(
		func(_anim_name):
			get_tree().change_scene_to_file("res://starting_screen.tscn"),
		CONNECT_ONE_SHOT
	)
	Sfx.click()
	Music.intros()
	get_tree().change_scene_to_file("res://starting_screen.tscn")
