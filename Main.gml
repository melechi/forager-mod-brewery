/*

TODO:

Rename mod to "Brewery".

Potion Ideas
=============
* Water walking
* All potion
* Teleportation
* Nova
* Rainbow Aura
* Philosopher's Potion (Turns EVERYTHING dropped to gold)
*/



#define Main

	InitCommon();
	InitSpeedPotion();
	InitFlashPotion();
	InitHealingPotion();
	InitEnergyPotion();
	InitSmeltingPotion();
	InitMagnetPotion();
	
	// New commands for debugging
	CommandCreate("getspeed", false, ScriptWrap(GetSpeed));
	CommandCreate("resetspeed", false, ScriptWrap(ResetSpeed));
	CommandCreate("potions", false, ScriptWrap(GivePotions));
	CommandCreate("speedpotion", false, ScriptWrap(GiveSpeedPotion));
	CommandCreate("flashpotion", false, ScriptWrap(GiveFlashPotion));
	CommandCreate("smeltingpotion", false, ScriptWrap(GiveSmeltingPotion));
	CommandCreate("magnetpotion", false, ScriptWrap(GiveMagnetPotion));
	CommandCreate("energypotion", false, ScriptWrap(GiveEnergyPotion));
	CommandCreate("dospeedpotion", false, ScriptWrap(StartSpeedPotionBuff));
	CommandCreate("doflashpotion", false, ScriptWrap(StartFlashPotionBuff));
	
	
#define UseHealingPotion()
	objPlayer.hp++;
	

#define GivePotions()
	GainItem(Item.HealingPotion, 1);
	GainItem(Item.Thunderbolt, 1);
	GainItem(Item.AnasDelight, 1);
	GainItem(Item.LiquidLuck, 1);
	GainItem(Item.DraughtOfWisdom, 1);
	GainItem(Item.Mandragora, 1);
	GainItem(Item.BloodFuryCocktail, 1);
	GainItem(Item.DragonPhiltre, 1);
	GainItem(ItemPotionOfSpeed, 1);
	GainItem(ItemFlashPotion, 1);
	GainItem(InitEnergyPotion, 1);

#define GiveSpeedPotion()
	GainItem(ItemPotionOfSpeed, 1);

#define GiveFlashPotion()
	GainItem(ItemFlashPotion, 1);
	
#define GiveEnergyPotion
	GainItem(ItemEnergyPotion, 1);

#define GiveSmeltingPotion()
	GainItem(ItemSmeltingPotion, 1);

#define GiveMagnetPotion()
	GainItem(ItemMagnetPotion, 1);
	