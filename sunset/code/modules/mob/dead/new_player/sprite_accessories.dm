/datum/sprite_accessory
	var/limbs_id //sunset new species limbs

// Vox Accessories
/datum/sprite_accessory/vox_quills
	icon = 'sunset/icons/mob/vox_accessories.dmi'
	color_src = HAIR
/datum/sprite_accessory/vox_quills/none
	name = "None"
	icon_state = "none"
/datum/sprite_accessory/vox_quills/crestedquills
	name = "Crested Quills"
	icon_state = "crestedquills"
/datum/sprite_accessory/vox_quills/emperorquills
	name = "Emperor Quills"
	icon_state = "emperorquills"
/datum/sprite_accessory/vox_quills/keelquills
	name = "Keel Quills"
	icon_state = "keelquills"
/datum/sprite_accessory/vox_quills/keetquills
	name = "Keet Quills"
	icon_state = "keetquills"
/datum/sprite_accessory/vox_quills/shortquills
	name = "Short quills"
	icon_state = "shortquills"
/datum/sprite_accessory/vox_quills/tielquills
	name = "Tiel Quills"
	icon_state = "tielquills"
/datum/sprite_accessory/vox_quills/kingly
	name = "Kingly Quills"
	icon_state = "kingly"
/datum/sprite_accessory/vox_quills/afro
	name = "Afro Quills"
	icon_state = "afro"
/datum/sprite_accessory/vox_quills/yasu
	name = "Yasu Quills"
	icon_state = "yasu"
/datum/sprite_accessory/vox_quills/razor
	name = "Razor Quills"
	icon_state = "razor"
/datum/sprite_accessory/vox_quills/clipped
	name = "Clipped Quills"
	icon_state = "clipped"
/datum/sprite_accessory/vox_quills/mowhawk
	name = "Mohawk Quills"
	icon_state = "mohawk"
/datum/sprite_accessory/vox_quills/horns
	name = "Horns"
	icon_state = "horns"
/datum/sprite_accessory/vox_quills/nights
	name = "Nights"
	icon_state = "nights"
/datum/sprite_accessory/vox_facial_quills
	icon = 'sunset/icons/mob/vox_accessories.dmi'
	color_src = FACEHAIR
/datum/sprite_accessory/vox_facial_quills/none
	name = "None"
	icon_state = "none"
/datum/sprite_accessory/vox_facial_quills/colonel
	name = "Colonel Beard"
	icon_state = "colonel"
/datum/sprite_accessory/vox_facial_quills/fu
	name = "Fu Beard"
	icon_state = "fu"
/datum/sprite_accessory/vox_facial_quills/neck
	name = "Neck Quills"
	icon_state = "neck"
/datum/sprite_accessory/vox_facial_quills/beard
	name = "Beard"
	icon_state = "beard"
/datum/sprite_accessory/vox_bodies
	icon_state = "yaya" // In order to pull the body correctly, we need AN icon_state(see line 36-39). PROBABLY NEED TO REFACTOR THIS. SKREK.
	var/eye_type = "two_eyes"
/datum/sprite_accessory/vox_bodies/green
	name = "Green"
	limbs_id = "grnvox"
/datum/sprite_accessory/vox_bodies/darkgreen
	name = "Dark Green"
	limbs_id = "dgrvox"
/datum/sprite_accessory/vox_bodies/brown
	name = "Brown"
	limbs_id = "brnvox"
/datum/sprite_accessory/vox_bodies/grey
	name = "Grey"
	limbs_id = "gryvox"
/datum/sprite_accessory/vox_bodies/emerald
	name = "Emerald"
	limbs_id = "emdvox"
/datum/sprite_accessory/vox_bodies/azure
	name = "Azure"
	limbs_id = "azevox"
/datum/sprite_accessory/vox_bodies/auroras
	name = "Auroras"
	limbs_id = "aurvox"
	eye_type = "three_eyes"
/datum/sprite_accessory/vox_eyes
	icon = 'sunset/icons/mob/vox_accessories.dmi'
	color_src = EYECOLOR
/datum/sprite_accessory/vox_eyes/two_eyes
	name = "two_eyes"
	icon_state = "two_eyes"
/datum/sprite_accessory/vox_eyes/three_eyes
	name = "three_eyes"
	icon_state = "three_eyes"
/datum/sprite_accessory/vox_tails
	icon = 'sunset/icons/mob/vox_accessories.dmi'
	color_src = 0
