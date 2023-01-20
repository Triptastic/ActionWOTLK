--#############################
--##### TRIP'S WOTLK ROGUE #####
--#############################

local _G, setmetatable, pairs, ipairs, select, error, math = 
_G, setmetatable, pairs, ipairs, select, error, math 

local wipe                                     = _G.wipe     
local math_max                                = math.max      

local TMW                                     = _G.TMW 
local strlowerCache                          = TMW.strlowerCache
local Action                                = _G.Action
local toNum                                 = Action.toNum
local CONST                                 = Action.Const
local Create                                 = Action.Create
local Listener                                = Action.Listener
local Print                                    = Action.Print
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local Pet                                       = LibStub("PetLibrary") 
local AuraType                                    = LibStub("LibAuraTypes")

local SetToggle                                = Action.SetToggle
local GetToggle                                = Action.GetToggle
local GetPing                                = Action.GetPing
local GetGCD                                = Action.GetGCD
local GetCurrentGCD                            = Action.GetCurrentGCD
local GetLatency                            = Action.GetLatency
local GetSpellInfo                            = Action.GetSpellInfo
local BurstIsON                                = Action.BurstIsON
local InterruptIsValid                        = Action.InterruptIsValid
local IsUnitEnemy                            = Action.IsUnitEnemy
local DetermineUsableObject                    = Action.DetermineUsableObject 
local DetermineIsCurrentObject                = Action.DetermineIsCurrentObject 
local DetermineCountGCDs                    = Action.DetermineCountGCDs 
local DetermineCooldownAVG                    = Action.DetermineCooldownAVG 
local AuraIsValid                            = Action.AuraIsValid

local CanUseStoneformDefense                = Action.CanUseStoneformDefense
local CanUseStoneformDispel                    = Action.CanUseStoneformDispel
local CanUseHealingPotion                    = Action.CanUseHealingPotion
local CanUseLivingActionPotion                = Action.CanUseLivingActionPotion
local CanUseLimitedInvulnerabilityPotion    = Action.CanUseLimitedInvulnerabilityPotion
local CanUseRestorativePotion                = Action.CanUseRestorativePotion
local CanUseSwiftnessPotion                    = Action.CanUseSwiftnessPotion
local CanUseManaRune                        = Action.CanUseManaRune

local TeamCacheFriendly                        = TeamCache.Friendly
local ActiveUnitPlates                        = MultiUnits:GetActiveUnitPlates()

local SPELL_FAILED_TARGET_NO_POCKETS        = _G.SPELL_FAILED_TARGET_NO_POCKETS      
local ERR_INVALID_ITEM_TARGET                = _G.ERR_INVALID_ITEM_TARGET    
local MAX_BOSS_FRAMES                        = _G.MAX_BOSS_FRAMES  

local CreateFrame                            = _G.CreateFrame
local UIParent                                = _G.UIParent        
local StaticPopup1                            = _G.StaticPopup1    
local StaticPopup1Button2                    -- nil because frame is not created at this moment

local GetWeaponEnchantInfo                    = _G.GetWeaponEnchantInfo    
local GetItemInfo                            = _G.GetItemInfo  
local      UnitGUID,       UnitIsUnit,      UnitCreatureType,       UnitAttackPower = 
_G.UnitGUID, _G.UnitIsUnit, _G.UnitCreatureType, _G.UnitAttackPower

--For Toaster
local Toaster                                    = _G.Toaster
local GetSpellTexture                             = _G.TMW.GetSpellTexture

