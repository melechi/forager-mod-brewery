#define InitHealingPotion()
	ItemEdit(Item.HealingPotion, ItemData.Description, "liquid hearts.");
	ItemEdit(Item.HealingPotion, ItemData.Energy, 0);
	ItemEdit(Item.HealingPotion, ItemData.Blueprint,
			[
				Item.Flower, 5,
				Item.Wheat, 5,
				Item.BottledTorchbug, 1
			]);
