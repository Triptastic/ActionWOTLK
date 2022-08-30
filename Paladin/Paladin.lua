--################################
--##### TRIP'S WOTLK PALADIN #####
--################################

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
local HealingEngine                            = Action.HealingEngine

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
local nameplates                             = MultiUnits:GetActiveUnitPlates()

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
	AvengingWrath								= Create({ Type = "Spell", ID = 31884, useMaxRank = true        }),
	BlessingofKings								= Create({ Type = "Spell", ID = 20217, useMaxRank = true        }),
	BlessingofMight								= Create({ Type = "Spell", ID = 19740, useMaxRank = true        }),	
	BlessingofWisdom							= Create({ Type = "Spell", ID = 19742, useMaxRank = true        }),	
	Cleanse										= Create({ Type = "Spell", ID = 4987, useMaxRank = true        }),	
	ConcentrationAura							= Create({ Type = "Spell", ID = 19746, useMaxRank = true        }),
	Consecration								= Create({ Type = "Spell", ID = 26573, useMaxRank = true        }),	
	CrusaderAura								= Create({ Type = "Spell", ID = 32223, useMaxRank = true        }),	
	DevotionAura								= Create({ Type = "Spell", ID = 465, useMaxRank = true        }),	
	DivineIntervention							= Create({ Type = "Spell", ID = 19752, useMaxRank = true        }),	
	DivinePlea									= Create({ Type = "Spell", ID = 54428, useMaxRank = true        }),
	DivineProtection							= Create({ Type = "Spell", ID = 498, useMaxRank = true        }),
	DivineShield								= Create({ Type = "Spell", ID = 642, useMaxRank = true        }),
	Exorcism									= Create({ Type = "Spell", ID = 879, useMaxRank = true        }),
	FireResistanceAura							= Create({ Type = "Spell", ID = 19891, useMaxRank = true        }),	
	FlashofLight								= Create({ Type = "Spell", ID = 19750, useMaxRank = true        }),
	FrostResistanceAura							= Create({ Type = "Spell", ID = 19888, useMaxRank = true        }),	
	GreaterBlessingofKings						= Create({ Type = "Spell", ID = 25898, useMaxRank = true        }),	
	GreaterBlessingofMight						= Create({ Type = "Spell", ID = 25782, useMaxRank = true        }),	
	GreaterBlessingofSanctuary					= Create({ Type = "Spell", ID = 25899, useMaxRank = true        }),	
	GreaterBlessingofWisdom						= Create({ Type = "Spell", ID = 25894, useMaxRank = true        }),
	HammerofJustice								= Create({ Type = "Spell", ID = 853, useMaxRank = true        }),
	HammerofWrath								= Create({ Type = "Spell", ID = 24275, useMaxRank = true        }),	
	HandofFreedom								= Create({ Type = "Spell", ID = 1044, useMaxRank = true        }),
	HandofProtection							= Create({ Type = "Spell", ID = 1022, useMaxRank = true        }),
	HandofReckoning								= Create({ Type = "Spell", ID = 62124, useMaxRank = true        }),	
	HandofSacrifice								= Create({ Type = "Spell", ID = 6940, useMaxRank = true        }),
	HandofSalvation								= Create({ Type = "Spell", ID = 1038, useMaxRank = true        }),	
	HolyLight									= Create({ Type = "Spell", ID = 635, useMaxRank = true        }),
	HolyWrath									= Create({ Type = "Spell", ID = 2812, useMaxRank = true        }),	
	JudgmentofJustice							= Create({ Type = "Spell", ID = 53407, useMaxRank = true        }),	
	JudgmentofLight								= Create({ Type = "Spell", ID = 20271, useMaxRank = true        }),	
	JudgmentofWisdom							= Create({ Type = "Spell", ID = 53408, useMaxRank = true        }),	
	LayonHands									= Create({ Type = "Spell", ID = 633, useMaxRank = true        }),
	Purify										= Create({ Type = "Spell", ID = 1152, useMaxRank = true        }),
	Redemption									= Create({ Type = "Spell", ID = 7328, useMaxRank = true        }),	
	RetributionAura								= Create({ Type = "Spell", ID = 7294, useMaxRank = true        }),
	RighteousDefense							= Create({ Type = "Spell", ID = 31789, useMaxRank = true        }),
	RighteousFury								= Create({ Type = "Spell", ID = 25780, useMaxRank = true        }),	
	SacredShield								= Create({ Type = "Spell", ID = 53601, useMaxRank = true        }),	
	SealofCorruption							= Create({ Type = "Spell", ID = 348704, useMaxRank = true        }),	
	SealofJustice								= Create({ Type = "Spell", ID = 20164, useMaxRank = true        }),
	SealofLight									= Create({ Type = "Spell", ID = 20165, useMaxRank = true        }),	
	SealofRighteousness							= Create({ Type = "Spell", ID = 21084, useMaxRank = true        }),	
	SealofWisdom								= Create({ Type = "Spell", ID = 20166, useMaxRank = true        }),
	SealofVengeance								= Create({ Type = "Spell", ID = 31801, useMaxRank = true        }),	
	SenseUndead									= Create({ Type = "Spell", ID = 5502, useMaxRank = true        }),
	ShadowResistanceAura						= Create({ Type = "Spell", ID = 19876, useMaxRank = true        }),
	ShieldofRighteousness						= Create({ Type = "Spell", ID = 53600, useMaxRank = true        }),	
	TurnEvil									= Create({ Type = "Spell", ID = 10326, useMaxRank = true        }),
	AuraMastery									= Create({ Type = "Spell", ID = 31821, useMaxRank = true        }),	
	AvengersShield								= Create({ Type = "Spell", ID = 31935, useMaxRank = true        }),	
	BeaconofLight								= Create({ Type = "Spell", ID = 53563, useMaxRank = true        }),
	BlessingofSanctuary							= Create({ Type = "Spell", ID = 20911, useMaxRank = true        }),
	CrusaderStrike								= Create({ Type = "Spell", ID = 35395, useMaxRank = true        }),
	DivineFavor									= Create({ Type = "Spell", ID = 20216, useMaxRank = true        }),	
	DivineIllumination							= Create({ Type = "Spell", ID = 31842, useMaxRank = true        }),	
	DivineStorm									= Create({ Type = "Spell", ID = 53385, useMaxRank = true        }),
	HammeroftheRighteous						= Create({ Type = "Spell", ID = 53595, useMaxRank = true        }),	
	HolyShield									= Create({ Type = "Spell", ID = 20925, useMaxRank = true        }),
	HolyShock									= Create({ Type = "Spell", ID = 20473, useMaxRank = true        }),	
	Repentance									= Create({ Type = "Spell", ID = 20066, useMaxRank = true        }),
	SealofCommand								= Create({ Type = "Spell", ID = 20375, useMaxRank = true        }),	

    -- Potions
    MajorManaPotion                            = Create({ Type = "Potion", ID = 13444	}),
    -- Hidden Items    
    -- Note: Healthstone items created in Core.lua

	--Glyphs

	
	--Talents

	
	--ArenaChecks
    Bladestorm									= Create({ Type = "Spell", ID = 46924, useMaxRank = true,    Hidden = true }),		
    KillingSpree								= Create({ Type = "Spell", ID = 51690, useMaxRank = true,    Hidden = true }),
    CloakofShadows								= Create({ Type = "Spell", ID = 31224, useMaxRank = true,    Hidden = true }),	
    Polymorph									= Create({ Type = "Spell", ID = 118, useMaxRank = true,    Hidden = true }),	
	
	
    --Misc
    Heroism										= Create({ Type = "Spell", ID = 32182        }),
    Bloodlust									= Create({ Type = "Spell", ID = 2825        }),
    Drums										= Create({ Type = "Spell", ID = 29529        }),
    SuperHealingPotion							= Create({ Type = "Potion", ID = 22829, QueueForbidden = true }),  
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
    IsUndeadOrDemon                         = {
        ["Undead"]							= true, 
        ["Untoter"]							= true, 
        ["No-muerto"]						= true, 
        ["Mort-vivant"]						= true, 
        ["Non Morto"]						= true, 
        ["Renegado"]                        = true, 
        ["Нежить"]							= true,  
        ["언데드"]							= true,
        ["亡灵"]								= true,
        ["不死族"]							= true,
        ["Demon"]							= true,
        ["Dämon"]							= true,
        ["Demonio"]							= true,
        ["Démon"]							= true,
        ["Demone"]							= true,
        ["Demônio"]							= true,
        ["Демон"]							= true,
        ["악마"]								= true,
        ["恶魔"]								= true,
        ["惡魔"]								= true,
        [""]								= false,},
}

