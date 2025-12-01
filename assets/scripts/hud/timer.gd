extends Control

@onready var timerLabel: Label = $Time/TimerLabel
@onready var seekerLabel: Label = $Seeker/InfoLabel
var active: bool = true

func _ready() -> void:
	
	var seekers:Array = Networking.hostEvents.seekers
	
	var seekersNames:Array[String]
	var namesString:String = ""
	
	for seeker: int in seekers:
		var seekerData:Dictionary = Networking.players[seeker]
		var seekerName:String = seekerData.get("username")
		
		seekersNames.append(seekerName)
		continue
		
	for indx: int in range(seekersNames.size()):
		var seekerName:String = seekersNames[indx]
		
		
		if indx != 0:
			namesString += ", "
		
		namesString += seekerName
		
		continue
		
	print(namesString)
	
	var aretheSeekers:String = " is the Seeker"
	
	if seekersNames.size() > 1:
		aretheSeekers = " are the Seekers"
	
	seekerLabel.text = namesString + aretheSeekers
	
	
	
	return

func _process(_delta: float) -> void:
	if not active: return
	var timeleft = Networking.hostEvents.seekTimer.time_left
	
	var minutes : float = timeleft / 60
	var seconds : float = int(timeleft) % 60
	var milli : float = int((timeleft - int(timeleft)) * 100)
	timerLabel.text = "%02d:%02d.%02d" % [minutes,seconds,milli]
