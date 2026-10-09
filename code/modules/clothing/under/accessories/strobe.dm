/obj/item/clothing/accessory/strobe
	name = "strobe light"
	desc = "A clip-on strobe light that is attached to the shoulder, colloquially called a 'guardian angel' for making the person highly visible."
	icon_state = "strobe"
	base_icon_state = "strobe"
	actions_types = list(/datum/action/item_action/toggle_strobe_light)
	var/active = FALSE

/obj/item/clothing/accessory/strobe/attack_self(mob/user)
	if(!can_use(user))
		return
	active = !active
	set_light(l_outer_range = 2, l_power = 1, l_color = LIGHT_COLOR_BLUE, l_on = active)
	update_appearance()
	update_item_action_buttons()
	to_chat(user, span_notice("You turn [active ? "on" : "off"] the lights on the [src]."))

	var/obj/item/clothing/under/attached_to = loc
	if(istype(attached_to))
		attached_to.update_accessory_overlay()

/obj/item/clothing/accessory/strobe/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][active ? "-on" : ""]"