local ImmuneArcane = {
    [18864] = true,
    [18865] = true,
    [15691] = true,
    [20478] = true, -- Arcane Servant
}    

local RaidSubGroup = {
	group1 = {member1 = false, member2 = false, member3 = false, member4 = false, member5 = false},
	group2 = {member1 = false, member2 = false, member3 = false, member4 = false, member5 = false},
	group3 = {member1 = false, member2 = false, member3 = false, member4 = false, member5 = false},
	group4 = {member1 = false, member2 = false, member3 = false, member4 = false, member5 = false},
	group5 = {member1 = false, member2 = false, member3 = false, member4 = false, member5 = false},
}	


local function InRange(unitID)
    -- @return boolean 
    return A.JudgmentofLight:IsInRange(unitID)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(unitID, nil, nil, true)   
    if (useKick or useCC) and castRemainsTime >= GetLatency() then
		if useCC and A.HammerofJustice:IsReady(unitID) then
			return A.HammerofJustice
		end
		
	end
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function IsUndeadOrDemon(unitID)
    local unitType = UnitCreatureType(unitID) or ""
    return Temp.IsUndeadOrDemon[unitType]      
end 

local function GetInRangeValidUndeadsOrDemons(count)
    -- @return boolean     
    local c = 0 
    for unitID in pairs(nameplates) do 
        if IsUndeadOrDemon(unitID) and A.JudgmentofLight:IsInRange(unitID) then 
            c = c + 1
            
            if c >= count then 
                return true 
            end 
        end 
    end         
