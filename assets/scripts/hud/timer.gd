extends Control

@onready var timerLabel: Label = $Time/TimerLabel
@onready var seekerLabel: Label = $Seeker/InfoLabel

func _process(_delta: float) -> void:
	var timeleft = Networking.hostEvents.seekTimer.time_left
	
	var minutes : float = timeleft / 60
	var seconds : float = int(timeleft) % 60
	var milli : float = int((timeleft - int(timeleft)) * 100)
	timerLabel.text = "%02d:%02d.%02d" % [minutes,seconds,milli]
