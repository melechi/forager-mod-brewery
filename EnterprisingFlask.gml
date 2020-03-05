#define InitEnterprisingFlask()
	globalvar ItemEnterprisingFlask;
	
	ItemEnterprisingFlask = ItemCreate
	(
		undefined,
		"Enterprising Flask",
		"drinking this might make me more resourceful.",
		sprite_add("Resources/Sprites/enterprising.png", 16, true, false, 8, 8),
		ItemType.Consumable,
		ItemSubType.Potion,
		0,
		0,
		0,
		[
			//Item.LegendaryGem, 2,
			Item.DraughtOfWisdom, 1,
			Item.LiquidLuck, 1,
			Item.Thunderbolt, 1,
			Item.AnasDelight, 1,
			Item.VoidRose, 4
		],
		ScriptWrap(UseEnterprisingFlask),
		mTicks(1),
		false
	);
	
	StructureAddItem(Structure.Cauldron, ItemEnterprisingFlask);
	
#define UseEnterprisingFlask
	Trace("To boldly go!");
	PlaySound("sndDrinkPotion");
	DmgPlayer(2, true);
	ExplosionCreate(objPlayer.x, objPlayer.y, 0, false);
	UsePotion(Item.DraughtOfWisdom);
	UsePotion(Item.LiquidLuck);
	UsePotion(Item.Thunderbolt);
	UsePotion(Item.AnasDelight);