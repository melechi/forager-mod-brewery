#define InitSpeedPotion
	
	// CONSTANTS
	globalvar	SPEED_POTION_SPEED,
				SPEED_POTION_ACCEL;
	
	// TRACKING
	globalvar	ItemPotionOfSpeed,
				ID_SpeedPotion,
				potionOfSpeedCountdown;
	
	SPEED_POTION_SPEED = 5;
	SPEED_POTION_ACCEL = 10;
	
	potionOfSpeedCountdown = 0;

	ItemPotionOfSpeed = ItemCreate
	(
		undefined,
		"Speed Potion",
		"Makes you move fast.",
		sprThunderbolt,
		ItemType.Consumable,
		ItemSubType.None,
		200,
		0,
		0,
		[Item.Thunderbolt, 5],
		ScriptWrap(StartSpeedPotionBuff),
		60 * 2
	);
	
	StructureAddItem(Structure.Cauldron, ItemPotionOfSpeed);
	
#define StartSpeedPotionBuff()
	ResetSpeedBuffs();
	Trace("START Speed Potion Buff");
	CaptureSpeed();
	SetSpeedAccel
	(
		SPEED_POTION_SPEED,
		SPEED_POTION_ACCEL
	);
	_instPotionOfSpeed = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
	potionOfSpeedCountdown = sTicks(5);
	with(_instPotionOfSpeed)
	{
		ID_SpeedPotion = id;
		InstanceAssignMethod(ID_SpeedPotion, "step", ScriptWrap(SpeedPotionTick), true);
	}

#define EndSpeedPotionBuff()
	Trace("End Speed Potion Buff");
	potionOfSpeedCountdown = 0;
	instance_destroy(ID_SpeedPotion);
	RestoreSpeed();


#define SpeedPotionTick()
	potionOfSpeedCountdown--;
	// objZap
	// ZapSpawn(objPlayer);
	// Trace("Countdown: " + string(round(potionOfSpeedCountdown / 60) ));
	if (potionOfSpeedCountdown <= 0)
	{
		EndSpeedPotionBuff();
	}
