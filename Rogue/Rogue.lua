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
	ThistleTea                                = Create({ Type = "Item",  ID = 7676  }),
	GoblinSapperCharge                          = Create({ Type = "Item",  ID = 10646  }),
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
	activeBleeds							= {	48672, -- Rupture
												48676, -- Garrote
												49800, -- Rip
												48574, -- Rake
												49804, -- Pounce
												48568, -- Lacerate
												47465, -- Rend
												12867, -- Deep Wounds
												63468, -- Piercing Shots
												59886, -- Rake
												53582, -- Savage Rend
	},	
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


local function UseTrinkets(unitID)
	local TrinketType1 = A.GetToggle(2, "TrinketType1")
	local TrinketType2 = A.GetToggle(2, "TrinketType2")
	local TrinketValue1 = A.GetToggle(2, "TrinketValue1")
	local TrinketValue2 = A.GetToggle(2, "TrinketValue2")	

	if A.Trinket1:IsReady(unitID) then
		if TrinketType1 == "Damage" and Player:ManaPercentage() >= 20 then
			if A.BurstIsON(unitID) and A.IsUnitEnemy(unitID) then
				return A.Trinket1
			end
		elseif TrinketType1 == "Friendly" and A.IsUnitFriendly(unitID) then
			if Unit(unitID):HealthPercent() <= TrinketValue1 then
				return A.Trinket1
			end	
		elseif TrinketType1 == "SelfDefensive" then
			if Unit(player):HealthPercent() <= TrinketValue1 then
				return A.Trinket1
			end	
		elseif TrinketType1 == "ManaGain" then
			if Unit(player):PowerPercent() <= TrinketValue1 then
				return A.Trinket1
			end
		end	
	end

	if A.Trinket2:IsReady(unitID) then
		if TrinketType2 == "Damage" and Player:ManaPercentage() >= 20 then
			if A.BurstIsON(unitID) and A.IsUnitEnemy(unitID) then
				return A.Trinket2
			end
		elseif TrinketType2 == "Friendly" and A.IsUnitFriendly(unitID) then
			if Unit(unitID):HealthPercent() <= TrinketValue2 then
				return A.Trinket2
			end	
		elseif TrinketType2 == "SelfDefensive" then
			if Unit(player):HealthPercent() <= TrinketValue2 then
				return A.Trinket2
			end	
		elseif TrinketType2 == "ManaGain" then
			if Unit(player):PowerPercent() <= TrinketValue2 then
				return A.Trinket2
			end
		end	
	end

end

local function EnvenomCalc()

	local base, posBuff, negBuff = UnitAttackPower(player)
	local effective = base + posBuff + negBuff
	local ComboPoints = Player:ComboPoints() or 0
	
	if A.Envenom:IsTalentLearned() then
		return A.Envenom:GetSpellDescription()[2]*ComboPoints+effective*(0.09*ComboPoints)
	else return 0
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

function TimeToSpend()
    local ssEnergy = A.SinisterStrike:GetSpellPowerCost()
    local sndEnergy = A.SliceandDice:GetSpellPowerCost()
    local eaEnergy = A.ExposeArmor:GetSpellPowerCost()
    local eEnergy = A.Eviscerate:GetSpellPowerCost()
    local rEnergy = A.Rupture:GetSpellPowerCost()
    local energyRegen = Player:EnergyRegen()
    local energy = Player:Energy()
    local energyMax = Player:EnergyMax()
    local comboPoints = Player:ComboPoints()

    local ruptureDurationRemaining = Unit("target"):HasDeBuffs(A.Rupture.ID, true)
    local sunderDurationRemaining = Unit("target"):HasDeBuffs(A.ExposeArmor.ID, true)
    local sndDurationRemaining = Unit("player"):HasBuffs(A.SliceandDice.ID, true)

    local sunderBitch = A.GetToggle(2, "sunderBitch")
    local sunderGlyph = A.GetToggle(2, "sunderGlyph")
    local sndGlyph = A.GetToggle(2, "sndGlyph")

    local timeToMaxEnergy = (energyMax - energy) / energyRegen
    local timeToReapplyRupture = (ssEnergy * 4 + rEnergy - energy) / energyRegen

    local timeToApplyEA = (ssEnergy * (sunderGlyph and 1 or 4) + eaEnergy - energy) / energyRegen
    local timeToApplySND = (ssEnergy * (sndGlyph and 1 or 2) + sndEnergy - energy) / energyRegen


	if sunderBitch and (sunderDurationRemaining < timeToApplyEA or (comboPoints >= 4 and sunderDurationRemaining < timeToMaxEnergy)) then
		return "Expose Armor"
	elseif sndDurationRemaining < timeToApplySND or (comboPoints >= 4 and sndDurationRemaining < timeToMaxEnergy) then
		return "Slice and Dice"
	elseif ruptureDurationRemaining < timeToReapplyRupture then 
		return "Rupture"
	elseif comboPoints >=4 and ruptureDurationRemaining < timeToMaxEnergy and ruptureDurationRemaining < 3 and energy >= (energyMax - 5) then
		return "Rupture Dump"
	else 
		return "Eviscerate"
	end
