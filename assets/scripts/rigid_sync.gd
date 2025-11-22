class_name RigidSync extends RigidBody3D


var _synced:bool = false
var _replicated_position : Vector3
var _replicated_rotation : Vector3
var _replicated_linear_velocity : Vector3
var _replicated_angular_velocity : Vector3

@rpc("any_peer", "call_remote", "unreliable")
func syncPosition(pos:Vector3, rot:Vector3, velo:Vector3, angvelo:Vector3)->void:
	_replicated_linear_velocity = velo
	_replicated_angular_velocity = angvelo
	
	_replicated_position = pos
	_replicated_rotation = rot
	_synced = true
	return


func _integrate_forces(_state: PhysicsDirectBodyState3D) -> void:
	if freeze:
		return
	if is_multiplayer_authority():
		syncPosition.rpc(
			position, 
			rotation, 
			linear_velocity, 
			angular_velocity
			)
	else:
		if !_synced:
			return
		linear_velocity = _replicated_linear_velocity
		angular_velocity = _replicated_angular_velocity
		position = _replicated_position
		rotation = _replicated_rotation
	return
