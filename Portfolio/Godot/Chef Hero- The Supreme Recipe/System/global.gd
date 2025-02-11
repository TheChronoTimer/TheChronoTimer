extends Node

var RTC: float = 0.0
var NPCsearch: int = 4
var debug: bool = 0

var DefaultFrameSpeed: float = 0.0
var DefaultSpeed: float = 0.0

var Hotkey: int = 0

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

#region PETList
var PETlist = {
"Dog":			0,
"Cat":			1
}
#endregion

var collision_array: Array = []
var player_coords: Vector2i

var inventory_ready: bool = false
var inventory_dict = {
	# Coordenada: [ID, Qtde]
	0:			[1, 999],
	1:			[4, 5],
	2:			[-1, 0],
	3:			[-1, -1],
	4:			[-1, 2],
	5:			[0, -1],
	6:			[0, 0],
	7:			[2, -1],
	8:			[-1, 0],
	9:			[-1, 0],
	10:			[-1, 0],
	11:			[-1, 0],
	12:			[-1, 0],
	13:			[4, 0],
	14:			[5, 0],
	15:			[6, 0],
	16:			[7, 0],
	17:			[8, 0],
	18:			[9, 0],
	19:			[10, 0],
	20:			[11, 0],
	21:			[12, 0],
	22:			[13, 0],
	23:			[14, 0],
	24:			[15, 0],
	25:			[16, 0],
	26:			[17, 0],
	27:			[18, 0],
	28:			[19, 0],
	29:			[20, 0],
	30:			[21, 0],
	31:			[22, 0],
	32:			[23, 0],
	33:			[24, 0],
	34:			[25, 0],
	35:			[26, 0]
}
