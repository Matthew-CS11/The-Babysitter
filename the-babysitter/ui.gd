extends CanvasLayer

func set_demon_label(num: int):
	$Demons_left.text = "Demons Left: "+ str(num)

func set_wave_lebel(num: int):
	$Wave_timer.text = "Next Wave: "+str(num)+" Seconds"
