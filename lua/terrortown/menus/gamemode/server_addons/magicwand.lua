CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "submenu_addons_magic_wand_title"

function CLGAMEMODESUBMENU:Populate(parent)
	local form = vgui.CreateTTT2Form(parent, "header_addons_magic_wand")

	form:MakeHelp({
		label = "help_magic_wand_menu"
	})

	form:MakeSlider({
		label = "label_magic_wand_test_convar",
		serverConvar = "ttt_magic_wand_test_convar",
		min = 1,
		max = 3000,
		decimal = 0
	})
end
