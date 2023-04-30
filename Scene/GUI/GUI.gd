extends Control

var coin_amount = 0

func update_coin():
	coin_amount += 1
	$coin_amount.text = str(coin_amount)