end

--[[local function CanDispel(unitID)
    if A.Cleanse:IsReady(unitID) then  
        if AuraIsValid(unitID, "UseDispel", "Disease") or AuraIsValid(unitID, "UseDispel", "Poison") or AuraIsValid(unitID, "UseDispel", "Magic") then 
            return A.Cleanse
        end 
    end 
    if A.Purify:IsReady(unitID) and not A.Cleanse:IsTalentLearned() then  
        if AuraIsValid(unitID, "UseDispel", "Disease") or AuraIsValid(unitID, "UseDispel", "Poison") then 
            return A.Purify
        end 
    end 
end

local function HandSpells(unitID)
    if A.HandofFreedom:IsReady(unitID, true) then  
        if AuraIsValid(unitID, "UseDispel", "BlessingofFreedom") then 
            return A.HandofFreedom
        end 
    end 
    if A.HandofProtection:IsReady(unitID, true) then  
        if AuraIsValid(unitID, "UseDispel", "BlessingofProtection") then 
            return A.HandofProtection
        end 
    end 
    if A.HandofSacrifice:IsReady(unitID, true) then  
        if AuraIsValid(unitID, "UseDispel", "BlessingofSacrifice") then 
            return A.HandofSacrifice
        end 
    end 	
end ]]

bonusHeal = GetSpellBonusHealing() -- Healing bonus

local function HealCalc(heal)

	local healamount = 0
	local globalhealmod = A.GetToggle(2, "globalhealmod")
	
	local EmpoweredHealingModGreater = A.EmpoweredHealing:GetTalentRank() * 8 / 100
	local EmpoweredHealingMod = A.EmpoweredHealing:GetTalentRank() * 4 / 100	
	local SpiritualHealingMod = A.SpiritualHealing:GetTalentRank() * 2 / 100
	local FocusedPowerMod = A.FocusedPower:GetTalentRank() * 2 / 100
	
	if heal == A.GreaterHeal then
		healamount = (A.GreaterHeal:GetSpellDescription()[2]+(1.611*bonusHeal))*(1+SpiritualHealingMod)*(1+EmpoweredHealingModGreater)*(1+FocusedPowerMod)
	elseif heal == A.FlashHeal then
		healamount = (A.FlashHeal:GetSpellDescription()[2]+(0.807*bonusHeal))*(1+SpiritualHealingMod)*(1+EmpoweredHealingMod)*(1+FocusedPowerMod)
	elseif heal == A.BindingHeal then
		healamount = (A.BindingHeal:GetSpellDescription()[2]+(0.807*bonusHeal))*(1+SpiritualHealingMod)*(1+EmpoweredHealingMod)*(1+FocusedPowerMod)
	elseif heal == A.CircleofHealing then
		healamount = (A.CircleofHealing:GetSpellDescription()[2]+(0.402*bonusHeal))*(1+SpiritualHealingMod)*(1+EmpoweredHealingMod)*(1+FocusedPowerMod)
	elseif heal == A.PrayerofHealing then
		healamount = (A.PrayerofHealing:GetSpellDescription()[2]+(0.526*bonusHeal))*(1+SpiritualHealingMod)*(1+EmpoweredHealingMod)*(1+FocusedPowerMod)
	elseif heal == A.Penance then
		healamount = ((A.Penance:GetSpellDescription()[2]+(0.526*bonusHeal))*(1+SpiritualHealingMod)*(1+EmpoweredHealingMod)*(1+FocusedPowerMod))*2
	elseif heal == A.LesserHeal then
		healamount = ((A.LesserHeal:GetSpellDescription()[2]+(0.123*bonusHeal))*(1+SpiritualHealingMod)*(1+EmpoweredHealingMod)*(1+FocusedPowerMod))
	end

	return healamount * globalhealmod

