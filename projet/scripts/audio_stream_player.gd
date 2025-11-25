extends AudioStreamPlayer

const level_music = preload("res://assets/audio/magic-fantasy-fairy-tale-music-431276.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
		
		stream = music
		volume_db = volume
		play()
		
func play_level_music():
	_play_music(level_music)
