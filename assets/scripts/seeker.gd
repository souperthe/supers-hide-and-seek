@icon("res://assets/images/icons/imp-laugh.svg")
class_name Seeker extends Resource


@export var seekerName:String = "unknown seeker"
@export var seekerQuote:String = "i don't know who i am!"
@export var seekerIcon:Texture2D = load("res://assets/images/seeker_icons/seeker.png")
@export var seekerModel:PackedScene = load("res://assets/models/characters/seeker/seeker.tscn")
@export var seekerSize:Vector3 = Vector3(1,1,1)

@export var useFirstPerson:bool = true

@export var stateName:String = "seeker"
