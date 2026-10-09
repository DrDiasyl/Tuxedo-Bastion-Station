/obj/item/clothing/accessory/strobe
	name = "strobe light"
	desc = "A clip-on strobe light that is attached to the shoulder, colloquially called a 'guardian angel' and is used to identify the nearest rookie."
	icon_state = "strobe"
	base_icon_state = "strobe"
	light_system = OVERLAY_LIGHT
	light_outer_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_DARK_BLUE
	light_on = FALSE
	actions_types = list(/datum/action/item_action/toggle_strobe_light)
	var/active = FALSE

/obj/item/clothing/accessory/strobe/attack_self(mob/user)
	if(!can_use(user))
		return
	active = !active
	set_light_on(active)
	update_appearance()
	update_item_action_buttons()
	to_chat(user, span_notice("You turn [active ? "on" : "off"] the lights on the [src]."))

	var/obj/item/clothing/under/attached_to = loc
	if(istype(attached_to))
		attached_to.update_accessory_overlay()

/obj/item/clothing/accessory/strobe/successful_attach(obj/item/clothing/under/attached_to)
	. = ..()
	set_light_flags(light_flags | LIGHT_ATTACHED)

/obj/item/clothing/accessory/strobe/detach(obj/item/clothing/under/detach_from, popped = FALSE)
	set_light_flags(light_flags & ~LIGHT_ATTACHED)
	return ..()

/obj/item/clothing/accessory/strobe/update_overlays()
	. = ..()
	if(active)
		. += emissive_appearance(icon, "[base_icon_state]-on", src, alpha = src.alpha)

/obj/item/clothing/accessory/strobe/on_uniform_update(obj/item/source, list/overlays)
	. = ..()
	if(!active || !istype(source, /obj/item/clothing/under))
		return

	var/obj/item/clothing/under/attached_to = source
	if(attached_to.attached_accessories[1] != src || !attached_to.accessory_overlay)
		return
	if(length(attached_to.accessory_overlay.overlays))
		return

	attached_to.accessory_overlay.overlays += emissive_appearance(worn_icon, "[base_icon_state]-on", src, alpha = src.alpha)

/obj/item/clothing/accessory/strobe/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][active ? "-on" : ""]"
