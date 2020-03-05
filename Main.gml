/*

TODO:

Potion Ideas
=============
* Water walking
* Nighg Vision
* All potion
* Nova
* Rainbow Aura
* Philosopher's Potion (Turns EVERYTHING dropped to gold)
*/

#define Main
	InitCommon();
	InitHealingPotion();
	InitEnergyPotion();
	InitSpeedPotion();
	InitFlashPotion();
	InitSmeltingPotion();
	InitMagnetPotion();
	InitTeleportPotion();
	// InitBlinkPotion();
	InitEnterprisingFlask();
	InitBarbaricFlask();
	InitOverloadedPhial();
	
	InitCommands();
	
#define OnRoomLoad()
	ItemEdit(ItemSpeedPotion, ItemData.Unlocked, HasSkill(Skill.Thaumaturgy));
	ItemEdit(ItemFlashPotion, ItemData.Unlocked, HasSkill(Skill.Thaumaturgy));
	ItemEdit(ItemSmeltingPotion, ItemData.Unlocked, HasSkill(Skill.Thaumaturgy));
	ItemEdit(ItemMagnetPotion, ItemData.Unlocked, HasSkill(Skill.Thaumaturgy));
	ItemEdit(ItemTeleportPotion, ItemData.Unlocked, HasSkill(Skill.Thaumaturgy));
	ItemEdit(ItemOverloadPhial, ItemData.Unlocked, HasSkill(Skill.Thaumaturgy));
	ItemEdit(ItemEnterprisingFlask, ItemData.Unlocked, HasSkill(Skill.Thaumaturgy));
	ItemEdit(ItemBarbaricFlask, ItemData.Unlocked, HasSkill(Skill.Thaumaturgy));

#define InitCommands()
	// New commands for debugging
	CommandCreate("getspeed", false, ScriptWrap(GetSpeed));
	CommandCreate("resetspeed", false, ScriptWrap(ResetSpeed));
	CommandCreate("potions", false, ScriptWrap(GivePotions));
	CommandCreate("speedpotion", false, ScriptWrap(GiveSpeedPotion));
	CommandCreate("flashpotion", false, ScriptWrap(GiveFlashPotion));
	CommandCreate("smeltingpotion", false, ScriptWrap(GiveSmeltingPotion));
	CommandCreate("magnetpotion", false, ScriptWrap(GiveMagnetPotion));
	CommandCreate("energypotion", false, ScriptWrap(GiveEnergyPotion));
	CommandCreate("teleportpotion", false, ScriptWrap(GiveTeleportPotion));
	CommandCreate("teleportpotion", false, ScriptWrap(GiveTeleportPotion));

#define GivePotions()
	GainItem(Item.HealingPotion, 1);
	GainItem(Item.Thunderbolt, 1);
	GainItem(Item.AnasDelight, 1);
	GainItem(Item.LiquidLuck, 1);
	GainItem(Item.DraughtOfWisdom, 1);
	GainItem(Item.Mandragora, 1);
	GainItem(Item.BloodFuryCocktail, 1);
	GainItem(Item.DragonPhiltre, 1);
	GainItem(ItemSpeedPotion, 1);
	GainItem(ItemFlashPotion, 1);
	GainItem(InitEnergyPotion, 1);
	GainItem(GiveSmeltingPotion, 1);
	GainItem(GiveMagnetPotion, 1);
	GainItem(ItemTeleportPotion, 1);
	GainItem(ItemOverloadPhial, 1);
	GainItem(ItemEnterprisingFlask, 1);
	GainItem(ItemBarbaricFlask, 1);
	

#define GiveSpeedPotion()
	GainItem(ItemSpeedPotion, 1);

#define GiveFlashPotion()
	GainItem(ItemFlashPotion, 1);
	
#define GiveEnergyPotion
	GainItem(ItemEnergyPotion, 1);

#define GiveSmeltingPotion()
	GainItem(ItemSmeltingPotion, 1);

#define GiveMagnetPotion()
	GainItem(ItemMagnetPotion, 1);

#define GiveTeleportPotion()
	GainItem(ItemTeleportPotion, 1);
	