end

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
		if A.CloakofShadows:IsReady(player) and A.AuraIsValid("player", "UseDispel", "Vanish") then
			return A.CloakofShadows:Show(icon)
		end

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
		local useToT = A.GetToggle(2, "useToT")
		local sunderBitch = A.GetToggle(2, "sunderBitch")
		local sunderGlyph = A.GetToggle(2, "sunderGlyph")
		local sndGlyph = A.GetToggle(2, "sndGlyph")

		local decision = TimeToSpend()

		local DoInterrupt = Interrupts(unitID)
		if DoInterrupt then 
			return DoInterrupt:Show(icon)
		end

		--## MUTILATE SPEC ##
		if A.Mutilate:IsTalentLearned() then

			if Unit(unitID):HasDeBuffs(A.Sap.ID) == 0 then
		
				if A.Stealth:IsReady(player) and Unit(player):HasBuffs(A.Stealth.ID) == 0 then
					return A.Stealth:Show(icon)
				end

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
					if A.GoblinSapperCharge:IsReady(player) and BurstIsON(unitID) and A.Mutilate:IsInRange(unitID) then
						return A.Distract:Show(icon)
					end					

					local UseTrinket = UseTrinkets(unitID)
					if UseTrinket then
						return UseTrinket:Show(icon)
					end  
					
					if A.ThistleTea:IsReady(player) and BurstIsON(unitID) and Player:PrevGCD(1, A.Mutilate) then
						return A.ThistleTea:Show(icon)
					end

					if A.Shiv:IsReady(unitID) and ComboPoints == 0 then
						return A.Shiv:Show(icon)
					end

					if A.Vanish:IsReady(player) and BurstIsON(unitID) and (Unit(player):HasBuffs(A.Heroism.ID) > 0 or Unit(player):HasBuffs(A.Bloodlust.ID) > 0) and Player:EnergyDeficit() > 50 then
						return A.Vanish:Show(icon)
					end

					if A.SliceandDice:IsReady(player) and Unit(player):HasBuffs(A.SliceandDice.ID, true) < 1 then
						return A.SliceandDice:Show(icon)
					end			

					if A.Envenom:IsReady(unitID) and Unit(player):HasBuffs(A.SliceandDice.ID, true) > 0 and Unit(player):HasBuffs(A.SliceandDice.ID, true) < 5 then
						return A.Envenom:Show(icon)
					end

					if A.FanofKnives:IsReady(player) and FoKAoE then
						if A.ColdBlood:IsReady(player) and BurstIsON(unitID) and MultiUnits:GetByRange(10, 10) >= 5 then
							return A.ColdBlood:Show(icon)
						end
						return A.FanofKnives:Show(icon)
					end
	
					if A.BladeFlurry:IsReady(player) and BFAoE and (not FoKAoE and A.FanofKnives:IsTalentLearned() or not A.FanofKnives:IsTalentLearned()) then
						return A.BladeFlurry:Show(icon)
					end
	
					if A.TricksoftheTrade:IsReady(player) and Unit(focus):IsExists() and A.IsUnitFriendly(focus) and useToT then
						return A.TricksoftheTrade:Show(icon)
					end		

					if A.HungerForBlood:IsReady(player) and Unit(player):HasBuffs(A.SliceandDice.ID, true) >  3 and Unit(player):HasBuffs(A.HungerForBlood.ID) <= A.GetGCD() then
						return A.HungerForBlood:Show(icon)
					end

					if A.Rupture:IsReady(unitID) and Unit(unitID):HasDeBuffs(Temp.activeBleeds) == 0 then
						return A.Rupture:Show(icon)
					end	

					if A.ExposeArmor:IsReady(unitID) and (ComboPoints >= 1 and sunderGlyph or ComboPoints >= 4) and (decision == "Expose Armor" or Unit(unitID):HasDeBuffs(A.ExposeArmor.ID, true) < A.GetGCD()) then
						return A.ExposeArmor:Show(icon)
					end	
	
					if A.Envenom:IsReady(unitID) and ((Unit(player):HasBuffs(A.SliceandDice.ID) > 0 and ComboPoints >= 4) or Unit(unitID):Health() <= EnvenomCalc) then
						if A.ColdBlood:IsReady(player) and BurstIsON(unitID) then
							return A.ColdBlood:Show(icon)
						end
						return A.Envenom:Show(icon)
					end
					
					if A.Mutilate:IsReady(unitID) and ComboPoints < 4 then
						return A.Mutilate:Show(icon)
					end
			
				end
			end
		end


		--## COMBAT SPEC ##
		if A.AdrenalineRush:IsTalentLearned() then

			if Unit(unitID):HasDeBuffs(A.Sap.ID) == 0 then
		
				if A.Stealth:IsReady(player) and Unit(player):HasBuffs(A.Stealth.ID) == 0 then
					return A.Stealth:Show(icon)
				end

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
					if BurstIsON(unitID) and A.SinisterStrike:IsInRange(unitID) then
						if A.GoblinSapperCharge:IsReady(player) then
							return A.Distract:Show(icon)
						end
						if A.AdrenalineRush:IsReady(player) then
							return A.AdrenalineRush:Show(icon)
						end
						if A.KillingSpree:IsReady(player) then
							return A.KillingSpree:Show(icon)
						end
					end					

					local UseTrinket = UseTrinkets(unitID)
					if UseTrinket then
						return UseTrinket:Show(icon)
					end  

					if A.ThistleTea:IsReady(player) and BurstIsON(unitID) and Player:PrevGCD(1, A.Mutilate) then
						return A.ThistleTea:Show(icon)
					end

					if A.ExposeArmor:IsReady(unitID) and sunderBitch and (ComboPoints >= 1 and sunderGlyph or ComboPoints >= 4) and decision == "Expose Armor" and Unit(unitID):HasDeBuffs(A.ExposeArmor.ID, true) < A.GetGCD() then
						return A.ExposeArmor:Show(icon)
					end	

					if A.SliceandDice:IsReady(player) and (sndGlyph and ComboPoints >= 1 or ComboPoints >= 2) and decision == "Slice and Dice" and Unit(player):HasBuffs(A.SliceandDice.ID, true) == 0 then
						return A.SliceandDice:Show(icon)
					end			

					if A.FanofKnives:IsReady(player) and FoKAoE then
						if A.ColdBlood:IsReady(player) and BurstIsON(unitID) and MultiUnits:GetByRange(10, 10) >= 5 then
							return A.ColdBlood:Show(icon)
						end
						return A.FanofKnives:Show(icon)
					end
	
					if A.BladeFlurry:IsReady(player) and BFAoE and (not FoKAoE and A.FanofKnives:IsTalentLearned() or not A.FanofKnives:IsTalentLearned()) then
						return A.BladeFlurry:Show(icon)
					end
	
					if A.TricksoftheTrade:IsReady(player) and useToT then
						return A.TricksoftheTrade:Show(icon)
					end		

					if A.Rupture:IsReady(unitID) and ComboPoints >= 3 and Unit(unitID):TimeToDie() > 8 and decision == "Rupture" and (Unit(unitID):HasDeBuffs(A.Rupture.ID, true) < A.GetGCD() or decision == "Rupture Dump") then
						return A.Rupture:Show(icon)
					end	
	
					if A.Eviscerate:IsReady(unitID) and (ComboPoints >= 4 and decision == "Eviscerate" or Unit(unitID):Health() < EviscerateCalc) then			
						return A.Eviscerate:Show(icon)
					end

					if A.SinisterStrike:IsReady(unitID) and ComboPoints < 5 then
						return A.SinisterStrike:Show(icon)
					end
			
				end
			end			

		end

	end


	if A.IsUnitEnemy("target") then
		return PvERotation("target")
    end 
        
end
-- Finished

A[1] = nil

A[4] = nil

A[5] = nil

A[6] = nil

A[7] = nil

A[8] = nil
 