Action[Action.PlayerClass]                     = {
    --Racial
	Perception									= Create({ Type = "Spell", ID = 58985		}),
	EscapeArtist								= Create({ Type = "Spell", ID = 20589		}),
	BloodFury									= Create({ Type = "Spell", ID = 20572		}),
	Berserking									= Create({ Type = "Spell", ID = 26297		}),	
	WilloftheForsaken							= Create({ Type = "Spell", ID = 7744		}),
	ArcaneTorrent								= Create({ Type = "Spell", ID = 28730		}),	
	
	--Class Skills
	Ambush										= Create({ Type = "Spell", ID = 8676, useMaxRank = true        }),
	Backstab									= Create({ Type = "Spell", ID = 53, useMaxRank = true        }),
	Blind										= Create({ Type = "Spell", ID = 2094, useMaxRank = true        }),	
	CheapShot									= Create({ Type = "Spell", ID = 1833, useMaxRank = true        }),
	CloakofShadows								= Create({ Type = "Spell", ID = 31224, useMaxRank = true        }),
	ColdBlood									= Create({ Type = "Spell", ID = 14177, useMaxRank = true        }),	
	DeadlyThrow									= Create({ Type = "Spell", ID = 26679, useMaxRank = true        }),
	DisarmTrap									= Create({ Type = "Spell", ID = 1842, useMaxRank = true        }),
	Dismantle									= Create({ Type = "Spell", ID = 51722, useMaxRank = true        }),
	Distract									= Create({ Type = "Spell", ID = 1725, useMaxRank = true        }),
	Envenom										= Create({ Type = "Spell", ID = 32645, useMaxRank = true        }),	
	Evasion										= Create({ Type = "Spell", ID = 5277, useMaxRank = true        }),
	Eviscerate									= Create({ Type = "Spell", ID = 2098, useMaxRank = true        }),
	ExposeArmor									= Create({ Type = "Spell", ID = 8647, useMaxRank = true        }),
	FanofKnives									= Create({ Type = "Spell", ID = 51723, useMaxRank = true        }),
	Feint										= Create({ Type = "Spell", ID = 1966, useMaxRank = true        }),	
	Garrote										= Create({ Type = "Spell", ID = 703, useMaxRank = true        }),
	Gouge										= Create({ Type = "Spell", ID = 1776, useMaxRank = true        }),
	Kick										= Create({ Type = "Spell", ID = 1766, useMaxRank = true        }),
	KidneyShot									= Create({ Type = "Spell", ID = 408, useMaxRank = true        }),
	PickLock									= Create({ Type = "Spell", ID = 1804, useMaxRank = true        }),
	PickPocket									= Create({ Type = "Spell", ID = 921, useMaxRank = true        }),
	Rupture										= Create({ Type = "Spell", ID = 1943, useMaxRank = true        }),
	Sap											= Create({ Type = "Spell", ID = 6770, useMaxRank = true        }),	
	Shiv										= Create({ Type = "Spell", ID = 5938, useMaxRank = true        }),
	SinisterStrike								= Create({ Type = "Spell", ID = 1752, useMaxRank = true        }),
	SliceandDice								= Create({ Type = "Spell", ID = 5171, useMaxRank = true        }),
	Sprint										= Create({ Type = "Spell", ID = 2983, useMaxRank = true        }),
	Stealth										= Create({ Type = "Spell", ID = 1784, useMaxRank = true        }),	
	TricksoftheTrade							= Create({ Type = "Spell", ID = 57934, useMaxRank = true        }),
	Vanish										= Create({ Type = "Spell", ID = 1856, useMaxRank = true        }),
	AdrenalineRush								= Create({ Type = "Spell", ID = 13750, useMaxRank = true        }),	
	BladeFlurry									= Create({ Type = "Spell", ID = 13877, useMaxRank = true        }),	
	GhostlyStrike								= Create({ Type = "Spell", ID = 14278, useMaxRank = true        }),
	Hemorrhage									= Create({ Type = "Spell", ID = 16511, useMaxRank = true        }),	
	HungerForBlood								= Create({ Type = "Spell", ID = 51662, useMaxRank = true        }),	
	KillingSpree								= Create({ Type = "Spell", ID = 51690, useMaxRank = true        }),		
	Mutilate									= Create({ Type = "Spell", ID = 1329, useMaxRank = true        }),	
	Premeditation								= Create({ Type = "Spell", ID = 14183, useMaxRank = true        }),	
	Preparation									= Create({ Type = "Spell", ID = 14185, useMaxRank = true        }),
	Riposte										= Create({ Type = "Spell", ID = 14251, useMaxRank = true        }),
	ShadowDance									= Create({ Type = "Spell", ID = 51713, useMaxRank = true        }),	
	Shadowstep									= Create({ Type = "Spell", ID = 36554, useMaxRank = true        }),	

    -- Potions
    MajorManaPotion                            = Create({ Type = "Potion", ID = 13444	}),
    -- Hidden Items    
    -- Note: Healthstone items created in Core.lua

	--Glyphs

	
	--Items

	
	--Talents
	Overkill									= Create({ Type = "Spell", ID = 58426, useMaxRank = true        }),	
	MasterofSubtlety							= Create({ Type = "Spell", ID = 31221, useMaxRank = true        }),		
	MasterPoisoner								= Create({ Type = "Spell", ID = 31226, useMaxRank = true        }),
	
    --Misc
    Heroism										= Create({ Type = "Spell", ID = 32182        }),
    Bloodlust									= Create({ Type = "Spell", ID = 2825        }),
    Drums										= Create({ Type = "Spell", ID = 29529        }),
    SuperHealingPotion							= Create({ Type = "Potion", ID = 22829, QueueForbidden = true }),
    SunderArmor									= Create({ Type = "Spell", ID = 7386        }),
    PoolResource								= Create({ Type = "Spell", ID = 13980        }),	
}

