#define InitOverloadedPhial()
	globalvar ItemOverloadPhial;
	
	ItemOverloadPhial = ItemCreate
	(
		undefined,
		"Overloaded Phial",
		"drinking this seems like a very bad idea... why would you even brew this?!",
		sprite_add("Resources/Sprites/overload.png", 16, true, false, 8, 8),
		ItemType.Consumable,
		ItemSubType.Potion,
		0,
		0,
		0,
		[
			ItemEnterprisingFlask, 1,
			ItemBarbaricFlask, 1,
			Item.NuclearFuelCell, 1
		],
		ScriptWrap(UseOverloadedPhial),
		mTicks(2),
		false
	);
	
	StructureAddItem(Structure.Cauldron, ItemOverloadPhial);

	
#define UseOverloadedPhial
	PlaySound("sndDrinkPotion");
	DmgPlayer(10, true);
	ExplosionCreate(objPlayer.x, objPlayer.y, 0, false);
	UsePotion(Item.DraughtOfWisdom);
	UsePotion(Item.LiquidLuck);
	UsePotion(Item.Mandragora);
	UsePotion(Item.Thunderbolt);
	UsePotion(Item.GreedyMixture);
	UsePotion(Item.AnasDelight);
	UsePotion(Item.DragonPhiltre);
	UsePotion(Item.BloodFuryCocktail);
	
