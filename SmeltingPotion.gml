#define InitSmeltingPotion()

	// CONSTANTS
	globalvar	SMELT_PER_TICK,
				SMELT_POTION_DURATION;
	SMELT_PER_TICK = 1;
	SMELT_POTION_DURATION = 60;
	
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
			Item.IronIngot, 3
			Item.GoldIngot, 3
			Item.Cinderbloom, 5
			Item.BottledDeathMoth, 1
		],
		ScriptWrap(StartSmeltingPotionBuff),
		SMELT_POTION_DURATION
	);
	
	StructureAddItem(Structure.Cauldron, ItemSmeltingPotion);
	
#define StartSmeltingPotionBuff()
	Trace("Start Smelting Potion Buff");
	
	_instSmeltingPotion = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
	smeltingPotionBuffCountdown = sTicks(SMELT_POTION_DURATION);
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
		
		var list = ds_list_create();
		
		if (ItemCount(Item.IronOre, false))
		{
			ds_list_add(list,"iron");
		}
		if (ItemCount(Item.GoldOre, false))
		{
			ds_list_add(list,"gold");
		}
		if (ItemCount(Item.Sand, false))
		{
			ds_list_add(list,"sand");
		}
		
		var rand = irandom((ds_list_size(list) - 1));
		var item = ds_list_find_value(list,rand);
		
		DoSmelt(item, SMELT_PER_TICK);
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
		GainItem(Item.IronIngot, quantity);
	}
	else if (type == "gold")
	{
		RemoveItem(Item.GoldOre, quantity);
		GainItem(Item.GoldIngot, quantity);
	}
	else if (type == "sand")
	{
		RemoveItem(Item.Sand, quantity);
		GainItem(Item.Glass, quantity);
	}
	instance_create_depth(objPlayer.x, objPlayer.y, 0, objSmoke);
