#define InitFlashPotion
	
	// CONSTANTS
	globalvar	FLASH_POTION_SPEED,
				FLASH_POTION_ACCEL,
				FLASH_POTION_DURATION;
	
	// TRACKING
	globalvar	ItemFlashPotion,
				sprFlashPotion,
				ID_FlashPotion,
				flashPotionCountdown,
				lastFlashPotionTick,
				lastPlayerX,
				lastPlayerY;
	
	FLASH_POTION_SPEED = 20;
	FLASH_POTION_ACCEL = 10;
	FLASH_POTION_DURATION = 10;
	
	flashPotionCountdown = 0;
	lastFlashPotionTick = 999;
	
	lastPlayerX = 0;
	lastPlayerY = 0;
	
	sprFlashPotion = sprite_add("Resources/Sprites/FlashPotion.png", 1, false, false, 9, 9);
	
	ItemFlashPotion = ItemCreate
	(
		undefined,
		"Flash Potion",
		"Makes you move like the flash!",
		sprFlashPotion,
		ItemType.Consumable,
		ItemSubType.None,
		500,
		0,
		0,
		[
			Item.Thunderbolt, 1,
			ItemSpeedPotion, 1
			Item.LegendaryGem, 1,
			Item.NuclearFuelCell, 1
		],
		ScriptWrap(StartFlashPotionBuff),
		mTicks(2),
		false
	);
	
	StructureAddItem(Structure.Cauldron, ItemFlashPotion);

#define StartFlashPotionBuff()
	ResetSpeedBuffs();
	Trace("START Flash Potion Buff");
	CaptureSpeed();
	SetSpeedAccel
	(
		FLASH_POTION_SPEED,
		FLASH_POTION_ACCEL
	);
	_instFlashPotion = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
	flashPotionCountdown = sTicks(FLASH_POTION_DURATION);
	with(_instFlashPotion)
	{
		ID_FlashPotion = id;
		InstanceAssignMethod(ID_FlashPotion, "step", ScriptWrap(FlashPotionTick), true);
	}

#define EndFlashPotionBuff()
	Trace("End Flash Potion Buff");
	flashPotionCountdown = 0;
	instance_destroy(ID_FlashPotion);
	RestoreSpeed();

#define FlashPotionTick()
	if (--flashPotionCountdown > 0)
	{
		//Only make smoke effect if the player moves.
		if (lastPlayerX != objPlayer.x
		|| lastPlayerY != objPlayer.y)
		{
			lastPlayerX = objPlayer.x;
			lastPlayerY = objPlayer.y;
			
			instance_create_depth(objPlayer.x, objPlayer.y, -1, objSmoke);
		}
		instance_create_depth(objPlayer.x, objPlayer.y, -1, objZap);
	}
	else
	{
		EndFlashPotionBuff();
	}