local A                                     = setmetatable(Action[Action.PlayerClass], { __index = Action })

local player = "player"
local target = "target"
local pet = "pet"
local targettarget = "targettarget"
local focus = "focus"

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

--Register Toaster
Toaster:Register("TripToast", function(toast, ...)
        local title, message, spellID = ...
        toast:SetTitle(title or "nil")
        toast:SetText(message or "nil")
        if spellID then 
            if type(spellID) ~= "number" then 
                error(tostring(spellID) .. " (spellID) is not a number for TripToast!")
                toast:SetIconTexture("Interface\FriendsFrame\Battlenet-WoWicon")
            else 
                toast:SetIconTexture((GetSpellTexture(spellID)))
            end 
        else 
            toast:SetIconTexture("Interface\FriendsFrame\Battlenet-WoWicon")
        end 
        toast:SetUrgencyLevel("normal") 
end)

------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
    AuraForCC                               = {"TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun"},    
    AuraForInterrupt                        = {"TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun", "KickImun"},
    AuraForFear                             = {"TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun", "FearImun"},	
	OpenerRotation							= false,	
	PvPOpener								= false,		
}

local ImmuneArcane = {
    [18864] = true,
    [18865] = true,
    [15691] = true,
    [20478] = true, -- Arcane Servant
}    

local function InRange(unitID)
    -- @return boolean 
    return A.SinisterStrike:IsInRange(unitID)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(unitID, nil, nil, true)   
	if useKick and A.Kick:IsReady(unitID) and not notInterruptable then
		return A.Kick
	end
	
	if useKick and A.Gouge:IsReady(unitID) and not notInterruptable and A.Gouge:AbsentImun(unitID, Temp.AuraForCC) and Unit(unitID):IsControlAble("incapacitate") then
		return A.Gouge
	end
	
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)


local function EnvenomCalc()

	local base, posBuff, negBuff = UnitAttackPower(player)
	local effective = base + posBuff + negBuff
	local ComboPoints = Player:ComboPoints() or 0
	
	if A.Envenom:IsTalentLearned() then
		return A.Envenom:GetSpellDescription()[2]*ComboPoints+effective*(0.09*ComboPoints)
	else return false
	end

end

local function EviscerateCalc()

	local base, posBuff, negBuff = UnitAttackPower(player)
	local effective = base + posBuff + negBuff
	local ComboPoints = Player:ComboPoints()
	local minDamage = 0
	local n = (-2)*ComboPoints + 12 

	if ComboPoints == 0 then
		minDamage = 0
	elseif ComboPoints >= 1 then
		minDamage = A.Eviscerate:GetSpellDescription()[n]
	end

	return minDamage

