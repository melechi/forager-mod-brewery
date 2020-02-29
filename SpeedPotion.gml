#define InitSpeedPotion
	
	// CONSTANTS
	globalvar	SPEED_POTION_SPEED,
				SPEED_POTION_ACCEL,
				SPEED_POTION_DURATION;
	
	// TRACKING
	globalvar	ItemSpeedPotion,
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

	ItemSpeedPotion = ItemCreate
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
		[
			ItemEnergyPotion, 2,
			Item.Thunderbolt, 1
		],
		ScriptWrap(StartSpeedPotionBuff),
		mTicks(2),
		false,
		undefined,
		undefined,
		undefined,
		undefined,
		[Skill.Thaumaturgy]
	);
	
	StructureAddItem(Structure.Cauldron, ItemSpeedPotion);
	
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
