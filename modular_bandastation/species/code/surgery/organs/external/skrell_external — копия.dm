/obj/item/organ/head_tentacle
	name = "skrell head tentacle"
	desc = "Is it really tentacle?"

	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'
	icon_state = "head_tentacle"

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_HEAD_TENTACLE

	dna_block = /datum/dna_block/feature/accessory/skrell_head_tentacle
	restyle_flags = EXTERNAL_RESTYLE_FLESH

	bodypart_overlay = /datum/bodypart_overlay/mutant/head_tentacle

	organ_flags = parent_type::organ_flags | ORGAN_EXTERNAL

	actions_types = list(/datum/action/item_action/organ_action/headpocket)

/obj/item/organ/head_tentacle/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/headpocket)

/obj/item/organ/head_tentacle/ui_action_click(mob/user, actiontype)
	. = ..()
	atom_storage.open_storage(user)

/obj/item/organ/head_tentacle/on_bodypart_remove(obj/item/bodypart/limb, movement_flags)
	. = ..()
	atom_storage.remove_all()

// MARK: Action

/datum/action/item_action/organ_action/headpocket
	name = "Полость в щупальцах"
	button_icon = 'modular_bandastation/species/icons/hud/actions.dmi'
	button_icon_state = "skrell_headpocket"

// MARK: Storage

/datum/storage/headpocket
	max_slots = 1
	max_specific_storage = WEIGHT_CLASS_SMALL
	max_total_storage = WEIGHT_CLASS_SMALL
	silent = TRUE

// MARK: Bodypart overlay

/datum/bodypart_overlay/mutant/head_tentacle
	layers = EXTERNAL_FRONT|EXTERNAL_ADJACENT
	feature_key = FEATURE_SKRELL_HEAD_TENTACLE
	color_source = ORGAN_COLOR_INHERIT

/datum/bodypart_overlay/mutant/head_tentacle/get_global_feature_list()
	return SSaccessories.feature_list[FEATURE_SKRELL_HEAD_TENTACLE]

/datum/bodypart_overlay/mutant/head_tentacle/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner, mob/living/carbon/owner, is_husked = FALSE)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/human/human = bodypart_owner.owner
	if(!istype(human))
		return TRUE
	if((human.head?.flags_inv & HIDEHAIR) || (human.wear_mask?.flags_inv & HIDEHAIR))
		return FALSE
	return TRUE

/obj/item/organ/cloth_wrap
	name = "skrell cloth wrap"
	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'
	icon_state = "head_tentacle"

	bodypart_overlay = /datum/bodypart_overlay/mutant/cloth_wrap
	dna_block = /datum/dna_block/feature/accessory/skrell_cloth_wrap
	var/datum/bodypart_overlay/mutant/cloth_wrap/cloth_wrap_overlay
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_HEAD_CLOTH_WRAP

	restyle_flags = EXTERNAL_RESTYLE_FLESH

	organ_flags = parent_type::organ_flags | ORGAN_EXTERNAL

/datum/bodypart_overlay/mutant/cloth_wrap
	layers = EXTERNAL_FRONT|EXTERNAL_ADJACENT
	feature_key = FEATURE_SKRELL_CLOTH_WRAP
	color_source = ORGAN_COLOR_INHERIT
	var/cloth_wrap_key = NONE
	var/skrell_cloth_wrap_color = "#FFFFFF"

/datum/bodypart_overlay/mutant/cloth_wrap/get_global_feature_list()
	return SSaccessories.feature_list[FEATURE_SKRELL_CLOTH_WRAP]

/datum/bodypart_overlay/mutant/cloth_wrap/override_color(rgb_value)
	return skrell_cloth_wrap_color

/obj/item/organ/cloth_wrap/on_bodypart_insert(obj/item/bodypart/bodypart)
	var/data = ..()
	insert_cloth_wrap(bodypart)
	return data

/obj/item/organ/cloth_wrap/on_bodypart_remove(obj/item/bodypart/bodypart)
	remove_cloth_wrap(bodypart)
	return ..()

