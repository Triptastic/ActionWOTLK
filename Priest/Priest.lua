--###############################
--##### TRIP'S WOTLK PRIEST #####
--###############################

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
	WilltoSurvive								= Create({ Type = "Spell", ID = 59752		}),		
	
	--Class Skills
	AbolishDisease								= Create({ Type = "Spell", ID = 552, useMaxRank = true        }),
	BindingHeal									= Create({ Type = "Spell", ID = 32546, useMaxRank = true        }),	
	CureDisease									= Create({ Type = "Spell", ID = 528, useMaxRank = true        }),
	DevouringPlague								= Create({ Type = "Spell", ID = 2944, useMaxRank = true        }),	
	DispelMagic									= Create({ Type = "Spell", ID = 527, useMaxRank = true        }),
	DivineHymn									= Create({ Type = "Spell", ID = 64843, useMaxRank = true        }),	
	DivineSpirit								= Create({ Type = "Spell", ID = 14752, useMaxRank = true        }),	
	Fade										= Create({ Type = "Spell", ID = 586, useMaxRank = true        }),
	FearWard									= Create({ Type = "Spell", ID = 6346, useMaxRank = true        }),
	FlashHeal									= Create({ Type = "Spell", ID = 2061, useMaxRank = true        }),	
	GreaterHeal									= Create({ Type = "Spell", ID = 2060, useMaxRank = true        }),
	Heal										= Create({ Type = "Spell", ID = 2054, useMaxRank = true        }),	
	HolyFire									= Create({ Type = "Spell", ID = 14914, useMaxRank = true        }),	
	HolyNova									= Create({ Type = "Spell", ID = 15237, useMaxRank = true        }),	
	HymnofHope									= Create({ Type = "Spell", ID = 64901, useMaxRank = true        }),
	InnerFire									= Create({ Type = "Spell", ID = 588, useMaxRank = true        }),
	LesserHeal									= Create({ Type = "Spell", ID = 2050, useMaxRank = true        }),
	Levitate									= Create({ Type = "Spell", ID = 1706, useMaxRank = true        }),
	ManaBurn									= Create({ Type = "Spell", ID = 8129, useMaxRank = true        }),
	MassDispel									= Create({ Type = "Spell", ID = 32375, useMaxRank = true        }),
	MindBlast									= Create({ Type = "Spell", ID = 8092, useMaxRank = true        }),
	MindControl									= Create({ Type = "Spell", ID = 605, useMaxRank = true        }),
	MindFlay									= Create({ Type = "Spell", ID = 15407, useMaxRank = true        }),	
	MindSear									= Create({ Type = "Spell", ID = 48045, useMaxRank = true        }),
	MindSoothe									= Create({ Type = "Spell", ID = 453, useMaxRank = true        }),	
	MindVision									= Create({ Type = "Spell", ID = 2096, useMaxRank = true        }),
	PowerWordFortitude							= Create({ Type = "Spell", ID = 1243, useMaxRank = true        }),
	PowerWordShield								= Create({ Type = "Spell", ID = 17, useMaxRank = true        }),
	PrayerofFortitude							= Create({ Type = "Spell", ID = 21562, useMaxRank = true        }),
	PrayerofHealing								= Create({ Type = "Spell", ID = 596, useMaxRank = true        }),
	PrayerofMending								= Create({ Type = "Spell", ID = 33076, useMaxRank = true        }),			
	PrayerofShadowProtection					= Create({ Type = "Spell", ID = 27683, useMaxRank = true        }),
	PrayerofSpirit								= Create({ Type = "Spell", ID = 27681, useMaxRank = true        }),
	PsychicScream								= Create({ Type = "Spell", ID = 8122, useMaxRank = true        }),
	Renew										= Create({ Type = "Spell", ID = 139, useMaxRank = true        }),
	Resurrection								= Create({ Type = "Spell", ID = 2006, useMaxRank = true        }),
	ShackleUndead								= Create({ Type = "Spell", ID = 9484, useMaxRank = true        }),	
	ShadowProtection							= Create({ Type = "Spell", ID = 976, useMaxRank = true        }),
	ShadowWordDeath								= Create({ Type = "Spell", ID = 32379, useMaxRank = true        }),	
	ShadowWordPain								= Create({ Type = "Spell", ID = 589, useMaxRank = true        }),
	Shadowfiend									= Create({ Type = "Spell", ID = 34433, useMaxRank = true        }),	
	Shadowform									= Create({ Type = "Spell", ID = 15473, useMaxRank = true        }),	
	Smite										= Create({ Type = "Spell", ID = 585, useMaxRank = true        }),
	GuardianSpirit								= Create({ Type = "Spell", ID = 47788, useMaxRank = true        }),
	InnerFocus									= Create({ Type = "Spell", ID = 14751, useMaxRank = true        }),	
	Lightwell									= Create({ Type = "Spell", ID = 724, useMaxRank = true        }),
	PainSuppression								= Create({ Type = "Spell", ID = 33206, useMaxRank = true        }),
	Penance										= Create({ Type = "Spell", ID = 47540, useMaxRank = true        }),
	PowerInfusion								= Create({ Type = "Spell", ID = 10060, useMaxRank = true        }),	
	PsychicHorror								= Create({ Type = "Spell", ID = 64044, useMaxRank = true        }),
	Silence										= Create({ Type = "Spell", ID = 15487, useMaxRank = true        }),	
	VampiricEmbrace								= Create({ Type = "Spell", ID = 15286, useMaxRank = true        }),	
	VampiricTouch								= Create({ Type = "Spell", ID = 34914, useMaxRank = true        }),	
	Dispersion									= Create({ Type = "Spell", ID = 47585, useMaxRank = true        }),	
	CircleofHealing								= Create({ Type = "Spell", ID = 34861, useMaxRank = true        }),	
	DesperatePrayer								= Create({ Type = "Spell", ID = 19236, useMaxRank = true       }),	
	WeakenedSoul								= Create({ Type = "Spell", ID = 6788, useMaxRank = true, Hidden = true        }),	
    -- Potions
    MajorManaPotion                            = Create({ Type = "Potion", ID = 13444	}),
    -- Hidden Items    
    -- Note: Healthstone items created in Core.lua

	--Glyphs

	
	--Talents
	ShadowWeaving								= Create({ Type = "Spell", ID = 15258, Hidden = true       }),	
    Darkness		                            = Create({ Type = "Spell", ID = 15259,    isTalent = true, useMaxRank = true,    Hidden = true }),
    TwinDisciplines	                            = Create({ Type = "Spell", ID = 47586,    isTalent = true, useMaxRank = true,    Hidden = true }),	
    SerendipityTalent							= Create({ Type = "Spell", ID = 63737,    isTalent = true, useMaxRank = true,    Hidden = true }),
	SerendipityBuff	                            = Create({ Type = "Spell", ID = 63734,    Hidden = true }),
    EmpoweredHealing							= Create({ Type = "Spell", ID = 33158,    isTalent = true, useMaxRank = true,    Hidden = true }),	
    SpiritualHealing							= Create({ Type = "Spell", ID = 14898,    isTalent = true, useMaxRank = true,    Hidden = true }),	
    SoulWarding									= Create({ Type = "Spell", ID = 63574,    isTalent = true, useMaxRank = true,    Hidden = true }),
    FocusedPower								= Create({ Type = "Spell", ID = 33186,    isTalent = true, useMaxRank = true,    Hidden = true }),	
    SurgeofLight								= Create({ Type = "Spell", ID = 33150,    isTalent = true, useMaxRank = true,    Hidden = true }),	
    ImprovedShadowform							= Create({ Type = "Spell", ID = 47570,    isTalent = true, useMaxRank = true,    Hidden = true }),	
	
	--ArenaChecks
    Bladestorm									= Create({ Type = "Spell", ID = 46924, useMaxRank = true,    Hidden = true }),		
    KillingSpree								= Create({ Type = "Spell", ID = 51690, useMaxRank = true,    Hidden = true }),
    CloakofShadows								= Create({ Type = "Spell", ID = 31224, useMaxRank = true,    Hidden = true }),	
    Polymorph									= Create({ Type = "Spell", ID = 118, useMaxRank = true,    Hidden = true }),	
	
	
    --Misc
    Heroism										= Create({ Type = "Spell", ID = 32182, Hidden = true        }),
    Bloodlust									= Create({ Type = "Spell", ID = 2825, Hidden = true        }),
    Drums										= Create({ Type = "Spell", ID = 29529, Hidden = true        }),
    SuperHealingPotion							= Create({ Type = "Potion", ID = 22829, QueueForbidden = true }),
	BearForm									= Create({ Type = "Spell", ID = 5487, useMaxRank = true         }),
	DireBearForm								= Create({ Type = "Spell", ID = 9634, useMaxRank = true         }),
	FelIntelligence								= Create({ Type = "Spell", ID = 57567, useMaxRank = true         }),
	KirusSongofVictory							= Create({ Type = "Spell", ID = 46302, Hidden = true        }),
	DazeBehind									= Create({ Type = "Spell", ID = 1604, Hidden = true        }),	
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
	VampiricTouchDelay						= 0,
}

