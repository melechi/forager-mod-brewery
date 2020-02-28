#define InitSpeedPotion
	
	// CONSTANTS
	globalvar	SPEED_POTION_SPEED,
				SPEED_POTION_ACCEL,
				SPEED_POTION_DURATION;
	
	// TRACKING
	globalvar	ItemPotionOfSpeed,
				sprSpeedPotion,
				ID_SpeedPotion,
				potionOfSpeedCountdown,
				lastSpeedPotionTick;
	
	SPEED_POTION_SPEED = 5;
	SPEED_POTION_ACCEL = 5;
	SPEED_POTION_DURATION = 30;
	
	potionOfSpeedCountdown = 0;
	lastSpeedPotionTick = 999;
	
	sprSpeedPotion = sprite_add("Resources/Sprites/SpeedPotion.png", 1, false, false, 9, 9);

	ItemPotionOfSpeed = ItemCreate
	(
		undefined,
		"Speed Potion",
		"Makes you move fast.",
		sprSpeedPotion,
		ItemType.Consumable,
		ItemSubType.None,
		200,
		0,
		0,
		[Item.Thunderbolt, 5],
		ScriptWrap(StartSpeedPotionBuff),
		SPEED_POTION_DURATION
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
	potionOfSpeedCountdown = sTicks(SPEED_POTION_DURATION);
	with(_instPotionOfSpeed)
	{
		ID_SpeedPotion = id;
		InstanceAssignMethod(ID_SpeedPotion, "step", ScriptWrap(SpeedPotionTick), true);
	}

#define EndSpeedPotionBuff()
	Trace("End Speed Potion Buff");
	potionOfSpeedCountdown = 0;
	lastSpeedPotionTick = 999;
	instance_destroy(ID_SpeedPotion);
	RestoreSpeed();


#define SpeedPotionTick()
	var thisTick = round(potionOfSpeedCountdown / 60);
	if (thisTick < lastSpeedPotionTick)
	{
		lastSpeedPotionTick = thisTick;
		instance_create_depth(objPlayer.x, objPlayer.y, -1, objZap);
	}
	
	if (--potionOfSpeedCountdown <= 0)
	{
		EndSpeedPotionBuff();
	}
