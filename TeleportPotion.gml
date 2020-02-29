#define InitTeleportPotion
	// CONSTANTS
	globalvar	TELEPORT_POTION_DURATION,
				TELEPORT_POTION_DELAY;
	
	TELEPORT_POTION_DURATION = 10;
	TELEPORT_POTION_DELAY = .4;
		
	// TRACKING
	globalvar	ItemTeleportPotion,
				sprTeleportPotion,
				ID_TeleportPotion,
				teleportPotionBuffCountdown,
				lastTeleportPotionTick,
				canTeleport;
	
	teleportPotionBuffCountdown = 0;
	lastTeleportPotionTick = 999;
	canTeleport = true;
	
	// sprTeleportPotion = sprite_add("Resources/Sprites/TeleportPotion.png", 1, false, false, 9, 9);
	
	
	ItemTeleportPotion = ItemCreate
	(
		undefined,
		"Teleport Potion",
		"move with your mind",
		// sprTeleportPotion,
		sprThunderbolt,
		ItemType.Consumable,
		ItemSubType.None,
		200,
		0,
		0,
		[
			Item.Sand, 2
			Item.Crystal, 2
			Item.Berry, 5
			Item.Sugar, 2
		],
		ScriptWrap(StartTeleportPotionBuff),
		mTicks(1),
		// false
	);
	
	StructureAddItem(Structure.Cauldron, ItemTeleportPotion);
	
#define StartTeleportPotionBuff
	Trace("Start Teleport Potion Buff");
	
	_instTeleportPotion = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
	teleportPotionBuffCountdown = sTicks(TELEPORT_POTION_DURATION);
	with(_instTeleportPotion)
	{
		ID_TeleportPotion = id;
		InstanceAssignMethod(ID_TeleportPotion, "step", ScriptWrap(TeleportPotionTick), true);
	}
	
#define EndTeleportPotionBuff()
	Trace("End Teleport Potion Buff");
	teleportPotionBuffCountdown = 0;
	lastTeleportPotionTick = 999;
	instance_destroy(ID_TeleportPotion);

#define TeleportPotionTick()
	with(objPlayer)
	{
		var playerTarget = id;
		if (canTeleport && mouse_check_button(mb_right))
		{
			//Don't allow teleportation into water or solid objects.
			if (!WaterCollision(mouse_x, mouse_y)
			&& !position_meeting(mouse_x, mouse_y, parSolid))
			{
				x = mouse_x;
				y = mouse_y;
				CreateEffect(x,y,depth,sprFairyAuraGlow,10);
				canTeleport = false;
			}
		}
	}
	
	var thisTick = teleportPotionBuffCountdown / 60;
	if (thisTick < (lastTeleportPotionTick - TELEPORT_POTION_DELAY))
	{
		lastTeleportPotionTick = thisTick;
		canTeleport = true;
	}
	
	if (--teleportPotionBuffCountdown <= 0)
	{
		EndTeleportPotionBuff();
	}


