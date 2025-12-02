@icon("res://assets/images/icons/microphone.svg")
class_name VoiceEmitterOLD extends Node


@export var targetEmitter:Node
@export var targetPlayer:Player
var mic : AudioStreamPlayer


var buffer_size : int = 512
var bus : String 
var bus_idx : int
var capture : AudioEffectCapture 
var stream : AudioStreamGeneratorPlayback 

func _ready() -> void:
	
	assert(targetEmitter != null, "Target emitter must be valid.")
	
	if targetPlayer:
		set_multiplayer_authority(targetPlayer.authID)
	
	var generator:AudioStreamGenerator = AudioStreamGenerator.new()
	generator.mix_rate = 48000
	
	targetEmitter.stream = generator
	targetEmitter.play()
	
	
	if is_multiplayer_authority():
		
		bus_idx = AudioServer.get_bus_index(global.microphoneInput.bus)
		capture = AudioServer.get_bus_effect(bus_idx, 1)
		capture.clear_buffer()
		capture.reset_state()
		
		stream = targetEmitter.get_stream_playback()
	else: 
		targetEmitter.play()
		stream = targetEmitter.get_stream_playback()
		
	return
	
@rpc("any_peer", "call_remote", "reliable", 2)
func send_voice(data : PackedVector2Array) -> void:
	if stream == null:
		return
	if not data.is_empty():
		for i in range(0, data.size() - 1):
			stream.push_frame(data[i])
	return
	
func check_mic() -> void:
	buffer_size = capture.get_frames_available()
	
	#print(buffer_size)

	if buffer_size > 500:
		var voice_data : PackedVector2Array = capture.get_buffer(buffer_size)
		send_voice.rpc(voice_data)
		
	capture.clear_buffer()
	return

func _process(_delta: float) -> void:
	if is_multiplayer_authority():
		check_mic()
