//Procedures in this file: Facial reconstruction surgery
//////////////////////////////////////////////////////////////////
//						FACE SURGERY							//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/face
	priority = 2
	can_infect = 0

/datum/surgery_step/face/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(!hasorgans(target))
		return 0
	var/datum/organ/external/affected = target.get_organ(target_zone)
	if(!affected)
		return 0
	return target_zone == "mouth"

/datum/surgery_step/generic/cut_face
	allowed_tools = list(
	/obj/item/weapon/scalpel = 100,		\
	/obj/item/weapon/kitchenknife = 75,	\
	/obj/item/weapon/shard = 50, 		\
	)

	min_duration = 60
	max_duration = 80

/datum/surgery_step/generic/cut_face/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	return ..() && target_zone == "mouth" && target.op_stage.face == 0

/datum/surgery_step/generic/cut_face/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/datum/organ/external/affected = target.get_organ(target_zone)
	is_same_target = affected
	user.visible_message("<span class='notice'>[user] starts to cut open [target]'s face and neck with \the [tool].</span>", \
	"<span class='notice'>You start to cut open [target]'s face and neck with \the [tool].</span>")
	..()

/datum/surgery_step/generic/cut_face/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/datum/organ/external/affected = target.get_organ(target_zone)
	if(is_same_target != affected) //We are not aiming at the same organ as when be begun, stop
		user << "<span class='warning'><b>You failed to start the surgery.</b> Aim at the same organ as the one that you started working on originally.</span>"
		return
	user.visible_message("<span class='notice'>[user] has cut open [target]'s face and neck with \the [tool].</span>" , \
	"<span class='notice'>You have cut open [target]'s face and neck with \the [tool].</span>",)
	target.op_stage.face = 1

/datum/surgery_step/generic/cut_face/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/datum/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='warning'>[user]'s hand slips, slicing [target]'s throat wth \the [tool]!</span>" , \
	"<span class='warning'>Your hand slips, slicing [target]'s throat wth \the [tool]!</span>" )
	affected.createwound(CUT, 60)
	target.losebreath += 10
	target.updatehealth()
	affected.update_wounds()

/datum/surgery_step/face/mend_vocal
	allowed_tools = list(
	/obj/item/weapon/hemostat = 100,         \
	/obj/item/stack/cable_coil = 75,         \
	/obj/item/device/assembly/mousetrap = 10 //I don't know. Don't ask me. But I'm leaving it because hilarity.
	)

	min_duration = 40
	max_duration = 60

/datum/surgery_step/face/mend_vocal/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	return ..() && target.op_stage.face == 1

/datum/surgery_step/face/mend_vocal/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/datum/organ/external/affected = target.get_organ(target_zone)
	is_same_target = affected
	user.visible_message("<span class='notice'>[user] starts mending [target]'s vocal cords with \the [tool].</span>", \
	"<span class='notice'>You start mending [target]'s vocal cords with \the [tool].</span>")
	..()

/datum/surgery_step/face/mend_vocal/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/datum/organ/external/affected = target.get_organ(target_zone)
	if(is_same_target != affected) //We are not aiming at the same organ as when be begun, stop
		user << "<span class='warning'><b>You failed to start the surgery.</b> Aim at the same organ as the one that you started working on originally.</span>"
		return
	user.visible_message("<span class='notice'>[user] mends [target]'s vocal cords with \the [tool].</span>", \
	"<span class='notice'>You mend [target]'s vocal cords with \the [tool].</span>")
	target.op_stage.face = 2

/datum/surgery_step/face/mend_vocal/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	user.visible_message("<span class='warning'>[user]'s hand slips, clamping [target]'s trachea shut for a moment with \the [tool]!</span>", \
	"<span class='warning'>Your hand slips, clamping [user]'s trachea shut for a moment with \the [tool]!</span>")
	target.losebreath += 10
	target.updatehealth()

/datum/surgery_step/face/fix_face
	allowed_tools = list(
	/obj/item/weapon/retractor = 100,          \
	/obj/item/weapon/crowbar = 55,             \
	/obj/item/weapon/kitchen/utensil/fork = 75
	)

	min_duration = 30
	max_duration = 40

/datum/surgery_step/face/fix_face/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	return ..() && target.op_stage.face == 2

/datum/surgery_step/face/fix_face/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/datum/organ/external/affected = target.get_organ(target_zone)
	is_same_target = affected
	user.visible_message("<span class='notice'>[user] starts pulling the skin on [target]'s face back in place with \the [tool].</span>", \
	"<span class='notice'>You start pulling the skin on [target]'s face back in place with \the [tool].</span>")
	..()

/datum/surgery_step/face/fix_face/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/datum/organ/external/affected = target.get_organ(target_zone)
	if(is_same_target != affected) //We are not aiming at the same organ as when be begun, stop
		user << "<span class='warning'><b>You failed to start the surgery.</b> Aim at the same organ as the one that you started working on originally.</span>"
		return
	user.visible_message("<span class='notice'>[user] pulls the skin on [target]'s face back in place with \the [tool].</span>",	\
	"<span class='notice'>You pull the skin on [target]'s face back in place with \the [tool].</span>")
	target.op_stage.face = 3

/datum/surgery_step/face/fix_face/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/datum/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='warning'>[user]'s hand slips, tearing skin on [target]'s face with \the [tool]!</span>", \
	"<span class='warning'>Your hand slips, tearing skin on [target]'s face with \the [tool]!</span>")
	target.apply_damage(10, BRUTE, affected, sharp = 1)
	target.updatehealth()

/datum/surgery_step/face/cauterize
	allowed_tools = list(
	/obj/item/weapon/cautery = 100,			\
	/obj/item/clothing/mask/cigarette = 75,	\
	/obj/item/weapon/flame/lighter = 50,    \
	/obj/item/weapon/weldingtool = 25
	)

	min_duration = 60
	max_duration = 80

/datum/surgery_step/face/cauterize/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	return ..() && target.op_stage.face > 0

/datum/surgery_step/face/cauterize/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/datum/organ/external/affected = target.get_organ(target_zone)
	is_same_target = affected
	user.visible_message("<span class='notice'>[user] is beginning to cauterize the incision on [target]'s face and neck with \the [tool].</span>" , \
	"<span class='notice'>You are beginning to cauterize the incision on [target]'s face and neck with \the [tool].</span>")
	..()

/datum/surgery_step/face/cauterize/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/datum/organ/external/affected = target.get_organ(target_zone)
	if(is_same_target != affected) //We are not aiming at the same organ as when be begun, stop
		user << "<span class='warning'><b>You failed to start the surgery.</b> Aim at the same organ as the one that you started working on originally.</span>"
		return
	user.visible_message("<span class='notice'>[user] cauterizes the incision on [target]'s face and neck with \the [tool].</span>", \
	"<span class='notice'>You cauterize the incision on [target]'s face and neck with \the [tool].</span>")
	affected.open = 0
	affected.status &= ~ORGAN_BLEEDING
	if (target.op_stage.face == 3)
		var/datum/organ/external/head/h = affected
		h.disfigured = 0
	target.op_stage.face = 0

/datum/surgery_step/face/cauterize/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/datum/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='warning'>[user]'s hand slips, leaving a small burn on [target]'s face with \the [tool]!</span>", \
	"<span class='warning'>Your hand slips, leaving a small burn on [target]'s face with \the [tool]!</span>")
	target.apply_damage(4, BURN, affected)
	target.updatehealth()
