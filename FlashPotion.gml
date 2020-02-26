#define InitFlashPotion
	
	// CONSTANTS
	globalvar	FLASH_POTION_SPEED,
				FLASH_POTION_ACCEL;
	
	// TRACKING
	globalvar	ItemFlashPotion,
				ID_FlashPotion,
				flashPotionCountdown;
	
	FLASH_POTION_SPEED = 20;
	FLASH_POTION_ACCEL = 20;
	
	flashPotionCountdown = 0;
	
	ItemFlashPotion = ItemCreate
	(
		undefined,
		"Flash Potion",
		"Makes you move like the flash!",
		sprThunderbolt,
		ItemType.Consumable,
		ItemSubType.None,
		500,
		0,
		0,
		[
			Item.Thunderbolt, 5,
			Item.LegendaryGem, 1,
			Item.NuclearFuelCell, 1
		],
		ScriptWrap(StartFlashPotionBuff),
		60 * 2
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
	flashPotionCountdown = sTicks(5);
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
	flashPotionCountdown--;
	// Trace("Countdown: " + string(round(flashPotionCountdown / 60) ));
	if (flashPotionCountdown <= 0)
	{
		EndFlashPotionBuff();
	}
