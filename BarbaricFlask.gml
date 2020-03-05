#define InitBarbaricFlask()
	globalvar ItemBarbaricFlask;
	
	ItemBarbaricFlask = ItemCreate
	(
		undefined,
		"Barbaric Flask",
		"drinking this might make me more powerful.",
		sprite_add("Resources/Sprites/barbaric.png", 16, true, false, 8, 8),
		ItemType.Consumable,
		ItemSubType.Potion,
		0,
		0,
		0,
		[
			//global.Onyx, 2,
			Item.Mandragora, 1,
			Item.GreedyMixture, 1,
			Item.DragonPhiltre, 1,
			Item.BloodFuryCocktail, 1,
			Item.KrakenEye, 4
		],
		ScriptWrap(UseBarbaricFlask),
		mTicks(5),
		false
	);
	
	StructureAddItem(Structure.Cauldron, ItemBarbaricFlask);
	
#define UseBarbaricFlask
	Trace("I would like to rage!");
	PlaySound("sndDrinkPotion");
	DmgPlayer(6, true);
	ExplosionCreate(objPlayer.x, objPlayer.y, 0, false);
	UsePotion(Item.Mandragora);
	UsePotion(Item.GreedyMixture);
	UsePotion(Item.DragonPhiltre);
	UsePotion(Item.BloodFuryCocktail);