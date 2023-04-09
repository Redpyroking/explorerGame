extends Resource

class_name Move
 
export var name = ""
export var alias = ""
export(String,MULTILINE) var description = ""
enum TYPE {PHYSICAL,RANGE,STATUS,MOVEMENT,EQUIPMENT}
export (TYPE) var moveType
enum TARGET {SELF,SINGLE,MULTIPLE,NONE}
export (TARGET) var moveTarget
export (int) var damage = 0
export (Array) var flags 