end

local function SealSelect()
	local SealChoice = A.GetToggle(2, "SealChoice")
	
	if A.SealofLight:IsReady(player) and SealChoice == "Light" then
		return A.SealofLight
	elseif A.SealofRighteousness:IsReady(player) and SealChoice == "Righteousness" then
		return A.SealofRighteousness
	elseif A.SealofWisdom:IsReady(player) and SealChoice == "Wisdom" then
		return A.SealofWisdom
	elseif A.SealofJustice:IsReady(player) and SealChoice == "Justice" then
		return A.SealofJustice
	elseif A.SealofCommand:IsReady(player) and SealChoice == "Command" then
		return A.SealofCommand	
	elseif (A.SealofVengeance:IsReady(player) or A.SealofCorruption:IsReady(player)) and SealChoice == "Vengeance" then
		return A.SealofVengeance	
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
	local AoEEnemies = A.GetToggle(2, "AoEEnemies")
	local canAoE = UseAoE and MultiUnits:GetByRange(10,10) >= AoEEnemies

	local SealActive = Unit(player):HasBuffs(A.SealofCommand.ID) > 0 or Unit(player):HasBuffs(A.SealofJustice.ID) > 0 or Unit(player):HasBuffs(A.SealofLight.ID) > 0 or Unit(player):HasBuffs(A.SealofRighteousness.ID) > 0 or Unit(player):HasBuffs(A.SealofWisdom.ID) > 0 or Unit(player):HasBuffs(A.SealofVengeance.ID) > 0 or Unit(player):HasBuffs(A.SealofCorruption.ID) > 0

	local getmembersAll = HealingEngine.GetMembersAll()	
	
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
    
    --[[if UsePotions and combatTime > 2 then
        if PotionController == "HealingPotion" then
            if CanUseHealingPotion(icon) then 
                return true
            end 
        end    
    end   ]] 
    
    --[[if CanUseManaRune(icon) then
        return true
    end]]
    
    --######################
    --##### DEFENSIVES #####
    --######################	
	
	local DivineShieldHP = A.GetToggle(2, "DivineShieldHP")
	if inCombat then
		if A.DivineShield:IsReady(player) and Unit(player):HealthPercent() <= DivineShieldHP then
			return A.DivineShield:Show(icon)
		end		
	end

	local DivineProtectionHP = A.GetToggle(2, "DivineProtectionHP")
	if inCombat then
		if A.DivineProtection:IsReady(player) and Unit(player):HealthPercent() <= DivineProtectionHP then
			return A.DivineProtection:Show(icon)
		end
	end

