#define InitSmeltingPotion()

	// CONSTANTS
	globalvar SMELT_PER_TICK;
	SMELT_PER_TICK = 1;
	
	// TRACKING
	globalvar	ItemSmeltingPotion,
				ID_SmeltingPotion,
				smeltingPotionBuffCountdown;
	
	smeltingPotionBuffCountdown = 0;
	
	globalvar lastTick;
	lastTick = 0;
	
	ItemSmeltingPotion = ItemCreate
	(
		undefined,
		"Smelting Potion",
		"auto smelts ore in your inventory.",
		sprThunderbolt,
		ItemType.Consumable,
		ItemSubType.None,
		200,
		0,
		0,
		[
			Item.IronIngot, 5
			Item.GoldIngot, 5
		],
		ScriptWrap(StartSmeltingPotionBuff),
		30
	);
	
	StructureAddItem(Structure.Cauldron, ItemSmeltingPotion);
	
#define StartSmeltingPotionBuff()
	Trace("Start Smelting Potion Buff");
	
	_instSmeltingPotion = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
	smeltingPotionBuffCountdown = sTicks(10);
	with(_instSmeltingPotion)
	{
		ID_SmeltingPotion = id;
		InstanceAssignMethod(ID_SmeltingPotion, "step", ScriptWrap(SmeltingPotionTick), true);
	}


#define EndSmeltingPotionBuff()
	Trace("End Smelting Potion Buff");
	smeltingPotionBuffCountdown = 0;
	instance_destroy(ID_SmeltingPotion);

#define SmeltingPotionTick()
	var thisTick = round(smeltingPotionBuffCountdown / 60);
	if (thisTick != lastTick)
	{
		lastTick = thisTick;
		if (ItemCount(Item.IronOre, false))
		{
			Trace("Found Iron Ore");
			DoSmelt("iron", SMELT_PER_TICK);
		}
		if (ItemCount(Item.GoldOre, false))
		{
			Trace("Found Gold Ore");
			DoSmelt("gold", SMELT_PER_TICK);
		}
	}
	
	smeltingPotionBuffCountdown--;
	if (smeltingPotionBuffCountdown <= 0)
	{
		EndSmeltingPotionBuff();
	}

#define DoSmelt(type, quantity)
	if (type == "iron")
	{
		RemoveItem(Item.IronOre, quantity);
		GainItem(Item.IronIngot,quantity);
	}
	else if (type == "gold")
	{
		RemoveItem(Item.GoldOre, quantity);
		GainItem(Item.GoldIngot,quantity);
	}
	instance_create_depth(objPlayer.x, objPlayer.y, 0, objSmoke);
