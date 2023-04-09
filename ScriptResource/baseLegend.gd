extends Resource

class_name Legend
 
export var name = ""
export var alias = ""
export var height = 0.0
export var weight = 0.0
export var base_hitpoint = 1
export var base_melee_attack = 1
export var base_range_attack = 1
export var base_defense = 1
export (Array,String) var flags
export (Array,Resource) var moves
export (Array,int) var movelevel #correspond to moves

func set_stat(level):
	self.base_melee_attack += (level * 2) + 5 
	self.base_defense += (level * 2) + 5 
	self.base_range_attack += (level * 2) + 5
	self.base_hitpoint += (level * 5) + 25 

