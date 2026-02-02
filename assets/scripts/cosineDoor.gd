@tool
extends MeshInstance3D

@onready var DoorOpen = $DoorOpen
@onready var DoorClose = $DoorClose
@onready var MathDoorClose = preload("res://assets/objects/map/cosines_campus/materials/mathdoor.tres")
@onready var BrownBrickMathDoorClose = preload("res://assets/objects/map/cosines_campus/materials/brownbrickmathdoor.tres")
@onready var WoodWallMathDoorClose = preload("res://assets/objects/map/cosines_campus/materials/coloredwoodwallmathdoor.tres")
@onready var SwingDoorClose = preload("res://assets/objects/map/cosines_campus/materials/swingdoor.tres")
@onready var SwingDoorCloseBrownBrick = preload("res://assets/objects/map/cosines_campus/materials/swingdoorbrownbrick.tres")
@onready var SwingDoorCloseOutdoorBrick = preload("res://assets/objects/map/cosines_campus/materials/swingdooroutdoorsbrick.tres")
@onready var SwingDoorCloseRedBrick = preload("res://assets/objects/map/cosines_campus/materials/swingdoorclassicbrick.tres")
@onready var HistoryDoorClose = preload("res://assets/objects/map/cosines_campus/materials/historydoor.tres")
@onready var ScienceDoorClose = preload("res://assets/objects/map/cosines_campus/materials/sciencedoor.tres")
@onready var ReadingDoorClose = preload("res://assets/objects/map/cosines_campus/materials/readingdoor.tres")
@onready var BrownBrickHistoryDoorClose = preload("res://assets/objects/map/cosines_campus/materials/brownbrickhistorydoor.tres")
@onready var BrownBrickScienceDoorClose = preload("res://assets/objects/map/cosines_campus/materials/brownbricksciencedoor.tres")
@onready var BrownBrickReadingDoorClose = preload("res://assets/objects/map/cosines_campus/materials/brownbrickreadingdoor.tres")
@onready var BambooScienceDoorClose = preload("res://assets/objects/map/cosines_campus/materials/bamboowallsciencedoor.tres")
@onready var SunsetWallReadingDoorClose = preload("res://assets/objects/map/cosines_campus/materials/sunsetwallreadingdoor.tres")
@onready var RedWallHistoryDoorClose = preload("res://assets/objects/map/cosines_campus/materials/redwallhistorydoor.tres")
@onready var FenceDoorClose = preload("res://assets/objects/map/cosines_campus/materials/fencedoor.tres")
@onready var FenceDoorBackClose = preload("res://assets/objects/map/cosines_campus/materials/fencedoorback.tres")
@onready var SwingDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/swingdooropen.tres")
@onready var SwingDoorOpenBrownBrick = preload("res://assets/objects/map/cosines_campus/materials/swingdoorbrownbrickopen.tres")
@onready var SwingDoorOpenOutdoorBrick = preload("res://assets/objects/map/cosines_campus/materials/swingdooroutdoorsbrickopen.tres")
@onready var SwingDoorOpenRedBrick = preload("res://assets/objects/map/cosines_campus/materials/swingdoorclassicbrickopen.tres")
@onready var MathDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/mathdooropen.tres")
@onready var HistoryDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/historydooropen.tres")
@onready var ScienceDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/sciencedooropen.tres")
@onready var ReadingDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/readingdooropen.tres")
@onready var BrownBrickMathDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/brownbrickmathdooropen.tres")
@onready var BrownBrickHistoryDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/brownbrickhistorydooropen.tres")
@onready var BrownBrickScienceDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/brownbricksciencedooropen.tres")
@onready var BrownBrickReadingDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/brownbrickreadingdooropen.tres")
@onready var WoodWallMathDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/coloredwoodwallmathdooropen.tres")
@onready var BambooScienceDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/bamboowallsciencedooropen.tres")
@onready var SunsetWallReadingDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/sunsetwallreadingdooropen.tres")
@onready var RedWallHistoryDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/redwallhistorydooropen.tres")
@onready var FenceDoorOpen = preload("res://assets/objects/map/cosines_campus/materials/fencedooropen.tres")
@onready var FenceDoorBackOpen = preload("res://assets/objects/map/cosines_campus/materials/fencedooropenback.tres")
@onready var BackSide = $DoorBack
@export var DoorType = "MathDoor"
@export var FrontWallType = "WhiteBrick"
@export var BackWallType = "WhiteBrick"
@export var Locked = false

