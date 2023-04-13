extends Resource

class_name Legend
 
export var name = ""
export var alias = ""
export var height = 0.0
export var weight = 0.0
export var hp = 1
export var base_melee_attack = 1
export var base_range_attack = 1
export var base_defense = 1
export var ability_name = ""
export var ability_func = ""
export (Texture) var sprite
export (String,MULTILINE) var ability_desc
export (Array,String) var flags
export (Array,Resource) var moves
export (Array,int) var movelevel #correspond to moves
