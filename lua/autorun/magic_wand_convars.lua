MAGIC_WAND = MAGIC_WAND or {}
MAGIC_WAND.CVARS = MAGIC_WAND.CVARS or {}

local magic_wand_test_convar = CreateConVar("ttt_magic_wand_test_convar", "1000", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})

GRAB_AND_THROW.CVARS.magic_wand_test_convar = magic_wand_test_convar:GetInt()

if SERVER then

  cvars.AddChangeCallback("ttt_magic_wand_test_convar", function(name, old, new)
    GRAB_AND_THROW.CVARS.grab_and_throw_strength = tonumber(new)
  end, nil)
end
