extends RefCounted

class_name Player

var level:int = 0
var isdemo:bool = true

func to_dict() -> Dictionary:
	return {
		"level": level
	}

static func from_dict(d: Dictionary) -> Player:
	var p := Player.new()
	p.level = int(d.get("level", 0))
	return p