local function IsSchoolShadowUP()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function IsSchoolHolyUP()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "HOLY") == 0
end 

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
    return A.ShadowWordPain:IsInRange(unitID)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(unitID, nil, nil, true)   
    if (useKick or useCC) and castRemainsTime >= GetLatency() then
		if useKick and A.Silence:IsReady(unitID) and not notInterruptable then
			return A.Silence
		end

		if useCC and A.PsychicHorror:IsReady(unitID) then
			return A.PsychicHorror
		end

		if useCC and A.PsychicScream:IsReady(player) and Unit(unitID):GetRange() <= 7 then
			return A.PsychicScream
		end
	end
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function CanDispel(unitID, isFriendly)
    -- @return boolean 
    -- Note: Only [3] APL
    if A.DispelMagic:IsReady(unitID, true) then 
        if isFriendly then 
            if (AuraIsValid(unitID, "UseDispel", "Magic") or AuraIsValid(unitID, "UsePurge", "PurgeFriendly")) then 
                return A.DispelMagic
            end 
        else 
            if (AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow")) then 
                return A.DispelMagic
            end 
        end 
    end 
end 

spellDmg = GetSpellBonusDamage(6) --Shadow bonus damage
bonusHeal = GetSpellBonusHealing() -- Healing bonus

local function SWDeathDmgCalc()--Add glyph bonus when implemented

	local TwinDisciplinesDmg = A.TwinDisciplines:GetTalentRank() * 1 / 100
	local ShadowWeavingDmg = Unit(player):HasBuffsStacks(A.ShadowWeaving.ID) * 2 / 100
	local DarknessDmg = A.Darkness:GetTalentRank() * 2 / 100
	
	return (A.ShadowWordDeath:GetSpellDescription()[2]+(0.429*spellDmg))*(1+TwinDisciplinesDmg)*(1+ShadowWeavingDmg)*(1+DarknessDmg)
	
end

--[[Wait for mana (reference only)
local playerGUID = UnitGUID("player")
local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
	self:COMBAT_LOG_EVENT_UNFILTERED(CombatLogGetCurrentEventInfo())
end)

function f:COMBAT_LOG_EVENT_UNFILTERED(...)
	local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
	local spellId, spellName, spellSchool

	if subevent == "SPELL_CAST_SUCCESS" then
		spellId, spellName, spellSchool = select(12, ...)
	end

	if spellId and sourceGUID == playerGUID then
		if TMW.time - timestamp >= (5 - A.GetToggle(2, "waitforregentime")) and <= 5 then
			--show pooling icon here
		end
	end
end]]

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

