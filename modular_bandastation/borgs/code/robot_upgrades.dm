// robot_upgrades.dm
// Contains various borg upgrades.

/obj/item/borg/upgrade/holoprojector
	name = "cyborg engineering omni-holoprojector upgrade"
	desc = "An omni-holoprojector device for the engineering cyborg."
	icon_state = "module_engineer"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering, /obj/item/robot_model/saboteur)
	model_flags = BORG_MODEL_ENGINEERING
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)

	items_to_add = list(/obj/item/holosign_creator/engicyborg)
