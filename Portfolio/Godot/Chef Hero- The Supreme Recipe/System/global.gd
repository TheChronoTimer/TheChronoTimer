extends Node

var RTC: float = 0.0
var NPCsearch: int = 4

var DefaultFrameSpeed: float = 0.0
var DefaultSpeed: float = 0.0

#region NPCList
var NPClist = {
"Alex":			6,
"Elliot":		11,
"Harvey":		10,
"Sam":			9,
"Sebastian":	8,
"Shane":		7,
"Abigail":		0,
"Emily":		5,
"Haley":		4,
"Leah":			3,
"Maru":			2,
"Penny":		1,
"Caroline":		15,
"Clint":		31,
"Demetrius":	30,
"Dwarf":		27,
"Evelyn":		13,
"George":		29,
"Gus":			28,
"Jas":			24,
"Jodi":			19,
"Krobus":		26,
"Lewis":		20,
"Linus":		21,
"Marnie":		14,
"Pam":			18,
"Pierre":		17,
"Robin":		16,
"Sandy":		12,
"Vincent":		25,
"Willy":		22,
"Wizard":		23
}
#endregion

var collision_array = []
var collision_layer_count: int = 0