/datum/sprite_accessory/vox_tails/grnvox
	name = "grnvox"
	icon_state = "grnvox"
/datum/sprite_accessory/vox_tails/dgrvox
	name = "dgrvox"
	icon_state = "dgrvox"
/datum/sprite_accessory/vox_tails/brnvox
	name = "brnvox"
	icon_state = "brnvox"
/datum/sprite_accessory/vox_tails/gryvox
	name = "gryvox"
	icon_state = "gryvox"
/datum/sprite_accessory/vox_tails/emdvox
	name = "emdvox"
	icon_state = "emdvox"
/datum/sprite_accessory/vox_tails/azevox
	name = "azevox"
	icon_state = "azevox"
/datum/sprite_accessory/vox_tails/aurvox
	name = "aurvox"
	icon_state = "aurvox"
/datum/sprite_accessory/vox_tails/voxhusk
	name = "voxhusk"
	icon_state = "voxhusk"
/datum/sprite_accessory/vox_body_markings
	icon = 'sunset/icons/mob/vox_accessories.dmi'
/datum/sprite_accessory/vox_body_markings/none
	name = "None"
	icon_state = "none"
/datum/sprite_accessory/vox_body_markings/heart
	name = "Heart"
	icon_state = "heart"
/datum/sprite_accessory/vox_body_markings/hive
	name = "Hive"
	icon_state = "hive"
/datum/sprite_accessory/vox_body_markings/nightling
	name = "Nightling"
	icon_state = "nightling"
/datum/sprite_accessory/vox_body_markings/tiger
	name = "Tiger"
	icon_state = "tiger"
/datum/sprite_accessory/vox_tail_markings
	icon = 'sunset/icons/mob/vox_accessories.dmi'
/datum/sprite_accessory/vox_tail_markings/none
	name = "None"
	icon_state = "none"
/datum/sprite_accessory/vox_tail_markings/bands
	name = "Bands"
	icon_state = "bands"
/datum/sprite_accessory/vox_tail_markings/fade
	name = "Fade"
	icon_state = "fade"
/datum/sprite_accessory/vox_tail_markings/stripe
	name = "Stripe"
	icon_state = "stripe"
// IPC accessories.
/datum/sprite_accessory/ipc_screens
	icon = 'sunset/icons/mob/ipc_accessories.dmi'
	color_src = EYECOLOR
/datum/sprite_accessory/ipc_screens/blue
	name = "Blue"
	icon_state = "blue"
	color_src = 0
/datum/sprite_accessory/ipc_screens/bsod
	name = "BSOD"
	icon_state = "bsod"
	color_src = 0
/datum/sprite_accessory/ipc_screens/breakout
	name = "Breakout"
	icon_state = "breakout"
/datum/sprite_accessory/ipc_screens/console
	name = "Console"
	icon_state = "console"
/datum/sprite_accessory/ipc_screens/ecgwave
	name = "ECG Wave"
	icon_state = "ecgwave"
/datum/sprite_accessory/ipc_screens/eight
	name = "Eight"
	icon_state = "eight"
/datum/sprite_accessory/ipc_screens/eyes
	name = "Eyes"
	icon_state = "eyes"
/datum/sprite_accessory/ipc_screens/glider
	name = "Glider"
	icon_state = "glider"
/datum/sprite_accessory/ipc_screens/goggles
	name = "Goggles"
	icon_state = "goggles"
/datum/sprite_accessory/ipc_screens/green
	name = "Green"
	icon_state = "green"
/datum/sprite_accessory/ipc_screens/heart
	name = "Heart"
	icon_state = "heart"
	color_src = 0
/datum/sprite_accessory/ipc_screens/monoeye
	name = "Mono-eye"
	icon_state = "monoeye"
/datum/sprite_accessory/ipc_screens/nature
	name = "Nature"
	icon_state = "nature"
/datum/sprite_accessory/ipc_screens/orange
	name = "Orange"
	icon_state = "orange"
/datum/sprite_accessory/ipc_screens/pink
	name = "Pink"
	icon_state = "pink"
/datum/sprite_accessory/ipc_screens/purple
	name = "Purple"
	icon_state = "purple"
/datum/sprite_accessory/ipc_screens/rainbow
	name = "Rainbow"
	icon_state = "rainbow"
	color_src = 0