/obj/item/organ/cloth_wrap/proc/insert_cloth_wrap(obj/item/bodypart/bodypart)
	if(cloth_wrap_overlay)
		return

	var/datum/sprite_accessory/skrell_cloth_wrap/skrell_cloth_wrap_datum = bodypart_overlay.sprite_datum

	if(!istype(skrell_cloth_wrap_datum))
		return

	var/cloth_wrap_key = skrell_cloth_wrap_datum.icon_state
	if(!cloth_wrap_key)
		return

	var/mob/living/carbon/human/owner = bodypart.owner
	var/feature_name = bodypart.owner.dna.features[FEATURE_SKRELL_CLOTH_WRAP]
	if (feature_name && istype(owner, /mob/living/carbon/human))
		cloth_wrap_overlay = new
		cloth_wrap_overlay.cloth_wrap_key = cloth_wrap_key
		cloth_wrap_overlay.color_source = ORGAN_COLOR_OVERRIDE
		cloth_wrap_overlay.skrell_cloth_wrap_color = owner.dna.features[FEATURE_SKRELL_CLOTH_WRAP_COLOR]
		cloth_wrap_overlay.set_appearance_from_name(feature_name)
		bodypart.add_bodypart_overlay(cloth_wrap_overlay)
		to_chat(world, "FEATURE_SKRELL_CLOTH_WRAP_COLOR = [FEATURE_SKRELL_CLOTH_WRAP_COLOR]\n cloth_wrap_overlay = [cloth_wrap_overlay]\n feature_name = [feature_name]\n cloth_wrap_key = [cloth_wrap_key]\n bodypart_overlay = [bodypart_overlay]\n bodypart = [bodypart]\n skrell_cloth_wrap_datum = [skrell_cloth_wrap_datum]")

/obj/item/organ/cloth_wrap/proc/remove_cloth_wrap(obj/item/bodypart/bodypart)
	if(!cloth_wrap_overlay)
		return
	bodypart.remove_bodypart_overlay(cloth_wrap_overlay)
	QDEL_NULL(cloth_wrap_overlay)

/datum/bodypart_overlay/mutant/cloth_wrap/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner, mob/living/carbon/owner, is_husked = FALSE)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/human/human = bodypart_owner.owner
	if(!istype(human))
		return TRUE
	if((human.head?.flags_inv & HIDEHAIR) || (human.wear_mask?.flags_inv & HIDEHAIR))
		return FALSE
	return TRUE

/obj/item/organ/tentacle_ornament
	name = "skrell tentacle ornament"
	icon = 'icons/bandastation/mob/species/skrell/organs.dmi'
	icon_state = "head_tentacle"

	bodypart_overlay = /datum/bodypart_overlay/mutant/tentacle_ornament
	dna_block = /datum/dna_block/feature/accessory/skrell_tentacle_ornament
	var/datum/bodypart_overlay/mutant/tentacle_ornament/tentacle_ornament_overlay
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_HEAD_TENTACLE_ORNAMENT

	restyle_flags = EXTERNAL_RESTYLE_FLESH

	organ_flags = parent_type::organ_flags | ORGAN_EXTERNAL

/datum/bodypart_overlay/mutant/tentacle_ornament
	layers = EXTERNAL_FRONT|EXTERNAL_ADJACENT
	feature_key = FEATURE_SKRELL_HEAD_TENTACLE_ORNAMENT
	color_source = ORGAN_COLOR_INHERIT
	var/skrell_ornament_key = NONE

/datum/bodypart_overlay/mutant/tentacle_ornament/get_global_feature_list()
	return SSaccessories.feature_list[FEATURE_SKRELL_HEAD_TENTACLE_ORNAMENT]

/datum/bodypart_overlay/mutant/tentacle_ornament/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner, mob/living/carbon/owner, is_husked = FALSE)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/human/human = bodypart_owner.owner
	if(!istype(human))
		return TRUE
	if((human.head?.flags_inv & HIDEHAIR) || (human.wear_mask?.flags_inv & HIDEHAIR))
		return FALSE
	return TRUE
