extends Resource

class_name Enemy
 
export var name = ""
export var height = 0.0
export var weight = 0.0
export var base_hitpoint = 1
export var base_melee_attack = 1
export var base_range_attack = 1
export var base_defense = 1
export (Array,String) var Flags
export (Texture) var sprite

func set_stat(level):
	self.attack += (level * 2) + 5 
	self.defense += (level * 2) + 5 
	self.stamina += (level * 2) + 5
	self.hitpoint += (level * 5) + 25 

