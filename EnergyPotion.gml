#define InitEnergyPotion
	globalvar ItemEnergyPotion;
	
	ItemEnergyPotion = ItemCreate
	(
		undefined,
		"Energy Potion",
		"Like coffee, but green.",
		sprMandragora,
		ItemType.Consumable,
		ItemSubType.None,
		36,
		0,
		25,
		[
			Item.Flower, 5,
			Item.Citrus, 10,
			Item.Wheat, 5,
			Item.BottledTorchbug, 1
		],
		ScriptWrap(UseEnergyPotion),
		0
	);

#define UseEnergyPotion
	objPlayer.energy = objPlayer.energy + 25;