@onready var DoorLockCollision = $StaticBody3D/CollisionShape3D

var IsDoorOpened = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if Locked == true:
		DoorLockCollision.disabled = false
	if DoorType == "SwingDoor":
		if FrontWallType == "BrownBrick":
			set_surface_override_material(0,SwingDoorCloseBrownBrick)
		elif FrontWallType == "OutdoorsBrick":
			set_surface_override_material(0,SwingDoorCloseOutdoorBrick)
		elif FrontWallType == "RedBrick":
			set_surface_override_material(0,SwingDoorCloseRedBrick)
		else:
			set_surface_override_material(0,SwingDoorClose)
		if BackWallType == "BrownBrick":
			BackSide.set_surface_override_material(0,SwingDoorCloseBrownBrick)
		elif BackWallType == "OutdoorsBrick":
			BackSide.set_surface_override_material(0,SwingDoorCloseOutdoorBrick)
		elif BackWallType == "RedBrick":
			BackSide.set_surface_override_material(0,SwingDoorCloseRedBrick)
		else:
			BackSide.set_surface_override_material(0,SwingDoorClose)
	elif DoorType == "HistoryDoor":
		if FrontWallType == "BrownBrick":
			set_surface_override_material(0,BrownBrickHistoryDoorClose)
		elif FrontWallType == "RedWall":
			set_surface_override_material(0,RedWallHistoryDoorClose)
		else:
			set_surface_override_material(0,HistoryDoorClose)
		if BackWallType == "BrownBrick":
			BackSide.set_surface_override_material(0,BrownBrickHistoryDoorClose)
		elif BackWallType == "RedWall":
			BackSide.set_surface_override_material(0,RedWallHistoryDoorClose)
		else:
			BackSide.set_surface_override_material(0,HistoryDoorClose)
	elif DoorType == "ScienceDoor":
		if FrontWallType == "BrownBrick":
			set_surface_override_material(0,BrownBrickScienceDoorClose)
		elif FrontWallType == "BambooWall":
			set_surface_override_material(0,BambooScienceDoorClose)
		else:
			set_surface_override_material(0,ScienceDoorClose)
		if BackWallType == "BrownBrick":
			BackSide.set_surface_override_material(0,BrownBrickScienceDoorClose)
		elif BackWallType == "BambooWall":
			BackSide.set_surface_override_material(0,BambooScienceDoorClose)
		else:
			BackSide.set_surface_override_material(0,ScienceDoorClose)
	elif DoorType == "ReadingDoor":
		if FrontWallType == "BrownBrick":
			set_surface_override_material(0,BrownBrickReadingDoorClose)
		elif FrontWallType == "SunsetWall":
			set_surface_override_material(0,SunsetWallReadingDoorClose)
		else:
			set_surface_override_material(0,ReadingDoorClose)
		if BackWallType == "BrownBrick":
			BackSide.set_surface_override_material(0,BrownBrickReadingDoorClose)
		elif BackWallType == "SunsetWall":
			BackSide.set_surface_override_material(0,SunsetWallReadingDoorClose)
		else:
			BackSide.set_surface_override_material(0,ReadingDoorClose)
	elif DoorType == "TwoDoorFence":
		set_surface_override_material(0,FenceDoorClose)
		BackSide.set_surface_override_material(0,FenceDoorBackClose)
	else:
		if FrontWallType == "BrownBrick":
			set_surface_override_material(0,BrownBrickMathDoorClose)
		elif FrontWallType == "WoodWall":
			set_surface_override_material(0,WoodWallMathDoorClose)
		else:
			set_surface_override_material(0,MathDoorClose)
		if BackWallType == "BrownBrick":
			BackSide.set_surface_override_material(0,BrownBrickMathDoorClose)
		elif BackWallType == "WoodWall":
			BackSide.set_surface_override_material(0,WoodWallMathDoorClose)
		else:
			BackSide.set_surface_override_material(0,MathDoorClose)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_area_3d_area_entered(area):
	if Engine.is_editor_hint():
		return
	if IsDoorOpened == false and Locked == false:
		IsDoorOpened = true
		DoorOpen.play()
		if DoorType == "SwingDoor":
			if FrontWallType == "BrownBrick":
				set_surface_override_material(0,SwingDoorOpenBrownBrick)
			elif FrontWallType == "OutdoorsBrick":
				set_surface_override_material(0,SwingDoorOpenOutdoorBrick)
			elif FrontWallType == "RedBrick":
				set_surface_override_material(0,SwingDoorOpenRedBrick)
			else:
				set_surface_override_material(0,SwingDoorOpen)
			if BackWallType == "BrownBrick":
				BackSide.set_surface_override_material(0,SwingDoorOpenBrownBrick)
			elif BackWallType == "OutdoorsBrick":
				BackSide.set_surface_override_material(0,SwingDoorOpenOutdoorBrick)
			elif BackWallType == "RedBrick":
				BackSide.set_surface_override_material(0,SwingDoorCloseRedBrick)
			else:
				BackSide.set_surface_override_material(0,SwingDoorOpen)
		elif DoorType == "HistoryDoor":
			if FrontWallType == "BrownBrick":
				set_surface_override_material(0,BrownBrickHistoryDoorOpen)
			elif FrontWallType == "RedWall":
				set_surface_override_material(0,RedWallHistoryDoorOpen)
			else:
				set_surface_override_material(0,HistoryDoorOpen)
			if BackWallType == "BrownBrick":
				BackSide.set_surface_override_material(0,BrownBrickHistoryDoorOpen)
			elif BackWallType == "RedWall":
				BackSide.set_surface_override_material(0,RedWallHistoryDoorOpen)
			else:
				BackSide.set_surface_override_material(0,HistoryDoorOpen)
		elif DoorType == "ScienceDoor":
			if FrontWallType == "BrownBrick":
				set_surface_override_material(0,BrownBrickScienceDoorOpen)
			elif FrontWallType == "BambooWall":
				set_surface_override_material(0,BambooScienceDoorOpen)
			else:
				set_surface_override_material(0,ScienceDoorOpen)
			if BackWallType == "BrownBrick":
				BackSide.set_surface_override_material(0,BrownBrickScienceDoorOpen)
			elif BackWallType == "BambooWall":
				BackSide.set_surface_override_material(0,BambooScienceDoorOpen)
			else:
				BackSide.set_surface_override_material(0,ScienceDoorOpen)
		elif DoorType == "ReadingDoor":
			if FrontWallType == "BrownBrick":
				set_surface_override_material(0,BrownBrickReadingDoorOpen)
			elif FrontWallType == "SunsetWall":
				set_surface_override_material(0,SunsetWallReadingDoorOpen)
			else:
				set_surface_override_material(0,ReadingDoorOpen)
			if BackWallType == "BrownBrick":
				BackSide.set_surface_override_material(0,BrownBrickReadingDoorOpen)
			elif BackWallType == "SunsetWall":
				BackSide.set_surface_override_material(0,SunsetWallReadingDoorOpen)
			else:
				BackSide.set_surface_override_material(0,ReadingDoorOpen)
		elif DoorType == "TwoDoorFence":
			set_surface_override_material(0,FenceDoorOpen)
			BackSide.set_surface_override_material(0,FenceDoorBackOpen)
		else:
			if FrontWallType == "BrownBrick":
				set_surface_override_material(0,BrownBrickMathDoorOpen)
			elif FrontWallType == "WoodWall":
				set_surface_override_material(0,WoodWallMathDoorOpen)
			else:
				set_surface_override_material(0,MathDoorOpen)
			if BackWallType == "BrownBrick":
				BackSide.set_surface_override_material(0,BrownBrickMathDoorOpen)
			elif BackWallType == "WoodWall":
				BackSide.set_surface_override_material(0,WoodWallMathDoorOpen)
			else:
				BackSide.set_surface_override_material(0,MathDoorOpen)
		await get_tree().create_timer(2).timeout
		DoorClose.play()
		if DoorType == "SwingDoor":
			if FrontWallType == "BrownBrick":
				set_surface_override_material(0,SwingDoorCloseBrownBrick)
			elif FrontWallType == "OutdoorsBrick":
				set_surface_override_material(0,SwingDoorCloseOutdoorBrick)
			elif FrontWallType == "RedBrick":
				set_surface_override_material(0,SwingDoorCloseRedBrick)
			else:
				set_surface_override_material(0,SwingDoorClose)
			if BackWallType == "BrownBrick":
				BackSide.set_surface_override_material(0,SwingDoorCloseBrownBrick)
			elif BackWallType == "OutdoorsBrick":
				BackSide.set_surface_override_material(0,SwingDoorCloseOutdoorBrick)
			elif BackWallType == "RedBrick":
				BackSide.set_surface_override_material(0,SwingDoorCloseRedBrick)
			else:
				BackSide.set_surface_override_material(0,SwingDoorClose)
		elif DoorType == "HistoryDoor":
			if FrontWallType == "BrownBrick":
				set_surface_override_material(0,BrownBrickHistoryDoorClose)
			elif FrontWallType == "RedWall":
				set_surface_override_material(0,RedWallHistoryDoorClose)
			else:
				set_surface_override_material(0,HistoryDoorClose)
			if BackWallType == "BrownBrick":
				BackSide.set_surface_override_material(0,BrownBrickHistoryDoorClose)
			elif BackWallType == "RedWall":
				BackSide.set_surface_override_material(0,RedWallHistoryDoorClose)
			else:
				BackSide.set_surface_override_material(0,HistoryDoorClose)
		elif DoorType == "ScienceDoor":
			if FrontWallType == "BrownBrick":
				set_surface_override_material(0,BrownBrickScienceDoorClose)
			elif FrontWallType == "BambooWall":
				set_surface_override_material(0,BambooScienceDoorClose)
			else:
				set_surface_override_material(0,ScienceDoorClose)
			if BackWallType == "BrownBrick":
				BackSide.set_surface_override_material(0,BrownBrickScienceDoorClose)
			elif BackWallType == "BambooWall":
				BackSide.set_surface_override_material(0,BambooScienceDoorClose)
			else:
				BackSide.set_surface_override_material(0,ScienceDoorClose)
		elif DoorType == "ReadingDoor":
			if FrontWallType == "BrownBrick":
				set_surface_override_material(0,BrownBrickReadingDoorClose)
			elif FrontWallType == "SunsetWall":
				set_surface_override_material(0,SunsetWallReadingDoorClose)
			else:
				set_surface_override_material(0,ReadingDoorClose)
			if BackWallType == "BrownBrick":
				BackSide.set_surface_override_material(0,BrownBrickReadingDoorClose)
			elif BackWallType == "SunsetWall":
				BackSide.set_surface_override_material(0,SunsetWallReadingDoorClose)
			else:
				BackSide.set_surface_override_material(0,ReadingDoorClose)
		elif DoorType == "TwoDoorFence":
			set_surface_override_material(0,FenceDoorClose)
			BackSide.set_surface_override_material(0,FenceDoorBackClose)
		else:
			if FrontWallType == "BrownBrick":
				set_surface_override_material(0,BrownBrickMathDoorClose)
			elif FrontWallType == "WoodWall":
				set_surface_override_material(0,WoodWallMathDoorClose)
			else:
				set_surface_override_material(0,MathDoorClose)
			if BackWallType == "BrownBrick":
				BackSide.set_surface_override_material(0,BrownBrickMathDoorClose)
			elif BackWallType == "WoodWall":
				BackSide.set_surface_override_material(0,WoodWallMathDoorClose)
			else:
				BackSide.set_surface_override_material(0,MathDoorClose)
		IsDoorOpened = false
