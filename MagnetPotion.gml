#define InitMagnetPotion()

	// CONSTANTS
	globalvar	MAGNET_POTION_DURATION;
	
	MAGNET_POTION_DURATION = 30;
		
	// TRACKING
	globalvar	ItemMagnetPotion,
				sprMagnetPotion,
				ID_MagnetPotion,
				magnetPotionBuffCountdown;
	
	magnetPotionBuffCountdown = 0;
	
	sprMagnetPotion = sprite_add("Resources/Sprites/MagnetPotion.png", 1, false, false, 9, 9);
	
	ItemMagnetPotion = ItemCreate
	(
		undefined,
		"Magnet Potion",
		"makes you very attractive!",
		sprMagnetPotion,
		ItemType.Consumable,
		ItemSubType.None,
		200,
		0,
		0,
		[
			Item.Steel, 5
			Item.Crystal, 10
			Item.NightShade, 5
			Item.BottledDeathMoth, 1
		],
		ScriptWrap(StartMagnetPotionBuff),
		60
	);
	
	StructureAddItem(Structure.Cauldron, ItemMagnetPotion);
	
#define StartMagnetPotionBuff()
	Trace("Start Magnet Potion Buff");
	
	_instMagnetPotion = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
	magnetPotionBuffCountdown = sTicks(MAGNET_POTION_DURATION);
	with(_instMagnetPotion)
	{
		ID_MagnetPotion = id;
		InstanceAssignMethod(ID_MagnetPotion, "step", ScriptWrap(MagnetPotionTick), true);
	}


#define EndMagnetPotionBuff()
	Trace("End Magnet Potion Buff");
	magnetPotionBuffCountdown = 0;
	instance_destroy(ID_MagnetPotion);

#define MagnetPotionTick()
	with (parResource)
	{
		if (point_distance(objPlayer.x, objPlayer.y, x, y) < 70)
		{
			move_towards_point(objPlayer.x, objPlayer.y, 2);
			yy = y;
		}
		else
		{
			speed = 0;
		}
	}
	
	if (--magnetPotionBuffCountdown <= 0)
	{
		EndMagnetPotionBuff();
	}
