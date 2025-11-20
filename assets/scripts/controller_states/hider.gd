extends ControllerState

@export var _tiltPivot:Node3D

func controllerStart(_message:String="")->void:
	actionTransition(_initalAction)
	return
	
func controllerProcess(delta:float) -> void:
	
	_tiltPivot.rotation.z = lerpf(
		_tiltPivot.rotation.z,
		-corePlayer.rawDir.x/12,
		6*delta)
	
	return