--[[	local DoPurge = CanDispel(unitID)
	if DoPurge then 
		return DoPurge:Show(icon)
	end

	local DoHandSpells = HandSpells(unitID)
	if DoHandSpells then 
		return DoHandSpells:Show(icon)
	end]]

	if A.HandofFreedom:IsReady(player) then
		for i = 1, #getmembersAll do 
			if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and Unit(getmembersAll[i].Unit):HasBuffs(A.HandofProtection.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.HandofFreedom.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.HandofSalvation.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.HandofSacrifice.ID) == 0 and AuraIsValid(getmembersAll[i].Unit, true, "BlessingofFreedom") then  
				HealingEngine.SetTarget(getmembersAll[i].Unit, 0.3)                                      
			end                
		end
	end 

	if A.HandofProtection:IsReady(player) then
		for i = 1, #getmembersAll do 
			if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and Unit(getmembersAll[i].Unit):HasBuffs(A.HandofProtection.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.HandofFreedom.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.HandofSalvation.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.HandofSacrifice.ID) == 0 and AuraIsValid(getmembersAll[i].Unit, true, "BlessingofProtection") then  
				HealingEngine.SetTarget(getmembersAll[i].Unit, 0.3)                                      
			end                
		end
	end 

	if A.HandofSacrifice:IsReady(player) then
		for i = 1, #getmembersAll do 
			if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and Unit(getmembersAll[i].Unit):HasBuffs(A.HandofProtection.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.HandofFreedom.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.HandofSalvation.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.HandofSacrifice.ID) == 0 and AuraIsValid(getmembersAll[i].Unit, true, "BlessingofSacrifice") then  
				HealingEngine.SetTarget(getmembersAll[i].Unit, 0.3)                                      
			end                
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

	--BUFFS
	local CastSeal = SealSelect()
	if not SealActive then
		if CastSeal then
			return CastSeal:Show(icon)
		end
	end

	
 ------------------------------------------------------------------------------------------------

    local function EnemyRotation(unitID)

        local npcID = select(6, Unit(unitID):InfoGUID())		
		local SpecSelect = A.GetToggle(2, "SpecSelect")

		local DoInterrupt = Interrupts(unitID)
		if DoInterrupt then 
			return DoInterrupt:Show(icon)
        end

		if inCombat and BurstIsON(unitID) then	
			if A.BloodFury:IsReady(player) then
				return A.BloodFury:Show(icon)
			end
			
			if A.Berserking:IsReady(player) then
				return A.Berserking:Show(icon)
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
		
		if not canAoE then
			if A.CrusaderStrike:IsReady(unitID) then
				return A.CrusaderStrike:Show(icon)
			end
			
			if A.JudgmentofWisdom:IsReady(unitID) then
				return A.JudgmentofWisdom:Show(icon)
			end
			
			if A.JudgmentofLight:IsReady(unitID) then
				return A.JudgmentofLight:Show(icon)
			end
			
			if A.DivineStorm:IsReady(player) and A.CrusaderStrike:IsInRange() then
				return A.DivineStorm:Show(icon)
			end
			
			if A.Consecration:IsReady(player) and Unit(unitID):GetRange() <= 5 then
				return A.Consecration:Show(icon)
			end
			
			if A.Exorcism:IsReady(unitID) and not isMoving then
				return A.Exorcism:Show(icon)
			end
			
			if A.HolyWrath:IsReady(player) and GetInRangeValidUndeadsOrDemons(1) then
				return A.HolyWrath:Show(icon)
			end
		
		end
		
		if canAoE then
			if A.Consecration:IsReady(player) and Unit(unitID):GetRange() <= 5 and not isMoving then
				return A.Consecration:Show(icon)
			end
		
			if A.DivineStorm:IsReady(player) and A.CrusaderStrike:IsInRange() then
				return A.DivineStorm:Show(icon)
			end

			if A.JudgmentofWisdom:IsReady(unitID) then
				return A.JudgmentofWisdom:Show(icon)
			end
			
			if A.JudgmentofLight:IsReady(unitID) then
				return A.JudgmentofLight:Show(icon)
			end

			if A.HolyWrath:IsReady(player) and GetInRangeValidUndeadsOrDemons(AoEEnemies) then
				return A.HolyWrath:Show(icon)
			end

			if A.CrusaderStrike:IsReady(unitID) then
				return A.CrusaderStrike:Show(icon)
			end

			if A.Exorcism:IsReady(unitID) and not isMoving then
				return A.Exorcism:Show(icon)
			end
		
		end
		
	end
    
 --------------------------------------------------------------------------------------------------    
	local function HealingRotation(unitID) 
	
        local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)	
        local unitGUID = UnitGUID(unitID)    	
		local DungeonGroup = TeamCache.Friendly.Size >= 2 and TeamCache.Friendly.Size <= 5
		local RaidGroup = TeamCache.Friendly.Size >= 5 	
			
		local Cleanse = A.GetToggle(2, "Cleanse")

		--[[Emergency Healing
		local Emergency = Unit(unitID):HealthPercent() > 0 and Unit(unitID):TimeToDie() <= (A.GetGCD() + A.GetCurrentGCD() + (TMW.UPD_INTV or 0) + GetPing()) and Unit(unitID):HealthPercentLosePerSecond() > (Unit(unitID):HealthPercentGainPerSecond() + Unit(unitID):Health())	
		if Emergency then
			if A.FlashHeal:IsReady(unitID) then
				return A.FlashHeal:Show(icon)
			end
		end

		--Penance
		if A.Penance:IsReady(unitID) and canCast then
			if PenanceHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.Penance) then
					return A.Penance:Show(icon)
				end
			elseif Unit(unitID):HealthPercent() <= PenanceHP then
				return A.Penance:Show(icon)
			end
		end]]

		
	end

---------------------------------------------------------------------------------------------------
	
	if A.IsUnitFriendly("focus") then
		return HealingRotation("focus")
    elseif A.IsUnitFriendly("target") then
        return HealingRotation("target")
	elseif A.IsUnitEnemy("target") then 
        return EnemyRotation("target")
    end 
        
end

A[1] = nil

A[4] = nil

A[5] = nil


local function PartyRotation(icon, unitID)

end

local function ArenaRotation(icon, unitID)


end

A[6] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end 
    
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    local Party = PartyRotation("party3") 
    if Party then 
        return Party:Show(icon)
    end 
    
    return ArenaRotation(icon, "arena3")
end