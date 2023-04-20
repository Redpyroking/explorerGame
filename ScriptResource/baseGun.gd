extends Resource

class_name Weapon
 
export var name = ""
export var alias = ""
export(float) var shoot_range
export (Texture) var sprite
export (String,MULTILINE) var ability_desc
export (Array,String) var flags
enum TYPE{long_range,short_range,shotgun,laucher,rpg}
export (TYPE) var gun_type
export (Texture) var bullet
