extends Node2D

@onready var intro: AudioStreamPlayer = $AudioStreamPlayer
@onready var gameplay: AudioStreamPlayer = $AudioStreamPlayer2
@onready var gameplay2: AudioStreamPlayer = $AudioStreamPlayer3

var introon = false
var playing_gameplay1 = true
var nintro = true
var music_volume: float = 0.0

func intros():
	introon = true
	intro.volume_db = music_volume
	intro.play()
	if nintro == false:
		intro.volume_db = -80
		
		var tween = get_tree().create_tween()
		tween.tween_property(gameplay, "volume_db", -80.0, 1.5)
		tween.tween_property(gameplay2, "volume_db", -80.0, 1.5)
		tween.parallel().tween_property(intro, "volume_db", music_volume, 1.5)
		intro.play()
		gameplay.stop()
		gameplay2.stop()

func player():
	introon = false
	var tween = get_tree().create_tween()
	tween.tween_property(intro, "volume_db", -80.0, 1.5)
	gameplay.volume_db = -80.0
	gameplay.play()
	tween.parallel().tween_property(gameplay, "volume_db", music_volume, 1.5)
	playing_gameplay1 = true

func _on_audio_stream_player_finished() -> void:
	if introon:
		intro.play()

func _on_audio_stream_player_2_finished() -> void:
	if playing_gameplay1:
		nintro = false
		_crossfade(gameplay, gameplay2)
		playing_gameplay1 = false

func _on_audio_stream_player_3_finished() -> void:
	if not playing_gameplay1:
		nintro = false
		_crossfade(gameplay2, gameplay)
		playing_gameplay1 = true

func _crossfade(from_player: AudioStreamPlayer, to_player: AudioStreamPlayer):
	var tween = get_tree().create_tween()
	tween.tween_property(from_player, "volume_db", -80.0, 1.5)
	to_player.volume_db = -80.0
	to_player.play()
	tween.parallel().tween_property(to_player, "volume_db", music_volume, 1.5)
func set_music_volume(new_volume: float):
	music_volume = clamp(new_volume, -80.0, 0.0)
	if intro.playing:
		intro.volume_db = music_volume
	if gameplay.playing:
		gameplay.volume_db = music_volume
	if gameplay2.playing:
		gameplay2.volume_db = music_volume
