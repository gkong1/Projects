extends HBoxContainer

var HourNow = 0
var MinutesNow = 0
var DateNow = 1
var SeasonCounter = 0
var Seasons = ["Spring","Summer","Fall","Winter"]
const GameSpeed = 5

func _process(delta):
	MinutesNow += GameSpeed * delta
	if ceil(MinutesNow) > 59:
		HourNow += 1
		MinutesNow = 0
	
	$MinuteLabel.text = str(ceil(MinutesNow)).pad_zeros(2)
	$HourLabel.text = str(HourNow).pad_zeros(2)
	
	if HourNow > 23:
		DateNow += 1
		HourNow = 0
	
	if DateNow < 31:
		$DateLabel.text = str(DateNow)
	else:
		if SeasonCounter < 4:
			SeasonCounter += 1
		elif SeasonCounter > 3:
			SeasonCounter = 1
		DateNow = 1
		$DateLabel.text = str(DateNow)
		
	var SeasonsNow = Seasons[SeasonCounter]
	$SeasonLabel.text = str(SeasonsNow)