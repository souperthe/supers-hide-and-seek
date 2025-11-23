@icon("res://assets/images/icons/microphone.svg")
class_name VoiceEmitter extends Node


@export var targetEmitter:AudioStreamPlayer3D
@export var targetPlayer:Player
@export var _talkingSprite:Sprite3D

var _voiceBuffer: PackedByteArray = PackedByteArray()
var _playback:AudioStreamGeneratorPlayback = null
var _hasLoopback: bool = true

var speaking:bool = false



const targetRate:int = 12000


func _ready() -> void:
	set_multiplayer_authority(
		targetPlayer.get_multiplayer_authority()
	)
	
	var audioGenerator:AudioStreamGenerator = AudioStreamGenerator.new()
	audioGenerator.mix_rate = targetRate
		
	targetEmitter.stream = audioGenerator
	targetEmitter.play()
	
	_playback = targetEmitter.get_stream_playback()
	
	assert(targetEmitter != null, "Target emitter must be valid")
	assert(targetPlayer != null, "Target player must be valid")
	
	if !is_multiplayer_authority():
		return
		
		
	print("starting voice")
	Steam.startVoiceRecording()
	return
	
const _noiseFloor: float = 0.015 
const _targetPeak: float = 0.18

var _peak: float = 0.01
var _gain: float = 1.0
	
func dymanicGain(sample: float) -> float:
	var absSample:float = abs(sample)
	if absSample < _noiseFloor:
		_peak *= 0.995/2
		return 0.0 
	
	_gain = max(_peak * 0.9995, absSample)
	_gain = _targetPeak / max(_peak, 0.01)
	_gain = clamp(_gain, 0.1, 12.0)
	return _gain
	
	
@rpc("any_peer", "call_remote", "unreliable")
func _processVoice(voiceData:Dictionary) -> void:
	var decompressedVoice: Dictionary = Steam.decompressVoice(voiceData["buffer"], targetRate)
	
	if decompressedVoice["result"] == Steam.VOICE_RESULT_OK and decompressedVoice["size"] > 0:
		
		_voiceBuffer = decompressedVoice['uncompressed']
		_voiceBuffer.resize(decompressedVoice['size'])
		
		#print(decompressedVoice['size'])
		
		
		if _playback == null:
			return
		
		for i: int in range(0, mini(_playback.get_frames_available() * 2, _voiceBuffer.size()), 2):
			var low: int = _voiceBuffer[0]
			var high: int = _voiceBuffer[1]
			#var raw_value: int = _voiceBuffer[0] | (_voiceBuffer[1] << 8)
			var raw_value: int = (high << 8) | low
			#raw_value = (raw_value + 32768) & 0xffff
			if raw_value >= 32768:
				raw_value -= 65536
			
			#var amplitude: float = float(raw_value - 32768) / 32768.0
			var amplitude: float = float(raw_value) / 32768.0
			
			
			amplitude *= dymanicGain(amplitude)
			
			amplitude = clamp(amplitude, -1.0, 1.0)
		
			
			
			_playback.push_frame(Vector2(amplitude, amplitude))
			
			_voiceBuffer.remove_at(0)
			_voiceBuffer.remove_at(0)
			continue
			
		
	return
	
func _checkVoice() -> void:
	var voiceData: Dictionary = Steam.getVoice()
	
	if voiceData["result"] == Steam.VOICE_RESULT_OK and voiceData["written"]:
		if _hasLoopback:
			_processVoice.rpc(voiceData)
	return
	
	
	
func _process(_delta: float) -> void:
	
	if _playback == null:
		return
	
	var frames:float = _playback.get_frames_available()/float(targetRate)
	
	#print(frames)
	#print(frames)
	
	speaking = frames < 0.68
	
	if _talkingSprite:
		_talkingSprite.visible = speaking
	
	
	if !is_multiplayer_authority():
		return
		
	_checkVoice()
	return
