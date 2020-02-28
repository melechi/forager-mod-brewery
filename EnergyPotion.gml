#define InitEnergyPotion
	globalvar	ItemEnergyPotion,
				sprEnergyPotion;
	
	sprEnergyPotion = sprite_add("Resources/Sprites/EnergyPotion.png", 1, false, false, 9, 9);
	
	ItemEnergyPotion = ItemCreate
	(
		undefined,
		"Energy Potion",
		"Like coffee, but green.",
		sprEnergyPotion,
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
		mTicks(1),
		false,
		undefined,
		undefined,
		undefined,
		undefined,
		[Skill.Thaumaturgy]
	);
	
	StructureAddItem(Structure.Cauldron, ItemEnergyPotion);

#define UseEnergyPotion
	objPlayer.energy = objPlayer.energy + 25;

