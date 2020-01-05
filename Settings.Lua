local DMW = DMW
DMW.Rotations.HUNTER = {}
local Hunter = DMW.Rotations.HUNTER
local UI = DMW.UI

function Hunter.Settings()
    -- UI.HUD.Options = {
    --     [1] = {
    --         Test = {
    --             [1] = {Text = "HUD Test |cFF00FF00On", Tooltip = ""},
    --             [2] = {Text = "HUD Test |cFFFFFF00Sort Of On", Tooltip = ""},
    --             [3] = {Text = "HUD Test |cffff0000Disabled", Tooltip = ""}
    --         }
    --     }
    -- }






	UI.AddHeader("Defensive")
	
	UI.AddToggle("Aspect Of The Monkey", "Use Aspect of the Monkey", true)
	UI.AddRange	("Aspect of the Monkey HP", "HP to cast AotM", 0, 100, 1, 75)
	
	
	UI.AddHeader("Utility")
	UI.AddToggle("Aspect of the Hawk", "Will use AotH in combat", true)
	UI.AddToggle("Trueshot Aura", "Will use TsA in combat", true)
	UI.AddToggle("Call Pet", "Call active pet ", true)
	UI.AddToggle("Revive Pet", "Revive active pet ", true)
	UI.AddToggle("Mend Pet", "Activate Mend Pet", false)
	UI.AddRange	("Mend Pet HP", "Pet HP to cast Mend Pet", 0, 100, 1, 35)
	
	UI.AddHeader("DPS")
	UI.AddToggle("Hunters Mark", nil, true)
	UI.AddToggle("Auto Pet Attack", "Auto cast pet attack on target", true)
	UI.AddToggle("Aimed Shot","Auto cast Aim Shot", true, true)
	UI.AddToggle("Multi Shot","Auto cast Multi Shot", nil)
	UI.AddRange("Multi Shot Mana", "Minimum mana pct to cast Multi Shot", 0, 100, 1, 35)
	UI.AddToggle("Serpent Sting","Auto cast Serpent Sting", nil)
	UI.AddRange("Seperent Sting Mana", "Minimum mana pct to cast Serpent Sting", 0, 100, 1, 35)
	UI.AddToggle("Cycle Serpent Sting", "Spread Serpent Sting to all enemies", false)
	UI.AddRange("Multidot Limit", "Max number of units to dot", 0, 10, 1, 3)
	

	UI.AddHeader("Melee")
	UI.AddToggle("Raptor Strike", nil, true)
	UI.AddToggle("Wing Clip", nil, true)
	
	
	
	
end