end


--[[###############
--### POISONS ###
--###############
	
local function ImbueWeapon()
	local MainHandPoison = A.GetToggle(2, "MainHandPoison")
	local OffhandPoison = A.GetToggle(2, "OffhandPoison")
	local MainHandAuto = "None"
	local OffhandAuto = "None"
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()
	local _, hasWeapon = UnitAttackSpeed(player)

	local InstantPoison = {[323] = true, [324] = true, [325] = true, [623] = true, [624] = true, [625] = true, [2641] = true, [3768] = true, [3769] = true}
	local WoundPoison = {[703] = true, [704] = true, [705] = true, [706] = true, [2644] = true, [3772] = true, [3773] = true}	
	local DeadlyPoison = {[7] = true, [8] = true, [626] = true, [627] = true, [2630] = true, [2642] = true, [2643] = true, [3770] = true, [3771] = true,}
	
	if MainHandPoison ~="Auto" then
		MainHandAuto = "None"
	end
	if OffhandPoison ~="Auto" then
		OffhandAuto = "None"
	end

	if MainHandPoison == "Auto" then
		if A.WindfuryWeapon:IsTalentLearned() then
			MainHandAuto = "Windfury"
		else MainHandAuto = "Rockbiter"
		end
		elseif SpecOverride == "Elemental" or (SpecOverride == "AUTO" and A.Thunderstorm:IsTalentLearned()) then
			MainHandAuto = "Flametongue"
		elseif SpecOverride == "Restoration" or (SpecOverride == "AUTO" and A.Riptide:IsTalentLearned()) then
			MainHandAuto = "Earthliving"
		end
	end

	if OffhandEnchant == "Auto" then
		if hasWeapon ~= nil then
			if SpecOverride == "Enhancement" or (SpecOverride == "AUTO" and A.FeralSpirit:IsTalentLearned()) then
				if A.WindfuryWeapon:IsTalentLearned() then
					OffhandAuto = "Windfury"
				else OffhandAuto = "Rockbiter"
				end
			elseif SpecOverride == "Elemental" or (SpecOverride == "AUTO" and A.Thunderstorm:IsTalentLearned()) then
				OffhandAuto = "Flametongue"
			elseif SpecOverride == "Restoration" or (SpecOverride == "AUTO" and A.Riptide:IsTalentLearned()) then
				OffhandAuto = "Earthliving"
			end
		end
	end

	if MainHandPoison == "Instant" or MainHandAuto == "Instant" then
		if A.WindfuryWeapon:IsReady(player) and ((WindfuryBuff[mainHandEnchantID] and mainHandExpiration <= 3000 and not inCombat) or not WindfuryBuff[mainHandEnchantID]) then
			return A.WindfuryWeapon
		end
	elseif MainHandPoison == "Wound" or MainHandAuto == "Wound" then
		if A.RockbiterWeapon:IsReady(player) and ((RockbiterBuff[mainHandEnchantID] and mainHandExpiration <= 3000 and not inCombat) or not RockbiterBuff[mainHandEnchantID]) then
			return A.RockbiterWeapon
		end		
	elseif MainHandPoison == "Deadly" or MainHandAuto == "Deadly" then
		if A.FlametongueWeapon:IsReady(player) and ((FlametongueBuff[mainHandEnchantID] and mainHandExpiration <= 3000 and not inCombat) or not FlametongueBuff[mainHandEnchantID]) then
			return A.FlametongueWeapon
		end					
	end
	
	if Unit(player):HasBuffs(A.GhostWolf.ID) == 0 and hasWeapon ~= nil then
		if OffhandEnchant == "Windfury" or OffhandAuto == "Windfury" then
			if A.WindfuryWeapon:IsReady(player) and ((WindfuryBuff[offHandEnchantID] and offHandExpiration <= 3000 and not inCombat) or not WindfuryBuff[offHandEnchantID]) then
				return A.WindfuryWeapon
			end
		elseif OffhandEnchant == "Rockbiter" or OffhandAuto == "Rockbiter" then
			if A.RockbiterWeapon:IsReady(player) and ((RockbiterBuff[offHandEnchantID] and offHandExpiration <= 3000 and not inCombat) or not RockbiterBuff[offHandEnchantID]) then
				return A.RockbiterWeapon
			end		
		elseif OffhandEnchant == "Flametongue" or OffhandAuto == "Flametongue" then
			if A.FlametongueWeapon:IsReady(player) and ((FlametongueBuff[offHandEnchantID] and offHandExpiration <= 3000 and not inCombat) or not FlametongueBuff[offHandEnchantID]) then
				return A.FlametongueWeapon
			end		
		elseif OffhandEnchant == "Frostbrand" or OffhandAuto == "Frostbrand" then
			if A.FrostbrandWeapon:IsReady(player) and ((FrostbrandBuff[offHandEnchantID] and offHandExpiration <= 3000 and not inCombat) or not FrostbrandBuff[offHandEnchantID]) then
				return A.FrostbrandWeapon
			end	
		elseif OffhandEnchant == "Earthliving" or OffhandAuto == "Earthliving" then
			if A.EarthlivingWeapon:IsReady(player) and ((EarthlivingBuff[offHandEnchantID] and mainHandExpiration <= 3000 and not inCombat) or not EarthlivingBuff[offHandEnchantID]) then
				return A.EarthlivingWeapon
			end		
		end
	end	
end]]

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local UseAoE = A.GetToggle(2, "AoE")
	local FoKEnemies = A.GetToggle(2, "FoKEnemies")
	local BFEnemies = A.GetToggle(2, "BFEnemies")	
	local FoKAoE = UseAoE and MultiUnits:GetByRange(10, 10) >= FoKEnemies
	local BFAoE = UseAoE and MultiUnits:GetByRange(10, 10) >= BFEnemies	

	if (Player:IsCasting() or Player:IsChanneling()) then
		canCast = false
	else 
		canCast = true
	end

    --###############################
    --##### POTIONS/HEALTHSTONE #####
    --###############################
    
    local UsePotions = A.GetToggle(1, "Potion")        
    local PotionController = A.GetToggle(2, "PotionController")    
 
		if not Player:IsStealthed() then 
			-- Healthstone 
			local Healthstone = GetToggle(2, "HSHealth") 
			if Healthstone >= 0 then 
				local HealthStoneObject = DetermineUsableObject(player, true, nil, true, nil, A.HSGreater3, A.HSGreater2, A.HSGreater1, A.HS3, A.HS2, A.HS1, A.HSLesser3, A.HSLesser2, A.HSLesser1, A.HSMajor3, A.HSMajor2, A.HSMajor1, A.HSMinor3, A.HSMinor2, A.HSMinor1)
				if HealthStoneObject then 			
					if Healthstone >= 100 then -- AUTO 
						if Unit(player):TimeToDie() <= 9 and Unit(player):HealthPercent() <= 40 then 
							return HealthStoneObject:Show(icon)	
						end 
					elseif Unit(player):HealthPercent() <= Healthstone then 
						return HealthStoneObject:Show(icon)								 
					end 
				end 
			end 		
		end 

	if UsePotions and combatTime > 2 then
		--Living Action
		if PotionController == "LivingActionPotion" and Action.CanUseLivingActionPotion(icon, InRange()) then 
			return true
		end 
		
		-- RestorativePotion
		if PotionController == "RestorativePotion" and Action.CanUseRestorativePotion(icon) then 
			return true 
		end   

		-- LimitedInvulnerabilityPotion
		if PotionController == "LimitedInvulnerabilityPotion" and Unit(player):HasBuffs("DeffBuffs") and Action.CanUseLimitedInvulnerabilityPotion(icon) then 
			return true  
		end 
		
		-- HealingPotion 
		if PotionController == "HealingPotion" and Action.CanUseHealingPotion(icon) then 
			return true 
		end 	
	end
    
    --######################
    --##### DEFENSIVES #####
    --######################	
	
	local EvasionHP = A.GetToggle(2, "EvasionHP")
	if inCombat then
		if A.Evasion:IsReady(player) and Unit(player):HealthPercent() <= EvasionHP then
			return A.Evasion:Show(icon)
		end	
	end
	
	--Will of the Forsaken
	if A.WilloftheForsaken:AutoRacial() then 
		return A.WilloftheForsaken:Show(icon)
	end 
	
	-- EscapeArtist
	if A.EscapeArtist:AutoRacial() then 
		return A.EscapeArtist:Show(icon)
	end 	  
 
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function PvERotation(unitID)

        local npcID = select(6, Unit(unitID):InfoGUID())		
		local SpecSelect = A.GetToggle(2, "SpecSelect")
		local ComboPoints = Player:ComboPoints()
		local EnvenomCalc = EnvenomCalc()
		local EviscerateCalc = EviscerateCalc()
		local ColdBloodEnvenom = A.GetToggle(2, "BuffColdBlood") == "Envenom"
		local ColdBloodEviscerate = A.GetToggle(2, "BuffColdBlood") == "Eviscerate"
		local ColdBloodRupture = A.GetToggle(2, "BuffColdBlood") == "Rupture"

		local DoInterrupt = Interrupts(unitID)
		if DoInterrupt then 
			return DoInterrupt:Show(icon)
		end

		if inCombat and BurstIsON(unitID) and (A.ShadowDance:IsReady(player) or not A.ShadowDance:IsTalentLearned()) then
				
			if A.AdrenalineRush:IsReady(player) then
				return A.AdrenalineRush:Show(icon)
			end
			
			if A.KillingSpree:IsReady(player) and Unit(player):HasBuffs(A.BladeFlurry.ID) == 0 and InRange() then
				return A.KillingSpree:Show(icon)
			end
			
			if A.BloodFury:IsReady(player) then
				return A.BloodFury:Show(icon)
			end
			
			if A.Berserking:IsReady(player) then
				return A.Berserking:Show(icon)
			end

			if A.Vanish:IsReady(player) and (A.Overkill:IsTalentLearned() or (A.MasterofSubtlety:IsTalentLearned() and A.ShadowDance:IsReady(player))) then
				return A.Vanish:Show(icon)
			end
			
			--Trinket 1
			if A.Trinket1:IsReady(player) then
				return A.Trinket1:Show(icon)    
			end
			
			--Trinket 2
			if A.Trinket2:IsReady(player) then
				return A.Trinket2:Show(icon)    
			end    			
		end

		if A.Sap:IsReady(unitID) and Player:GetDeBuffsUnitCount(A.Sap.ID, true) < 1 then
			return A.Sap:Show(icon)
		end

		if A.Premeditation:IsReady(unitID) then
			return A.Premeditation:Show(icon)
		end

		if Unit(unitID):HasDeBuffs(A.Sap.ID) == 0 then
		
			if Unit(player):HasBuffs(A.Stealth.ID) > 0 then
				local openGarrote = A.GetToggle(2, "openStealth") == "openGarrote"
				local openCheapShot = A.GetToggle(2, "openStealth") == "openCheapShot"
				local openAmbush = A.GetToggle(2, "openStealth") == "openAmbush"
				local openManual = A.GetToggle(2, "openStealth") == "openManual"	
				
				if A.Garrote:IsReady(unitID) and openGarrote and Player:IsBehind(2) and Unit(unitID):HasDeBuffs(A.Garrote.ID, true) == 0 then
					return A.Garrote:Show(icon)
				end

				if A.CheapShot:IsReady(unitID) and openCheapShot then
					return A.CheapShot:Show(icon)
				end
			
				if A.Ambush:IsReady(unitID) and openAmbush and Player:IsBehind(2) then
					return A.Ambush:Show(icon)
				end
			end
		
			if Unit(player):HasBuffs(A.Stealth.ID) == 0 then
				if A.FanofKnives:IsReady(player) and FoKAoE then
					return A.FanofKnives:Show(icon)
				end

				if A.BladeFlurry:IsReady(player) and BFAoE and (not FoKAoE and A.FanofKnives:IsTalentLearned() or not A.FanofKnives:IsTalentLearned()) then
					return A.BladeFlurry:Show(icon)
				end

				if A.TricksoftheTrade:IsReady(player) and Unit(focus):IsExists() and A.IsUnitFriendly(focus) then
					return A.TricksoftheTrade:Show(icon)
				end

				if A.ExposeArmor:IsReady(unitID) and ((Unit(unitID):HasDeBuffs(A.ExposeArmor.ID) == 0 and Unit(unitID):HasDeBuffs(A.SunderArmor.ID) == 0) or (Unit(unitID):HasDeBuffs(A.ExposeArmor.ID) < 4 and Unit(unitID):HasDeBuffs(A.SunderArmor.ID) == 0 and ComboPoints >= 4)) then
					return A.ExposeArmor:Show(icon)
				end	

				if A.Envenom:IsReady(unitID) and Unit(player):HasBuffs(A.Envenom.ID, true) == 0 and A.MasterPoisoner:IsTalentLearned() and ((Unit(player):HasBuffs(A.SliceandDice.ID and A.HungerForBlood.ID, true) > 0 and ComboPoints >= 4) or Unit(unitID):Health() <= EnvenomCalc) then
					if A.ColdBlood:IsReady(player) and BurstIsON(unitID) and ColdBloodEnvenom then
						return A.ColdBlood:Show(icon)
					end
					return A.Envenom:Show(icon)
				end

				if A.HungerForBlood:IsReady(player) and Unit(player):HasBuffs(A.SliceandDice.ID, true) >  3 and Unit(player):HasBuffs(A.HungerForBlood.ID) <= A.GetGCD() then
					return A.HungerForBlood:Show(icon)
				end

				if A.SliceandDice:IsReady(player) and Unit(player):HasBuffs(A.SliceandDice.ID, true) < 1 then
					return A.SliceandDice:Show(icon)
				end

				if A.Eviscerate:IsReady(unitID) and ((BFAoE and Unit(player):HasBuffs(A.BladeFlurry.ID, true) > 0) or Unit(unitID):Health() < EviscerateCalc) and (ComboPoints >= 4 or Unit(unitID):Health() < EviscerateCalc) then
					if A.ColdBlood:IsReady(player) and BurstIsON(unitID) and ColdBloodEviscerate then
						return A.ColdBlood:Show(icon)
					end				
					return A.Eviscerate:Show(icon)
				end
				
				if A.Rupture:IsReady(unitID) and ((A.HungerForBlood:IsTalentLearned() and Unit(player):HasBuffs(A.HungerForBlood.ID, true) <= A.GetGCD()) or (not A.HungerForBlood:IsTalentLearned() and (Unit(unitID):HasDeBuffs(A.Rupture.ID, true) == 0 or ComboPoints >= 4 and Unit(unitID):HasDeBuffs(A.Rupture.ID, true) < 3))) then
					if not BFAoE and Unit(player):HasBuffs(A.BladeFlurry.ID) == 0 then
						if A.ColdBlood:IsReady(player) and BurstIsON(unitID) and ColdBloodRupture then
							return A.ColdBlood:Show(icon)
						end
						return A.Rupture:Show(icon)
					end
				end	
				
				if A.Riposte:IsReady(unitID) then
					return A.Riposte:Show(icon)
				end

				if A.Ambush:IsReady(unitID) and Player:IsBehind() and Unit(player):HasBuffs(A.ShadowDance.ID, true) > 0 and ComboPoints < 5 then
					return A.Ambush:Show(icon)
				end
		
				if A.ShadowDance:IsTalentLearned() and A.ShadowDance:GetCooldown() <= 3 and Player:Energy() <= 80 then
					return A.PoolResource:Show(icon)
				end
				
				if A.ShadowDance:IsReady(player) and InRange() then
					return A.ShadowDance:Show(icon)
				end
		
				if A.Eviscerate:IsReady(unitID) and ComboPoints >= 4 then
					if A.ColdBlood:IsReady(player) and BurstIsON(unitID) and ColdBloodEnvenom then
						return A.ColdBlood:Show(icon)
					end				
					return A.Eviscerate:Show(icon)
				end
		
				if A.GhostlyStrike:IsReady(unitID) then
					return A.GhostlyStrike:Show(icon)
				end
		
				if A.Hemorrhage:IsReady(unitID) and ComboPoints < 4 then
					return A.Hemorrhage:Show(icon)
				end
		
				if A.Mutilate:IsReady(unitID) then
					return A.Mutilate:Show(icon)
				end
				
				if A.Backstab:IsReady(unitID) and Player:IsBehind(2) then
					return A.Backstab:Show(icon)
				end
				
				if A.SinisterStrike:IsReady(unitID) and not A.Mutilate:IsTalentLearned() and not A.Hemorrhage:IsTalentLearned() then
					return A.SinisterStrike:Show(icon)
				end
			end
		end
    end

	local function PvPRotation(unitID)

		--Stealth whenever possible
		--Premeditation whenever possible
		--if stealth, continue. if pulled out of stealth, shadow dance now.
		--Cheap Shot
		--Eviscerate
		--Shadow Dance
		--Ambush
		--if combopoints 4/5, kidney shot before Cheap Shot expires
		--if combopoints < 4, ambush if they have nothing otherwise cheap shot
		--if unit has defensives and not close to dead, SND, gouge and leave

		local amStealthed = Unit(player):HasBuffs(A.Stealth.ID) > 0
		local amDancing	= Unit(player):HasBuffs(A.ShadowDance.ID) > 0
		local comboPoints = Player:ComboPoints()
		local cheapShotDR = Unit(unitID):GetDR("opener_stun")
		local kidneyDR = Unit(unitID):GetDR("stun")
		local isStunned = Unit(unitID):HasDeBuffs("Stuned")
		local energy = Player:Energy()

		if A.CheapShot:GetCooldown() == 0 and A.KidneyShot:GetCooldown() < 1 and A.ShadowDance:GetCooldown() < 1 and (A.Premeditation:IsReady(unitID) or comboPoints >= 2) then
			Temp.PvPOpener = true
		end

		if A.Stealth:IsReady(player) then
			return A.Stealth:Show(icon)
		end

		if A.Premeditation:IsReady(unitID) and comboPoints <= 3 then
			return A.Premeditation:Show(icon)
		end	

		if A.CheapShot:IsReady(unitID) and amStealthed and (cheapShotDR == 100 or (cheapShotDR >= 50 and comboPoints <= 3)) and isStunned <= 1 then
			return A.CheapShot:Show(icon)
		end

		if A.KidneyShot:IsReady(unitID) and comboPoints >= 4 and kidneyDR >= 75 and isStunned <= 1 then
			return A.KidneyShot:Show(icon)
		end

		if A.Eviscerate:IsReady(unitID) then
			if comboPoints >= 4 or Unit(unitID):Health() <= EviscerateCalc() then
				return A.Eviscerate:Show(icon)
			end
		end

		if A.ShadowDance:IsReady(player) and not amStealthed and InRange() then
			return A.ShadowDance:Show(icon)
		end

		if A.Ambush:IsReady(unitID) and Player:IsBehind() then
			return A.Ambush:Show(icon)
		end

		if A.Backstab:IsReady(unitID) and Player:IsBehind() then
			return A.Backstab:Show(icon)
		end

		if A.Hemorrhage:IsReady(unitID) and energy >= A.Backstab:GetSpellPowerCost() then
			return A.Hemorrhage:Show(icon)
		end

	end


	if A.IsUnitEnemy("target") then
		if A.IsInPvP then 
        	return PvPRotation("target")
			else return PvERotation("target")
		end
    end 
        
end
-- Finished

A[1] = nil

A[4] = nil

A[5] = nil

A[6] = nil

A[7] = nil

A[8] = nil
 