local function MeleeInGroup()
	local getmembersAll = HealingEngine.GetMembersAll()
	local total = 0
	for i = 1, #getmembersAll do 
	    if Unit(getmembersAll[i].Unit):IsMelee() then
            total = total + 1
        end
	end
    return total
end

local function PoHCheckR1()
	local PrayerofHealingHP = A.GetToggle(2, "PrayerofHealingHP")
	
	if (Unit("raid1"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid1"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group1.member1 = true else RaidSubGroup.group1.member1 = false
	end
	if (Unit("raid2"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid2"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group1.member2 = true else RaidSubGroup.group1.member2 = false
	end	
	if (Unit("raid3"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid3"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group1.member3 = true else RaidSubGroup.group1.member3 = false
	end	
	if (Unit("raid4"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid4"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group1.member4 = true else RaidSubGroup.group1.member4 = false
	end	
	if (Unit("raid5"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid5"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group1.member5 = true else RaidSubGroup.group1.member5 = false
	end

	local count = 0
	for i, v in pairs(RaidSubGroup.group1) do
		if v == true then
			count = count + 1
		end
	end

	return count

end

local function PoHCheckR2()
	local PrayerofHealingHP = A.GetToggle(2, "PrayerofHealingHP")
	
	if (Unit("raid6"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid6"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group2.member1 = true else RaidSubGroup.group2.member1 = false
	end
	if (Unit("raid7"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid7"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group2.member2 = true else RaidSubGroup.group2.member2 = false
	end	
	if (Unit("raid8"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid8"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group2.member3 = true else RaidSubGroup.group2.member3 = false
	end	
	if (Unit("raid9"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid9"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group2.member4 = true else RaidSubGroup.group2.member4 = false
	end	
	if (Unit("raid10"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid10"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group2.member5 = true else RaidSubGroup.group2.member5 = false
	end

	local count = 0
	for i, v in pairs(RaidSubGroup.group2) do
		if v == true then
			count = count + 1
		end
	end

	return count

end

local function PoHCheckR3()
	local PrayerofHealingHP = A.GetToggle(2, "PrayerofHealingHP")
	
	if (Unit("raid11"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid11"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group3.member1 = true else RaidSubGroup.group3.member1 = false
	end
	if (Unit("raid12"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid12"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group3.member2 = true else RaidSubGroup.group3.member2 = false
	end	
	if (Unit("raid13"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid13"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group3.member3 = true else RaidSubGroup.group3.member3 = false
	end	
	if (Unit("raid14"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid14"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group3.member4 = true else RaidSubGroup.group3.member4 = false
	end	
	if (Unit("raid15"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid15"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group3.member5 = true else RaidSubGroup.group3.member5 = false
	end

	local count = 0
	for i, v in pairs(RaidSubGroup.group3) do
		if v == true then
			count = count + 1
		end
	end

	return count

end

local function PoHCheckR4()
	local PrayerofHealingHP = A.GetToggle(2, "PrayerofHealingHP")
	
	if (Unit("raid16"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid16"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group4.member1 = true else RaidSubGroup.group4.member1 = false
	end
	if (Unit("raid17"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid17"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group4.member2 = true else RaidSubGroup.group4.member2 = false
	end	
	if (Unit("raid18"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid18"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group4.member3 = true else RaidSubGroup.group4.member3 = false
	end	
	if (Unit("raid19"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid19"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group4.member4 = true else RaidSubGroup.group4.member4 = false
	end	
	if (Unit("raid20"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid20"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group4.member5 = true else RaidSubGroup.group4.member5 = false
	end

	local count = 0
	for i, v in pairs(RaidSubGroup.group4) do
		if v == true then
			count = count + 1
		end
	end

	return count

end

local function PoHCheckR5()
	local PrayerofHealingHP = A.GetToggle(2, "PrayerofHealingHP")
	
	if (Unit("raid21"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid21"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group5.member1 = true else RaidSubGroup.group5.member1 = false
	end
	if (Unit("raid22"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid22"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group5.member2 = true else RaidSubGroup.group5.member2 = false
	end	
	if (Unit("raid23"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid23"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group5.member3 = true else RaidSubGroup.group5.member3 = false
	end	
	if (Unit("raid24"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid24"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group5.member4 = true else RaidSubGroup.group5.member4 = false
	end	
	if (Unit("raid25"):HealthDeficit() >= HealCalc(A.PrayerofHealing) and PrayerofHealingHP >= 100) or (Unit("raid25"):HealthPercent() <= PrayerofHealingHP and PrayerofHealingHP <= 99) then
		RaidSubGroup.group5.member5 = true else RaidSubGroup.group5.member5 = false
	end

	local count = 0
	for i, v in pairs(RaidSubGroup.group5) do
		if v == true then
			count = count + 1
		end
	end

	return count

end

local function ImmuneFear(unitID)
	
	return Unit(unitID):HasBuffs({
	
		50397, --Lichborne
		45438, --Ice Block
		642, --Divine Shield
		18499, --Berserker Rage
		48707, --Anti-Magic Shell
	
	}) > 0
end

local function DisarmCheck(unitID)
	
	return Unit(unitID):HasBuffs({
	
		46924, -- Bladestorm
		51690, -- Killing Spree
	
	}) > 0
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
	
	local DesperatePrayerHP = A.GetToggle(2, "DesperatePrayerHP")
	if inCombat then
		if A.DesperatePrayer:IsReady(player) and Unit(player):HealthPercent() <= DesperatePrayerHP then
			return A.DesperatePrayer:Show(icon)
		end		
	end

	local DispersionHP = A.GetToggle(2, "DispersionHP")
	if inCombat then
		if A.Dispersion:IsReady(player) and Unit(player):HealthPercent() <= DispersionHP then
			return A.Dispersion:Show(icon)
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
	if A.VampiricEmbrace:IsReady(player) and Unit(player):HasBuffs(A.VampiricEmbrace.ID, true) == 0 then
		return A.VampiricEmbrace:Show(icon)
	end

	if A.InnerFire:IsReady(player) and Unit(player):HasBuffs(A.InnerFire.ID, true) == 0 then
		return A.InnerFire:Show(icon)
	end		
	
	if A.PowerWordFortitude:IsReady(player) and Unit(player):HasBuffs( A.PrayerofFortitude.ID) == 0 and Unit(player):HasBuffs(A.PowerWordFortitude.ID) == 0 and Unit(player):HasBuffs( A.KirusSongofVictory.ID) == 0 and (unitID == player or unitID == nil) then
		return A.PowerWordFortitude:Show(icon)
	end
	if A.PowerWordFortitude:IsReady(target) and Unit(target):HasBuffs(A.PrayerofFortitude.ID) == 0 and Unit(target):HasBuffs(A.PowerWordFortitude.ID) == 0 and Unit(target):HasBuffs( A.KirusSongofVictory.ID) == 0 and not inCombat and not Unit(target):IsNPC() then
		return A.PowerWordFortitude:Show(icon)
	end	

	if A.DivineSpirit:IsReady(target) and Unit(target):HasBuffs(A.DivineSpirit.ID) == 0 and Unit(target):HasBuffs(A.PrayerofSpirit.ID) == 0 and Unit(target):HasBuffs(A.FelIntelligence.ID) == 0 and not inCombat and not Unit(target):IsNPC() then
		return A.DivineSpirit:Show(icon)
	end		
	
	if A.Fade:IsReady(player) and A.ImprovedShadowform:IsTalentLearned() and Unit(player):HasBuffs(A.Shadowform.ID) > 0 and (LoC:Get("STUN") > 1 or (not inRange and (LoC:Get("ROOT") > 1 or (LoC:Get("SNARE") > 0 and Unit(player):GetMaxSpeed() <= 50)))) and Unit(player):HasDeBuffs(A.DazeBehind.ID) == 0 then
		return A.Fade:Show(icon)
	end
	
	if A.WilltoSurvive:IsReady(player) and LoC:Get("STUN") > 1 then
		return A.WilltoSurvive:Show(icon)
	end

	
 ------------------------------------------------------------------------------------------------

    local function EnemyRotation(unitID)

        local npcID = select(6, Unit(unitID):InfoGUID())		
		local SpecSelect = A.GetToggle(2, "SpecSelect")
    
		local SWPActive = Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID, true) > 0
		local VampiricTouchActive = Unit(unitID):HasDeBuffs(A.VampiricTouch.ID, true) > A.VampiricTouch:GetSpellCastTime()
		local DevouringPlagueRefresh = Player:GetDeBuffsUnitCount(A.DevouringPlague.ID, true) < 1 and Player:Mana() >= A.DevouringPlague:GetSpellPowerCost()
		local DoTMissing = (not SWPActive and Player:Mana() >= A.ShadowWordPain:GetSpellPowerCost()) or (not VampiricTouchActive and Player:Mana() >= A.VampiricTouch:GetSpellPowerCost()) or DevouringPlagueRefresh

		local isShadowSpec = A.Shadowform:IsTalentLearned()

		--VampTouch DoubleCast fix
		if Temp.VampiricTouchDelay == 0 and Player:IsCasting() == A.VampiricTouch:Info() then
			Temp.VampiricTouchDelay = 60
		end
		
		
		if Temp.VampiricTouchDelay > 0 then
			Temp.VampiricTouchDelay = Temp.VampiricTouchDelay - 1
		end	

		local ShadowfiendMana = A.GetToggle(2, "ShadowfiendMana")
		if A.Shadowfiend:IsReady(unitID) and inCombat and Player:ManaPercentage() <= ShadowfiendMana then
			return A.Shadowfiend:Show(icon)
		end

		if A.IsInPvP or A.Zone == "pvp" or A.Zone == "arena" then
			
			--STOPCAST
			if Unit(unitID):HasBuffs(23920) > 0 then --Spell Reflection
				A.Toaster:SpawnByTimer("TripToast", 0, "Spell Reflection!", "Using Mind Soothe to counter Spell Reflection!", 23920)
				if A.GetToggle(1, "StopCast") and Player:IsCasting() then
					return A:Show(icon, ACTION_CONST_STOPCAST)
				end
				return A.MindSoothe:Show(icon)
			end			
			
			if A.PsychicScream:IsReady(player) then
				local namePlateUnitID
				for namePlateUnitID in pairs(ActiveUnitPlates) do                 
					if Unit(namePlateUnitID):IsPlayer() and not Unit(namePlateUnitID):IsNPC() and not Unit(namePlateUnitID):IsTotem() and A.IsUnitEnemy(namePlateUnitID) and Unit(namePlateUnitID):GetRange() > 0 and Unit(namePlateUnitID):GetRange() <= 8 then 
						return A.PsychicScream:Show(icon)
					end 
				end

				if Unit(unitID):GetRange() <= 8 and not ImmuneFear(unitID) then
					return A.PsychicScream:Show(icon)
				end
			end
			
			if A.PsychicHorror:IsReady(unitID) and DisarmCheck(unitID) then
				return A.PsychicHorror:Show(icon)
			end
			
			if A.Renew:IsReady(player) and isShadowSpec and Unit(player):HasBuffs(A.Shadowform.ID) == 0 and Unit(player):HealthPercent() <= 90 and Unit(player):HasBuffs(A.Renew.ID, true) == 0 then
				return A.Renew:Show(icon)
			end
			
			if A.Shadowform:IsReady(player) and Unit(player):HasBuffs(A.Shadowform.ID) == 0 and DoTMissing then
				return A.Shadowform:Show(icon)
			end			

			if A.ShadowWordDeath:IsReady(unitID) and Unit(unitID):Health() < SWDeathDmgCalc() and Unit(player):Health() > SWDeathDmgCalc() and A.IsUnitEnemy(unitID) then
				return A.ShadowWordDeath:Show(icon)
			end

			local DPSHEAL = A.GetToggle(2, "DPSHEAL")
			if (Player:ManaPercentage() > DPSHEAL and TeamCache.Friendly.Size >= 2) or not Unit(player):InParty() or isShadowSpec then

				if A.VampiricTouch:IsReady(unitID) and not isMoving and not VampiricTouchActive and Temp.VampiricTouchDelay == 0 then
					return A.VampiricTouch:Show(icon)
				end	

				if A.HolyFire:IsReady(unitID) and not isMoving and (Unit(player):HasBuffs(A.Shadowform.ID) == 0 or not IsSchoolShadowUP()) then
					return A.HolyFire:Show(icon)
				end

				if A.ShadowWordPain:IsReady(unitID) and not SWPActive then
					return A.ShadowWordPain:Show(icon)
				end			
		
				if A.DevouringPlague:IsReady(unitID) and DevouringPlagueRefresh then
					return A.ShadowWeaving:Show(icon)
				end	
				
				if A.MindBlast:IsReady(unitID) and not isMoving then
					return A.MindBlast:Show(icon)
				end	

				if A.MindFlay:IsReady(unitID) and not isMoving and A.MindBlast:GetCooldown() > 1 then
					return A.MindFlay:Show(icon)
				end	

				if A.Smite:IsReady(unitID) and not isMoving and (Unit(player):HasBuffs(A.Shadowform.ID, true) == 0 or not IsSchoolShadowUP()) then
					return A.Smite:Show(icon)
				end
			end
			
			if A.HolyNova:IsReady(player) then
				local namePlateUnitID
				for namePlateUnitID in pairs(ActiveUnitPlates) do                 
					if Unit(namePlateUnitID):IsPlayer() and A.IsUnitEnemy(namePlateUnitID) and Unit(namePlateUnitID):GetRange() > 0 and Unit(namePlateUnitID):GetRange() <= 8 and Unit(player):Health() > Unit(namePlateUnitID):Health() then 
						return A.HolyNova:Show(icon)
					end 
				end
			end
			
		end 
		
		if not A.IsInPvP then
			--STOPCAST
			if A.GetToggle(1, "StopCast") and Player:IsChanneling() == A.MindFlay:Info() then
				if DoTMissing and A.VampiricTouch:IsTalentLearned() and Unit(player):HasBuffsStacks(A.ShadowWeaving.ID, true) >= 5 then 
					return A:Show(icon, ACTION_CONST_STOPCAST)
				end
				
				if A.ShadowWordDeath:IsReadyByPassCastGCD(unitID) and Unit(unitID):Health() < SWDeathDmgCalc() and Unit(player):Health() > SWDeathDmgCalc() then
					return A:Show(icon, ACTION_CONST_STOPCAST)
				end				
			end

			local DoInterrupt = Interrupts(unitID)
			if DoInterrupt then 
				return DoInterrupt:Show(icon)
			end

			local DoPurge = CanDispel(unitID, isFriendly)
			if DoPurge then 
				return DoPurge:Show(icon)
			end
		
			if A.Shadowform:IsReady(player) and Unit(player):HasBuffs(A.Shadowform.ID) == 0 then
				return A.Shadowform:Show(icon)
			end

			if A.PowerWordShield:IsReady(player) and Unit(player):HasBuffs(A.PowerWordShield.ID) == 0 and Unit(player):HasDeBuffs(A.WeakenedSoul.ID) == 0 then
				if GetNumGroupMembers() == 0 then
					return A.PowerWordShield:Show(icon)
				end
			end

			if not inCombat then
				if Unit(player):HasBuffs(A.Shadowform.ID) == 0 then
					if A.HolyFire:IsReady(unitID) then
						return A.HolyFire:Show(icon)
					end
				elseif Unit(player):HasBuffs(A.Shadowform.ID) > 0 then
					if A.VampiricTouch:IsReady(unitID) and not VampiricTouchActive and Temp.VampiricTouchDelay == 0 then
						return A.VampiricTouch:Show(icon)
					elseif A.MindBlast:IsReady(unitID) then
						return A.MindBlast:Show(icon)
					end
				end
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
			
			local NovaMana = A.GetToggle(2, "NovaMana")
			if A.HolyNova:IsReady(player) and UseAoE and Player:ManaPercentage() > NovaMana and MultiUnits:GetByRange(10, 5) >= 4 and Unit(player):HasBuffs(A.Shadowform.ID) == 0 then
				return A.HolyNova:Show(icon)
			end
			
			local DPSHEAL = A.GetToggle(2, "DPSHEAL")
			if (Player:ManaPercentage() > DPSHEAL and TeamCache.Friendly.Size >= 2) or not Unit(player):InParty() or isShadowSpec then
				if A.ShadowWordDeath:IsReady(unitID) and Unit(unitID):Health() < SWDeathDmgCalc() and Unit(player):Health() > SWDeathDmgCalc() then
					return A.ShadowWordDeath:Show(icon)
				end
				
				if A.HolyFire:IsReady(unitID) and not isMoving and (Unit(player):HasBuffs(A.Shadowform.ID) == 0 or not IsSchoolShadowUP()) then
					return A.HolyFire:Show(icon)
				end
				
				--SWP only with Shadow Weavingx5
				if A.ShadowWordPain:IsReady(unitID) and not SWPActive and ((Unit(player):HasBuffsStacks(A.ShadowWeaving.ID, true) >= 5 and A.VampiricTouch:IsTalentLearned()) or not A.VampiricTouch:IsTalentLearned()) then
					return A.ShadowWordPain:Show(icon)
				end
				
				if A.VampiricTouch:IsReady(unitID) and not isMoving and not VampiricTouchActive and Temp.VampiricTouchDelay == 0 then
					return A.VampiricTouch:Show(icon)
				end
				
				if A.DevouringPlague:IsReady(unitID) and DevouringPlagueRefresh then
					return A.ShadowWeaving:Show(icon)
				end
				
				if A.MindBlast:IsReady(unitID) and not isMoving then
					return A.MindBlast:Show(icon)
				end
				
				local MindSearTargets = A.GetToggle(2, "MindSearTargets")
				if A.MindSear:IsReady(unitID) and not isMoving and MultiUnits:GetActiveEnemies(36, 10) >= MindSearTargets then
					return A.MindSear:Show(icon)
				end
				
				if A.MindFlay:IsReady(unitID) and not isMoving and A.MindBlast:GetCooldown() > 1 then
					return A.MindFlay:Show(icon)
				end
				
				if A.Smite:IsReady(unitID) and not isMoving and (Unit(player):HasBuffs(A.Shadowform.ID, true) == 0 or not IsSchoolShadowUP()) then
					return A.Smite:Show(icon)
				end
				
				local SWDMoving = A.GetToggle(2, "SWDMoving")
				if A.ShadowWordDeath:IsReady(unitID) and SWDMoving and isMoving and Unit(player):Health() > SWDeathDmgCalc() then
					return A.ShadowWordDeath:Show(icon)
				end
				
				local DPMoving = A.GetToggle(2, "DPMoving")		
				if A.DevouringPlague:IsReady(unitID) and DPMoving then
					return A.ShadowWeaving:Show(icon)
				end		
			end
		end
	
	end
    
 --------------------------------------------------------------------------------------------------    
	local function HealingRotation(unitID) 
	
        local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
		local getmembersAll = HealingEngine.GetMembersAll()		
        local unitGUID = UnitGUID(unitID)    	
		local DungeonGroup = TeamCache.Friendly.Size >= 2 and TeamCache.Friendly.Size <= 5
		local RaidGroup = TeamCache.Friendly.Size >= 5 	
		
		local localizedClass, englishClass, classIndex = UnitClass(unitID)		
			
		local Cleanse = A.GetToggle(2, "Cleanse")
		local GreaterHealHP = A.GetToggle(2, "GreaterHealHP")
		local FlashHealHP = A.GetToggle(2, "FlashHealHP")	
		local BindingHealHP = A.GetToggle(2, "BindingHealHP")
		local PrayerofHealingHP = A.GetToggle(2, "PrayerofHealingHP")
		local PrayerofHealingUnits = A.GetToggle(2, "PrayerofHealingUnits")
		local CircleofHealingHP = A.GetToggle(2, "CircleofHealingHP")
		local BlanketRenew = A.GetToggle(2, "BlanketRenew")	
		local RenewHP = A.GetToggle(2, "RenewHP")
		local PenanceHP = A.GetToggle(2, "PenanceHP")		
		local LesserHealHP = A.GetToggle(2, "LesserHealHP")		
		
		--[[if canCast and Player:IsStaying() and HealingEngine.GetBelowHealthPercentUnits(DivineHymnHP, 30) > DivineHymnTargets then
			if A.InnerFocus:IsReady(player) then
				return A.InnerFocus:Show(icon)
			end		
			if A.DivineHymn:IsReady(player) then
			A.Toaster:SpawnByTimer("TripToast", 0, "Divine Hymn!", "Using Divine Hymn! Stop moving!", A.DivineHymn.ID)				
				return A.DivineHymn:Show(icon)
			end
		
		end]]

		--Emergency Healing
		local Emergency = Unit(unitID):HealthPercent() > 0 and Unit(unitID):HealthPercent() < 25 and inCombat
		if Emergency then
			if A.GuardianSpirit:IsReady(unitID) then
				return A.GuardianSpirit:Show(icon)
			end
			if A.CircleofHealing:IsReady(unitID) then
				return A.CircleofHealing:Show(icon)
			end
			if A.PowerWordShield:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.WeakenedSoul.ID) == 0 then
				return A.PowerWordShield:Show(icon)
			end
			if A.PainSuppression:IsReady(unitID) then
				return A.PainSuppression:Show(icon)
			end
			if A.FlashHeal:IsReady(unitID) and not isMoving then
				return A.FlashHeal:Show(icon)
			end
		end

		--PrayerofHealing
		local isR1target = UnitIsUnit(unitID, "raid1") or UnitIsUnit(unitID, "raid2") or UnitIsUnit(unitID, "raid3") or UnitIsUnit(unitID, "raid4") or UnitIsUnit(unitID, "raid5")
		local isR2target = UnitIsUnit(unitID, "raid6") or UnitIsUnit(unitID, "raid7") or UnitIsUnit(unitID, "raid8") or UnitIsUnit(unitID, "raid9") or UnitIsUnit(unitID, "raid10")
		local isR3target = UnitIsUnit(unitID, "raid11") or UnitIsUnit(unitID, "raid12") or UnitIsUnit(unitID, "raid13") or UnitIsUnit(unitID, "raid14") or UnitIsUnit(unitID, "raid15")
		local isR4target = UnitIsUnit(unitID, "raid16") or UnitIsUnit(unitID, "raid17") or UnitIsUnit(unitID, "raid18") or UnitIsUnit(unitID, "raid19") or UnitIsUnit(unitID, "raid20")
		local isR5target = UnitIsUnit(unitID, "raid21") or UnitIsUnit(unitID, "raid22") or UnitIsUnit(unitID, "raid23") or UnitIsUnit(unitID, "raid24") or UnitIsUnit(unitID, "raid25")		
	
		if A.PrayerofHealing:IsReady(unitID) and not isMoving and canCast then
			if (isR1target and PoHCheckR1() >= PrayerofHealingUnits) or (isR2target and PoHCheckR2() >= PrayerofHealingUnits) or (isR3target and PoHCheckR3() >= PrayerofHealingUnits) or (isR4target and PoHCheckR4() >= PrayerofHealingUnits) or (isR5target and PoHCheckR5() >= PrayerofHealingUnits) then
				if A.InnerFocus:IsReady(player) then
					return A.InnerFocus:Show(icon)
				end
				return A.PrayerofHealing:Show(icon)
			end
		end

		--Penance
		if A.Penance:IsReady(unitID) and canCast and not isMoving then
			if PenanceHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.Penance) then
					return A.Penance:Show(icon)
				end
			elseif Unit(unitID):HealthPercent() <= PenanceHP then
				return A.Penance:Show(icon)
			end
		end

		--CircleofHealing
		if A.CircleofHealing:IsReady(unitID) and canCast and (Unit(unitID):InParty() or Unit(unitID):InRaid()) then
			if CircleofHealingHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.CircleofHealing) then
					return A.CircleofHealing:Show(icon)
				end
			elseif Unit(unitID):HealthPercent() <= CircleofHealingHP then
				return A.CircleofHealing:Show(icon)
			end
		end
	
		--Cleansing
		if (A.AbolishDisease:IsReady(unitID) or A.CureDisease:IsReady(unitID)) and Cleanse then
			for i = 1, #getmembersAll do 
				if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and AuraIsValid(getmembersAll[i].Unit, "UseDispel", "Disease") and Unit(getmembersAll[i].Unit):HasBuffs(A.AbolishDisease.ID) == 0 then
					HealingEngine.SetTarget(getmembersAll[i].Unit, 0.3)   
					return A.AbolishDisease:Show(icon)
				end                
			end
		end	

		--GreaterHeal
		if A.GreaterHeal:IsReady(unitID) and not isMoving and canCast and (Unit(player):HasBuffsStacks(A.SerendipityBuff.ID, true) >= 3 or not A.SerendipityTalent:IsTalentLearned()) then
			if GreaterHealHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.GreaterHeal) then
					return A.GreaterHeal:Show(icon)
				end
			elseif GreaterHealHP <= 99 then
				if Unit(unitID):HealthPercent() <= GreaterHealHP then
					return A.GreaterHeal:Show(icon)
				end
			end
		end

		--BindingHeal
		if A.BindingHeal:IsReady(unitID) and not isMoving and canCast and not UnitIsUnit(unitID, player) then
			if BindingHealHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.BindingHeal) and Unit(player):HealthDeficit() >= (HealCalc(A.BindingHeal) * 0.75) then
					return A.BindingHeal:Show(icon)
				end
			elseif BindingHealHP <= 99 then
				if Unit(unitID):HealthPercent() <= BindingHealHP and Unit(player):HealthPercent() <= (BindingHealHP * 0.75) then
					return A.BindingHeal:Show(icon)
				end
			end
		end

		--FlashHeal
		if A.FlashHeal:IsReady(unitID) and not isMoving and canCast then
			if FlashHealHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.FlashHeal) and Unit(player):HasBuffsStacks(A.SerendipityBuff.ID, true) <= 2 then
					return A.FlashHeal:Show(icon)
				end
			elseif FlashHealHP <= 99 then
				if Unit(unitID):HealthPercent() <= FlashHealHP then
					return A.FlashHeal:Show(icon)
				end
			end
		end

		--Need to PWS blanket. Player can use macro to block PWS when wanting to mana save? Need brainstorm here.
		local BlanketPWS = A.GetToggle(2, "BlanketPWS")				
		if A.PowerWordShield:IsReady(unitID) and BlanketPWS and A.SoulWarding:IsTalentLearned() then
			for i = 1, #getmembersAll do 
				local _, blanketClass, _ = UnitClass(getmembersAll[i].Unit)			
				if Unit(getmembersAll[i].Unit):IsPlayer() and not IsUnitEnemy(getmembersAll[i].Unit) and Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HasBuffs(A.PowerWordShield.ID, true) == 0  and Unit(getmembersAll[i].Unit):HasDeBuffs(A.WeakenedSoul.ID, true) == 0 and blanketClass ~= "WARRIOR" then 
					if UnitGUID(getmembersAll[i].Unit) ~= currGUID then
						HealingEngine.SetTarget(getmembersAll[i].Unit, 0.3) 
					end    
				end                
			end 
			if Unit(unitID):HasBuffs(A.PowerWordShield.ID) == 0 and Unit(unitID):HasDeBuffs(A.WeakenedSoul.ID) == 0 then
				--if englishClass == "WARRIOR" or Unit(unitID):HasBuffs(A.BearForm.ID) > 0 or Unit(unitID):HasBuffs(A.DireBearForm.ID) > 0 then return
				if englishClass ~= "WARRIOR" and Unit(unitID):HasBuffs(A.DireBearForm.ID) == 0 and Unit(unitID):HasBuffs(A.BearForm.ID) == 0 then 
					return A.PowerWordShield:Show(icon)
				end
			end
		end

		--PrayerofMending
		local status = UnitThreatSituation(unitID)		
		if A.PrayerofMending:IsReady(unitID) and (Unit(unitID):IsTanking() or Unit(unitID):IsTank() or status == 3) and HealingEngine.GetBuffsCount(A.PrayerofMending.ID, 0, player) == 0 then 
			return A.PrayerofMending:Show(icon)
		end

		--Renew + blanket option
		if A.Renew:IsReady(unitID) and canCast and inCombat then
			if Unit(unitID):IsTanking() and Unit(unitID):HasBuffs(A.Renew.ID, true) == 0 then
				return A.Renew:Show(icon)
			end
			if BlanketRenew then
				for i = 1, #getmembersAll do 
					if Unit(getmembersAll[i].Unit):IsPlayer() and not IsUnitEnemy(getmembersAll[i].Unit) and Unit(getmembersAll[i].Unit):HealthPercent() < 95 and A.Renew:IsReady(getmembersAll[i].Unit) and Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HasBuffs(A.Renew.ID, true) == 0 then 
						if UnitGUID(getmembersAll[i].Unit) ~= currGUID then
							HealingEngine.SetTarget(getmembersAll[i].Unit, 0.3)      
						end    
					end                
				end 
				if Unit(unitID):HasBuffs(A.Renew.ID, true) == 0 then
					return A.Renew:Show(icon)
				end
			end
			if not BlanketRenew then
				if Unit(unitID):HealthPercent() < RenewHP and Unit(unitID):HasBuffs(A.Renew.ID, true) == 0 then 
					return A.Renew:Show(icon)
				end
			end
		end

		--LesserHeal
		if A.LesserHeal:IsReady(unitID) and not isMoving and canCast then
			if LesserHealHP >= 100 then
				if Unit(unitID):HealthDeficit() >= HealCalc(A.LesserHeal) then
					return A.LesserHeal:Show(icon)
				end
			elseif LesserHealHP <= 99 then
				if Unit(unitID):HealthPercent() <= LesserHealHP then
					return A.LesserHeal:Show(icon)
				end
			end
		end		

		if A.PowerWordShield:IsReady(unitID) and Unit(unitID):HasBuffs(A.PowerWordShield.ID) == 0 and Unit(unitID):HasDeBuffs(A.WeakenedSoul.ID) == 0 then
			if englishClass ~= "WARRIOR" and Unit(unitID):HasBuffs(A.BearForm.ID) == 0 and Unit(unitID):HasBuffs(A.DireBearForm.ID) == 0 then 
				return A.PowerWordShield:Show(icon)
			end
		end		
		
	end

---------------------------------------------------------------------------------------------------
	local HealingStyle = A.GetToggle(2, "HealingStyle")
	
	if A.IsUnitFriendly(focus) then 
		unitID = focus 
		if HealingRotation(unitID) then 
			return true 
		end 
	end
	if A.IsUnitFriendly(target) then 
		unitID = target 
		if HealingRotation(unitID) then 
			return true 
		end 
	end      
	if A.IsUnitEnemy(target) then 
		unitID = target 
		if EnemyRotation(unitID) then 
			return true 
		end 
	end
	   
end

A[1] = nil

A[4] = nil

A[5] = nil


local function PartyRotation(icon, unitID)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then 

		if A.DispelMagic:IsReady(unitID, true) then 
			if (AuraIsValid(unitID, "UseDispel", "Magic") or AuraIsValid(unitID, "UsePurge", "PurgeFriendly")) then 
				return A.DispelMagic
			end 
		end
		if A.AbolishDisease:IsReady(unitID, true) then
			if AuraIsValid(unitID, "UseDispel", "Disease") then
				return A.AbolishDisease
			end
		end
	end
		
end

local function ArenaRotation(icon, unitID)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then     
		
		--Add Silence on heal spell if team bursting
		
		--Disarm targets
		if A.PsychicHorror:IsReady(unitID) then 
			if Unit(unitID):HasBuffs(A.Bladestorm.ID or A.KillingSpree.ID) > 0 or (Unit(unitID):Class("Hunter") and Unit("party1" or "party2" or "party3"):HealthPercent() <= 50) then
				return A.PsychicHorror
			end
		end
		
	end
end
--[[
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
end]]