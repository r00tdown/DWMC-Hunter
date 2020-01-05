local DMW = DMW
local Hunter = DMW.Rotations.HUNTER
local Rotation = DMW.Helpers.Rotation
local Setting = DMW.Helpers.Rotation.Setting
local Player, Pet, Buff, Debuff, Spell, Target, Talent, Item, GCD, Health, CDs, HUD, Enemy20Y, Enemy20YC, Enemy30Y, Enemy30YC
local ShotTime = GetTime()

local function Locals()
    Player = DMW.Player
    Buff = Player.Buffs
    Debuff = Player.Debuffs
	Health = Player.Health
	Pet = DMW.Player.Pet
    HP = Player.HP
    Power = Player.PowerPct
    Spell = Player.Spells
    Talent = Player.Talents
    Trait = Player.Traits
    Item = Player.Items
    Target = Player.Target or false
    HUD = DMW.Settings.profile.HUD
    CDs = Player:CDs()
	GCD = Player:GCD()
	Enemy40Y, Enemy40YC = Player:GetEnemies(40)
	Enemy20Y, Enemy20YC = Player:GetEnemies(20)
    Enemy30Y, Enemy30YC = Player:GetEnemies(30)
    Player40Y, Player40YC = Player:GetEnemies(40)
 end
  
 local function Auto()
 
	if  not IsAutoRepeatSpell(Spell.AutoShot.SpellName) and (DMW.Time - ShotTime) > 0.5 and Target.Distance > 8 and Spell.AutoShot:Cast(Target) then
	StartAttack()
	ShotTime = DMW.Time
	return true
		end
  end

local function Defensive()
 	if  Setting ("Aspect Of The Monkey") and Player.Combat  and Player.HP < Setting("Aspect of the Monkey HP") and Player.PowerPct > 20  and Target.Distance < 5 and not Buff.AspectOfTheMonkey:Exist(Player)  and Spell.AspectOfTheMonkey:Cast(Player) then
		return true 
	end
end

local function Utility()
	
	if Setting("Call Pet") and (not Pet or Pet.Dead) and Spell.CallPet:Cast(Player) then
            return true 
	end
	
	if Setting("Aspect of the Hawk") 
		and not (Buff.AspectOfTheHawk:Exist(Player) or Buff.AspectOfTheMonkey:Exist(Player)) 
		and Player.PowerPct > 30 and Spell.AspectOfTheHawk:Cast(Player) then
		return true
	end	
	
	if Setting("Trueshot Aura") 
		and not Buff.TrueshotAura:Exist(Player) and Player.PowerPct > 10 and Spell.TrueshotAura:Cast(Player) then
        return true
        
    end
	
	if Setting("Mend Pet") and Player.Combat and not Player.Moving and Pet and not Pet.Dead and Pet.HP < Setting("Mend Pet HP") and Player.PowerPct > 30 and Spell.MendPet:Cast(Pet) then
        return true
    end
	
 end
 


local function MultiDot()

	if Setting("Cycle Serpent Sting") and Setting("Serpent Sting") and Debuff.SerpentSting:Count() < Setting("Multidot Limit") then
        for _, Unit in ipairs(Enemy30Y) do
            if Target.Facing and Target.Distance > 8 
			and not Debuff.SerpentSting:Exist(Target) 
			and Player.PowerPct > Setting("Seperent Sting Mana")
			and Unit.TTD > 10
			and Target.CreatureType ~= "Totem" and Target.CreatureType ~= "Mechanical" and Target.CreatureType ~= "Elemental"
			and Spell.SerpentSting:Cast(Target) then
            return true
            end
        end
    end
	
end
	
local function Dot()
	if Setting("Serpent Sting")  
		and Target.Facing and  Target.Distance > 8 
		and not Debuff.SerpentSting:Exist(Target)
		and not Spell.SerpentSting:LastCast()
		and Target.TTD > 10
		and Player.PowerPct > Setting("Seperent Sting Mana")
		and Target.CreatureType ~= "Totem" and Target.CreatureType ~= "Mechanical" and Target.CreatureType ~= "Elemental"
		and Spell.SerpentSting:Cast(Target) then
		return true
    end	
end

local function OoCPvE()

if Setting("Hunters Mark") and Target.Facing and Target.Distance > 8 and Target.TTD > 2 and Target.CreatureType ~= "Totem" and not Debuff.HuntersMark:Exist(Target) and Spell.HuntersMark:Cast(Target) then
		return true
		end
		
		
if Setting("Aimed Shot") and Target.Facing and not Player.Moving  and not Player.Casting ~= Spell.AimedShot.SpellName and Spell.AimedShot:IsReady() and Target.Distance > 8 and Target.Distance < 40 and Spell.AimedShot:Cast(Target) then
            
			return true
        end
end
 
local function PvE()
				
		
		if Setting("Hunters Mark") and Target.Facing and Target.Distance > 8 and Target.TTD > 2 and Target.CreatureType ~= "Totem" and not Debuff.HuntersMark:Exist(Target) and Spell.HuntersMark:Cast(Target) then
		return true
		end
		
		 if Setting("Auto Pet Attack") and Pet and not Pet.Dead and not UnitIsUnit(Target.Pointer, "pettarget") then
           
            PetAttack()
        end
       					
		if Dot() then
        return true
        end
		
		if MultiDot() then
        return true
        end
		
		if Setting("Multi Shot") and Target.Facing and not Player.Moving and Player.PowerPct > Setting("Multi Shot Mana") and Spell.MultiShot:IsReady() and Spell.MultiShot:Cast(Target) then
            return true
        end
		
		if Setting("Aimed Shot") and Target.Facing and not Player.Moving and Spell.AutoShot:LastCast() and Target.TTD > Spell.AimedShot:CastTime() and Spell.AimedShot:IsReady() and Spell.AimedShot:Cast(Target) then
           
			return true
        end
					
end		
	
local function Melee()
		 if Setting("Auto Pet Attack") and Pet and not Pet.Dead and not UnitIsUnit(Target.Pointer, "pettarget") then
           
            PetAttack()
        end
		
		if  Target.Distance < 6 and  Target.Facing  then
		SpellStopCasting()
		StartAttack()
		end	
		
		if Setting("Raptor Strike") and Target.Facing and  Target.Distance < 5 and  Target.TTD > 2 and Spell.RaptorStrike:IsReady()and Spell.RaptorStrike:Cast(Target) then
			return true	
		end
		
		if Setting("Wing Clip") and Target.Facing and  Target.Distance < 5 and not Debuff.WingClip:Exist(Target) and Target.CreatureType ~= "Totem" and Spell.WingClip:Cast(Target) then
			return true	
		end	
		
		if Target.Facing and  Target.Distance < 5  and Spell.MongooseBite:IsReady() and Spell.MongooseBite:Cast(Target) then
			return true	
		end
end

function Hunter.Rotation()
    Locals()
	
	if Utility() then
	return true 
	end
	
	if Target then
		OoCPvE()
    end 
	
	
	if Target and Player.Combat and  Target.Distance > 8 and Target.Distance < 40 then
		StopAttack()
		Auto()
		PvE()
    end
	
	if Target and Player.Combat and  Target.Distance <5 then
		Melee()
	end
	
end	