/datum/sprite_accessory/ipc_screens/red
	name = "Red"
	icon_state = "red"
/datum/sprite_accessory/ipc_screens/redtext
	name = "Red Text"
	icon_state = "redtext"
	color_src = 0
/datum/sprite_accessory/ipc_screens/rgb
	name = "RGB"
	icon_state = "rgb"
/datum/sprite_accessory/ipc_screens/scroll
	name = "Scanline"
	icon_state = "scroll"
/datum/sprite_accessory/ipc_screens/shower
	name = "Shower"
	icon_state = "shower"
/datum/sprite_accessory/ipc_screens/sinewave
	name = "Sinewave"
	icon_state = "sinewave"
/datum/sprite_accessory/ipc_screens/squarewave
	name = "Square wave"
	icon_state = "squarewave"
/datum/sprite_accessory/ipc_screens/static_screen
	name = "Static"
	icon_state = "static"
/datum/sprite_accessory/ipc_screens/yellow
	name = "Yellow"
	icon_state = "yellow"
/datum/sprite_accessory/ipc_antennas
	icon = 'sunset/icons/mob/ipc_accessories.dmi'
	color_src = HAIR
/datum/sprite_accessory/ipc_antennas/none
	name = "None"
	icon_state = "None"
/datum/sprite_accessory/ipc_antennas/angled
	name = "Angled"
	icon_state = "antennae"
/datum/sprite_accessory/ipc_antennas/antlers
	name = "Antlers"
	icon_state = "antlers"
/datum/sprite_accessory/ipc_antennas/crowned
	name = "Crowned"
	icon_state = "crowned"
/datum/sprite_accessory/ipc_antennas/cyberhead
	name = "Cyberhead"
	icon_state = "cyberhead"
/datum/sprite_accessory/ipc_antennas/droneeyes
	name = "Drone Eyes"
	icon_state = "droneeyes"
/datum/sprite_accessory/ipc_antennas/light
	name = "Light"
	icon_state = "light"
/datum/sprite_accessory/ipc_antennas/sidelights
	name = "Sidelights"
	icon_state = "sidelights"
/datum/sprite_accessory/ipc_antennas/tesla
	name = "Tesla"
	icon_state = "tesla"
/datum/sprite_accessory/ipc_antennas/tv
	name = "TV Antenna"
	icon_state = "tvantennae"
/datum/sprite_accessory/ipc_chassis // Used for changing limb icons, doesn't need to hold the actual icon. That's handled in ipc.dm
	icon = null
	icon_state = "who cares fuck you" // In order to pull the chassis correctly, we need AN icon_state(see line 36-39). It doesn't have to be useful, because it isn't used.
	color_src = 0
/datum/sprite_accessory/ipc_chassis/mcgreyscale
	name = "Morpheus Cyberkinetics(Greyscale)"
	limbs_id = "mcgipc"
	color_src = MUTCOLORS
/datum/sprite_accessory/ipc_chassis/bishopcyberkinetics
	name = "Bishop Cyberkinetics"
	limbs_id = "bshipc"
/datum/sprite_accessory/ipc_chassis/bishopcyberkinetics2
	name = "Bishop Cyberkinetics 2.0"
	limbs_id = "bs2ipc"
/datum/sprite_accessory/ipc_chassis/hephaestussindustries
	name = "Hephaestus Industries"
	limbs_id = "hsiipc"
/datum/sprite_accessory/ipc_chassis/hephaestussindustries2
	name = "Hephaestus Industries 2.0"
	limbs_id = "hi2ipc"
/datum/sprite_accessory/ipc_chassis/shellguardmunitions
	name = "Shellguard Munitions Standard Series"
	limbs_id = "sgmipc"
/datum/sprite_accessory/ipc_chassis/wardtakahashimanufacturing
	name = "Ward-Takahashi Manufacturing"
	limbs_id = "wtmipc"
/datum/sprite_accessory/ipc_chassis/xionmanufacturinggroup
	name = "Xion Manufacturing Group"
	limbs_id = "xmgipc"
/datum/sprite_accessory/ipc_chassis/xionmanufacturinggroup2
	name = "Xion Manufacturing Group 2.0"
	limbs_id = "xm2ipc"
/datum/sprite_accessory/ipc_chassis/zenghupharmaceuticals
	name = "Zeng-Hu Pharmaceuticals"
	limbs_id = "zhpipc"
