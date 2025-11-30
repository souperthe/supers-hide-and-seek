@icon("res://assets/images/icons/punch.svg")
class_name HitboxManager extends Node

@export var _hitboxHolder:Node3D
@export var _corePlayer:Player

var _allBoxes:Dictionary[String, Area3D]




func hitboxDamage(hitboxName:String, amount:float, knockback:Vector3) -> bool:
	var bodies:Array[Node3D] = checkHitbox(hitboxName)
	
	#print(bodies)
	
	
	for body in bodies:
		
		print(body)
		
		if body is Player:
			
			if body == _corePlayer:
				continue
				
			print(body)
				
			if body.currentTeam != superEnum.teams.hider:
				continue
				
			
			
			body.events.damageEvent.rpc(amount, knockback)
			return true
		elif body is DoorCollision:
			
			if !body.destroyed:
				
				body.breakEvent.rpc()
				
				return true
		
		
		continue
	
	return false



func checkHitbox(hitboxName:String) -> Array[Node3D]:
	
	if !_allBoxes.has(hitboxName):
		return []
		
	var desiredBox:Area3D = _allBoxes[hitboxName.to_lower()]
	
	
	return desiredBox.get_overlapping_bodies()



func _ready() -> void:
	
	var hitboxChildren:Array[Node] = _hitboxHolder.get_children()
	
	for hitbox in hitboxChildren:
		
		if !(hitbox is Area3D):
			continue
			
		_allBoxes[hitbox.name.to_lower()] = hitbox
		
		
		continue
	
	
	return
