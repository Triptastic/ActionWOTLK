--##############################
--##### TRIP'S WOTLK DRUID #####
--##############################

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
	Shadowmeld									= Create({ Type = "Spell", ID = 58984        }),
	WarStomp									= Create({ Type = "Spell", ID = 20549        }),
	
	--Class Skills
	AbolishPoison								= Create({ Type = "Spell", ID = 2893, useMaxRank = true        }),
	AcquaticForm								= Create({ Type = "Spell", ID = 1066, useMaxRank = true         }),
	Barkskin									= Create({ Type = "Spell", ID = 22812, useMaxRank = true         }),
	Bash										= Create({ Type = "Spell", ID = 5211, useMaxRank = true         }),
	BearForm									= Create({ Type = "Spell", ID = 5487, useMaxRank = true         }),
	Berserk										= Create({ Type = "Spell", ID = 50334, useMaxRank = true         }),
	CatForm										= Create({ Type = "Spell", ID = 768, useMaxRank = true         }),
	ChallengingRoar								= Create({ Type = "Spell", ID = 5209, useMaxRank = true         }),
	Claw										= Create({ Type = "Spell", ID = 1082, useMaxRank = true         }),
	Clearcasting								= Create({ Type = "Spell", ID = 16870, useMaxRank = true         }),	
	Cower										= Create({ Type = "Spell", ID = 8998, useMaxRank = true         }),	
	CurePoison									= Create({ Type = "Spell", ID = 8946, useMaxRank = true         }),
	Cyclone										= Create({ Type = "Spell", ID = 33786, useMaxRank = true         }),
	Dash										= Create({ Type = "Spell", ID = 1850, useMaxRank = true         }),
	DemoralizingRoar							= Create({ Type = "Spell", ID = 99, useMaxRank = true 	        }),
	DireBearForm								= Create({ Type = "Spell", ID = 9634, useMaxRank = true         }),
	Enrage										= Create({ Type = "Spell", ID = 5229, useMaxRank = true         }),	
	EntanglingRoots								= Create({ Type = "Spell", ID = 19975, useMaxRank = true         }),
	FaerieFire									= Create({ Type = "Spell", ID = 770, useMaxRank = true         }),
	FaerieFireFeral								= Create({ Type = "Spell", ID = 16857, useMaxRank = true        }),
	FeralChargeBear								= Create({ Type = "Spell", ID = 16979, useMaxRank = true         }),
	FeralChargeCat								= Create({ Type = "Spell", ID = 49376, useMaxRank = true         }),
	FerociousBite								= Create({ Type = "Spell", ID = 22568, useMaxRank = true         }),
	FrenziedRegeneration						= Create({ Type = "Spell", ID = 22842, useMaxRank = true         }),
	GiftoftheWild								= Create({ Type = "Spell", ID = 21849, useMaxRank = true         }),
	Growl										= Create({ Type = "Spell", ID = 6795, useMaxRank = true         }),
	HealingTouch								= Create({ Type = "Spell", ID = 5185, useMaxRank = true         }),
	Hibernate									= Create({ Type = "Spell", ID = 2637, useMaxRank = true         }),
	Hurricane									= Create({ Type = "Spell", ID = 16914, useMaxRank = true         }),
	Innervate									= Create({ Type = "Spell", ID = 29166, useMaxRank = true         }),
	InsectSwarm									= Create({ Type = "Spell", ID = 5570, useMaxRank = true         }),
	Lacerate									= Create({ Type = "Spell", ID = 33745, useMaxRank = true         }),
	Lifebloom									= Create({ Type = "Spell", ID = 33763, useMaxRank = true         }),
	Maim										= Create({ Type = "Spell", ID = 22570, useMaxRank = true         }),
	MangleBear									= Create({ Type = "Spell", ID = 33878, useMaxRank = true         }),
	MangleCat									= Create({ Type = "Spell", ID = 33876, useMaxRank = true         }),
	MarkoftheWild								= Create({ Type = "Spell", ID = 5234, useMaxRank = true         }),
	Maul										= Create({ Type = "Spell", ID = 6807, useMaxRank = true         }),
	Moonfire									= Create({ Type = "Spell", ID = 8921, useMaxRank = true         }),
	NaturesGrasp								= Create({ Type = "Spell", ID = 16689, useMaxRank = true         }),
	Nourish										= Create({ Type = "Spell", ID = 50464, useMaxRank = true         }),
	Pounce										= Create({ Type = "Spell", ID = 9005, useMaxRank = true         }),
	PrimalFury									= Create({ Type = "Spell", ID = 16958, useMaxRank = true         }),
	Prowl										= Create({ Type = "Spell", ID = 5215, useMaxRank = true         }),
	Rake										= Create({ Type = "Spell", ID = 1822, useMaxRank = true         }),
	Ravage										= Create({ Type = "Spell", ID = 6785, useMaxRank = true         }),
	Rebirth										= Create({ Type = "Spell", ID = 20484, useMaxRank = true         }),
	Regrowth									= Create({ Type = "Spell", ID = 8936, useMaxRank = true         }),
	Rejuvenation								= Create({ Type = "Spell", ID = 8070, useMaxRank = true         }),
	RemoveCurse									= Create({ Type = "Spell", ID = 2782, useMaxRank = true         }),
	Revive										= Create({ Type = "Spell", ID = 50769, useMaxRank = true         }),
	Rip											= Create({ Type = "Spell", ID = 1079, useMaxRank = true         }),	
	SavageRoar									= Create({ Type = "Spell", ID = 52610, useMaxRank = true         }),
	Shred										= Create({ Type = "Spell", ID = 5221, useMaxRank = true         }),
	SootheAnimal								= Create({ Type = "Spell", ID = 2908, useMaxRank = true         }),
	Starfall									= Create({ Type = "Spell", ID = 48505, useMaxRank = true         }),
	Starfire									= Create({ Type = "Spell", ID = 2912, useMaxRank = true         }),
	SwiftFlightForm								= Create({ Type = "Spell", ID = 40120, useMaxRank = true         }),	
	SwipeBear									= Create({ Type = "Spell", ID = 779, useMaxRank = true         }),
	SwipeCat									= Create({ Type = "Spell", ID = 62078, useMaxRank = true         }),
	Thorns										= Create({ Type = "Spell", ID = 467, useMaxRank = true         }),
	TigersFury									= Create({ Type = "Spell", ID = 5217, useMaxRank = true         }),
	Tranquility									= Create({ Type = "Spell", ID = 740, useMaxRank = true         }),
	TravelForm									= Create({ Type = "Spell", ID = 783, useMaxRank = true         }),
	TreeofLife									= Create({ Type = "Spell", ID = 33891, useMaxRank = true         }),
	Typhoon										= Create({ Type = "Spell", ID = 50516, useMaxRank = true         }),
	WildGrowth									= Create({ Type = "Spell", ID = 48438, useMaxRank = true         }),
	Wrath										= Create({ Type = "Spell", ID = 5176, useMaxRank = true        }),

	--Glyphs
	GlyphofAquaticForm							= Create({ Type = "Glyph", ID = 58140        }),
	GlyphofBarkskin								= Create({ Type = "Glyph", ID = 63740        }),
	GlyphofBerserk								= Create({ Type = "Glyph", ID = 63714        }),
	GlyphofChallengingRoar						= Create({ Type = "Glyph", ID = 58158        }),
	GlyphofClaw									= Create({ Type = "Glyph", ID = 67599        }),
	GlyphofDash									= Create({ Type = "Glyph", ID = 59218        }),
	GlyphofEntanglingRoots						= Create({ Type = "Glyph", ID = 54877        }),
	GlyphofFocus								= Create({ Type = "Glyph", ID = 62161        }),
	GlyphofFrenziedRegeneration					= Create({ Type = "Glyph", ID = 54854        }),
	GlyphofGrowl								= Create({ Type = "Glyph", ID = 54856        }),
	GlyphofHealingTouch							= Create({ Type = "Glyph", ID = 54869        }),
	GlyphofHurricane							= Create({ Type = "Glyph", ID = 54873        }),
	GlyphofInnervate							= Create({ Type = "Glyph", ID = 54865        }),
	GlyphofInsectSwarm							= Create({ Type = "Glyph", ID = 54872        }),
	GlyphofLifebloom							= Create({ Type = "Glyph", ID = 54870        }),
	GlyphofMangle								= Create({ Type = "Glyph", ID = 54857        }),
	GlyphofMaul									= Create({ Type = "Glyph", ID = 54858        }),
	GlyphofMonsoon								= Create({ Type = "Glyph", ID = 63739        }),
	GlyphofMoonfire								= Create({ Type = "Glyph", ID = 54876        }),
	GlyphofNourish								= Create({ Type = "Glyph", ID = 63717        }),
	GlyphofRake									= Create({ Type = "Glyph", ID = 54863        }),
	GlyphofRapidRejuvenation					= Create({ Type = "Glyph", ID = 71014        }),
	GlyphofRip									= Create({ Type = "Glyph", ID = 54860        }),
	GlyphofSavageRoar							= Create({ Type = "Glyph", ID = 63718        }),
	GlyphofShred								= Create({ Type = "Glyph", ID = 54859        }),
	GlyphofStarfall								= Create({ Type = "Glyph", ID = 54874        }),
	GlyphofStarfire								= Create({ Type = "Glyph", ID = 54871        }),
	GlyphofSurvivalInstincts					= Create({ Type = "Glyph", ID = 65244        }),
	GlyphofSwiftmend							= Create({ Type = "Glyph", ID = 54864        }),
	GlyphoftheWild								= Create({ Type = "Glyph", ID = 58159        }),
	GlyphofThorns								= Create({ Type = "Glyph", ID = 58163        }),
	GlyphofTyphoon								= Create({ Type = "Glyph", ID = 62134        }),
	GlyphofUnburdenedRebirth					= Create({ Type = "Glyph", ID = 58161        }),
	GlyphofWildGrowth							= Create({ Type = "Glyph", ID = 63715        }),
	GlyphofWrath								= Create({ Type = "Glyph", ID = 54875        }),	
	
	--Talents
	Eclipse										= Create({ Type = "Spell", ID = 48516, isTalent = true, useMaxRank = true,    Hidden = true         }),
	EclipseLunar								= Create({ Type = "Spell", ID = 48518, isTalent = true, useMaxRank = true,    Hidden = true         }),
	EclipseSolar								= Create({ Type = "Spell", ID = 48517, isTalent = true, useMaxRank = true,    Hidden = true         }),
	FeralAggression								= Create({ Type = "Spell", ID = 16858, isTalent = true, useMaxRank = true,    Hidden = true         }),
	ForceofNature								= Create({ Type = "Spell", ID = 33831, isTalent = true, useMaxRank = true,    Hidden = true         }),
	Furor										= Create({ Type = "Spell", ID = 17056, isTalent = true, useMaxRank = true,    Hidden = true         }),		
	MoonkinForm									= Create({ Type = "Spell", ID = 24858, isTalent = true, useMaxRank = true,    Hidden = true         }),
	NaturesSwiftness							= Create({ Type = "Spell", ID = 17116, isTalent = true, useMaxRank = true,    Hidden = true         }),
	OmenofClarity								= Create({ Type = "Spell", ID = 16864, isTalent = true, useMaxRank = true,    Hidden = true         }),
	PrimalFury									= Create({ Type = "Spell", ID = 37116, isTalent = true, useMaxRank = true,    Hidden = true         }),	
	SurvivalInstincts							= Create({ Type = "Spell", ID = 61336, isTalent = true, useMaxRank = true,    Hidden = true         }),	
	Swiftmend									= Create({ Type = "Spell", ID = 18562, isTalent = true, useMaxRank = true,    Hidden = true         }),	
	
    --Misc
    Heroism										= Create({ Type = "Spell", ID = 32182        }),
    Bloodlust									= Create({ Type = "Spell", ID = 2825        }),
    Drums										= Create({ Type = "Spell", ID = 29529        }),
    SuperHealingPotion							= Create({ Type = "Potion", ID = 22829, QueueForbidden = true }),
    Trauma										= Create({ Type = "Spell", ID = 46854        }),	
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
	OpenerRotation							= false,
	UsedReshift								= false,
	BearWeavingShift						= false,
	EclipseSolar							= true,
}

local ImmuneArcane = {
    [18864] = true,
    [18865] = true,
    [15691] = true,
    [20478] = true, -- Arcane Servant
}    

local function AtRange(unitID)
    -- @return boolean 
    return A.Moonfire:IsInRange(unitID)
end 
AtRange = A.MakeFunctionCachedDynamic(AtRange)

local function InMelee(UnitID)
    -- @return boolean 
    return A.Bash:IsInRange(UnitID)
end 
InMelee = A.MakeFunctionCachedDynamic(InMelee)

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end  

    local BarkskinHP = A.GetToggle(2, "BarkskinHP")
    if A.Barkskin:IsReady(player) and Unit(player):HealthPercent() <= BarkskinHP then
        return A.Barkskin
    end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unitID)
	local ChargeBash = A.GetToggle(2, "ChargeBash")
	local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(unitID, "Main", nil, true)   
    local inCombat = Unit(player):CombatTime() > 0
	
	if useCC then
	
		if ChargeBash and Player:Mana() > (A.DireBearForm:GetSpellPowerCost() + A.CatForm:GetSpellPowerCost()) then
			if A.FeralChargeCat:IsReady(unitID) and not InMelee() and not Player:IsStealthed() and Unit(player):HasBuffs(A.CatForm.ID) > 0 and A.Furor:GetTalentRank() >= 5 and (A.Bash:GetCooldown() <= A.GetGCD() or not inCombat) then
				return A.FeralChargeBear
			end
			
			if A.FeralChargeBear:GetCooldown() == 0 and not InMelee() and ((not Player:IsStance(1) and A.Furor:GetTalentRank() >= 5) or Player:IsStance(1)) and A.Bash:GetCooldown() <= A.GetGCD() then
				return A.FeralChargeBear
			end
			
			if A.Prowl:IsReady(player) and not inCombat and not Player:IsStealthed() and A.FeralChargeCat:GetCooldown() > 0 then
				return A.Prowl
			end
			
			if A.Pounce:IsReady(unitID) then
				return A.Pounce
			end
		end
		
		if A.Bash:GetCooldown() == 0 and not A.Bash:IsBlocked() then
			if Player:IsStance(1) then
				return A.Bash
			elseif not Player:IsStance(1) and castRemainsTime >= A.GetGCD() and A.Furor:GetTalentRank() >= 5 then 
				return A.Bash
			end
		end 
		
	end
   
    if useRacial and A.WarStomp:AutoRacial(unitID) then 
        return A.WarStomp
    end    
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)


local function FerociousBiteDamage()
	local base, posBuff, negBuff = UnitAttackPower(player)
    local effective = (base or 0) + (posBuff or 0) + (negBuff or 0)
	local combopoint = Player:ComboPoints()
	local FeralAggressionDmg = A.FeralAggression:GetTalentRank() * 3 / 100
	local GlobalDamage = A.GetToggle(2, "GlobalDamage")
    
	if A.FerociousBite:GetSpellRank() == 0 then
		return 0
	elseif A.FerociousBite:GetSpellRank() == 1 then
		return 14+36*combopoint+(0.07*combopoint)*effective*(1+FeralAggressionDmg)*GlobalDamage
	elseif A.FerociousBite:GetSpellRank() == 2 then
		return 20+59*combopoint+(0.07*combopoint)*effective*(1+FeralAggressionDmg)*GlobalDamage
	elseif A.FerociousBite:GetSpellRank() == 3 then
		return 30+92*combopoint+(0.07*combopoint)*effective*(1+FeralAggressionDmg)*GlobalDamage
	elseif A.FerociousBite:GetSpellRank() == 4 then
		return 45+128*combopoint+(0.07*combopoint)*effective*(1+FeralAggressionDmg)*GlobalDamage
	elseif A.FerociousBite:GetSpellRank() == 5 then
		return 52+147*combopoint+(0.07*combopoint)*effective*(1+FeralAggressionDmg)*GlobalDamage
	elseif A.FerociousBite:GetSpellRank() == 6 then
		return 57+169*combopoint+(0.07*combopoint)*effective*(1+FeralAggressionDmg)*GlobalDamage
	elseif A.FerociousBite:GetSpellRank() == 7 then
		return 98+236*combopoint+(0.07*combopoint)*effective*(1+FeralAggressionDmg)*GlobalDamage
	elseif A.FerociousBite:GetSpellRank() == 8 then
		return 120+290*combopoint+(0.07*combopoint)*effective*(1+FeralAggressionDmg)*GlobalDamage		
    end 
end

local function SpenderCPFinal()

	local SpenderCP = A.GetToggle(2, "SpenderCP")

	if SpenderCP > 5 then
		if A.PrimalFury:GetTalentRank() >= 2 then
			return 4
		end
	end
	
	return SpenderCP

end


--################
--### TRINKETS ###
--################
local function UseTrinkets(unitID)
	local TrinketType1 = A.GetToggle(2, "TrinketType1")
	local TrinketType2 = A.GetToggle(2, "TrinketType2")
	local TrinketValue1 = A.GetToggle(2, "TrinketValue1")
	local TrinketValue2 = A.GetToggle(2, "TrinketValue2")	

	if A.Trinket1:IsReady(unitID) then
		if TrinketType1 == "Damage" then
			if A.BurstIsON(unitID) and A.IsUnitEnemy(unitID) and A.LightningBolt:IsInRange() then
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
		if TrinketType2 == "Damage" then
			if A.BurstIsON(unitID) and A.IsUnitEnemy(unitID) and A.LightningBolt:IsInRange() then
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
    
    --[[if CanUseManaRune(icon) then
        return true
    end]]
    
    --######################
    --##### DEFENSIVES #####
    --######################	
	
	local DefensivesHP = A.GetToggle(2, "DefensivesHP")
	if inCombat then
		if A.SurvivalInstincts:IsReady(player) and Unit(player):HealthPercent() <= DefensivesHP then
			return A.SurvivalInstincts:Show(icon)
		end
		
		if A.FrenziedRegeneration:IsReady(player) and Unit(player):HealthPercent() <= DefensivesHP and Player:IsStance(1) then
			return A.FrenziedRegeneration:Show(icon)
		end
	end
    
    --###############
    --##### OOC #####
    --###############    

	if A.MarkoftheWild:IsReady(target) and Unit(target):HasBuffs(A.MarkoftheWild.ID) == 0 and Unit(target):HasBuffs(A.GiftoftheWild.ID) == 0 and not inCombat and not Unit(target):IsNPC() and not Unit(target):IsTotem() then
		return A.MarkoftheWild:Show(icon)
	end	
	
	if A.Thorns:IsReady(target) and Unit(target):HasBuffs(A.Thorns.ID) == 0 and not inCombat and not Unit(target):IsNPC() and not Unit(target):IsTotem() then
		return A.Thorns:Show(icon)
	end	

	local AutoForm = A.GetToggle(2, "AutoForm")

	--BearWeaving FailSafe
	local BearWeaving = A.GetToggle(2, "BearWeaving")
	if BearWeaving and (Player:Energy() >= 70 or Unit(target):HasDeBuffs(A.Rip.ID, true) <= 3) then
		Temp.BearWeavingShift = false
	end
	
	if BearWeaving and Player:Energy() < 40 and Unit(player):HasBuffs(A.Clearcasting.ID) == 0 and Unit(target):HasDeBuffs(A.Rip.ID, true) > 3.5 and Unit(player):HasBuffs(A.Berserk.ID) == 0 and not BearFormActive and Player:Mana() > (A.DireBearForm:GetSpellPowerCost() + A.CatForm:GetSpellPowerCost()) then
		Temp.BearWeavingShift = true
	end

	if A.DireBearForm:IsReady(player) and Unit(player):HasDeBuffs("Rooted") >= 3 and not Temp.UsedReshift then
		Temp.UsedReshift = true
		return A.DireBearForm:Show(icon)
	end 
	
	if AutoForm == "CatForm" and A.CatForm:IsReady(player) and (Player:IsStance(0) or (Player:IsStance(1) and Temp.UsedReshift)) and not Temp.BearWeavingShift then
		Temp.UsedReshift = false
		return A.CatForm:Show(icon)
	end 	

	if AutoForm == "MoonkinForm" and A.MoonkinForm:IsReady(player) and (Player:IsStance(0) or Player:IsStance(2) or (Player:IsStance(1) and Temp.UsedReshift)) then
		Temp.UsedReshift = false	
		return A.MoonkinForm:Show(icon)
	end 
	
	if AutoForm == "BearForm" and (A.BearForm:IsReady(player) or A.DireBearForm:IsReady(player)) and not Player:IsStance(1) then	
		return A.BearForm:Show(icon)
	end

	if AutoForm == "BearForm" and (A.BearForm:IsReady(player) or A.DireBearForm:IsReady(player)) and not Player:IsStance(1) then	
		return A.DireBearForm:Show(icon)
	end 	
	
	local InnervatePercent = A.GetToggle(2, "InnervatePercent")
	if A.Innervate:IsReady(player) and inCombat and Player:ManaPercentage() < InnervatePercent then
		return A.Innervate:Show(icon)
	end
	
	if A.SavageRoar:IsSpellLearned() then
		if A.Berserk:IsReady(player) and A.TigersFury:IsReady(player) then
			Temp.OpenerRotation = true
		end
	end	
	
	if not A.Berserk:IsReady(player) or not A.TigersFury:IsReady(player) then
		Temp.OpenerRotation = false
	end	
    
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unitID)

	
        local npcID = select(6, Unit(unitID):InfoGUID())		
		local SpecSelect = A.GetToggle(2, "SpecSelect")
		local isMoving = Player:IsMoving()
		
		local BearFormActive = Player:IsStance(1)
		local FaerieFireMissing = Unit(unitID):HasDeBuffs(A.FaerieFireFeral.ID) == 0 and Unit(unitID):HasDeBuffs(A.FaerieFire.ID) == 0
		local Pooling = (Unit(unitID):HasDeBuffs(A.Rake.ID, true) < 3 and Player:Energy() < 45) or (Unit(unitID):HasDeBuffs(A.Rake.ID, true) < 2 and Player:Energy() < 55) or (Unit(unitID):HasDeBuffs(A.Rake.ID, true) < 1 and Player:Energy() < 65)
		local BleedMissing = Unit(unitID):HasDeBuffs(A.Rake.ID, true) == 0 or Unit(unitID):HasDeBuffs(A.Rip.ID, true) == 0
		local SpenderCP = SpenderCPFinal()
		
		local DoInterrupt = Interrupts(unitID)
		if DoInterrupt then 
			return DoInterrupt:Show(icon)
		end

		local UseTrinket = UseTrinkets(unitID)
		if UseTrinket then
			return UseTrinket:Show(icon)
		end

        -- Defensive
        local SelfDefensive = SelfDefensives()
        if SelfDefensive then 
            return SelfDefensive:Show(icon)
        end 

		--BALANCE
		if SpecSelect == "Balance" or SpecSelect == "Restoration" or (SpecSelect == "Auto" and (Player:IsStance(0) or Player:IsStance(4))) then
			
			if A.MoonkinForm:IsReady(player) and Unit(player):HasBuffs(A.MoonkinForm.ID, true) == 0 and AutoForm == "MoonkinForm" then
				return A.MoonkinForm:Show(icon)
			end
		
			--Maintain Faerie Fire.
			if A.FaerieFire:IsReady(unitID) and FaerieFireMissing then
				return A.FaerieFire:Show(icon)
			end
			
			--Starfall on CD (toggle option).
			local StarfallAoE = A.GetToggle(2, "StarfallAoE")
			if A.Starfall:IsReady(player) and UseAoE and canCast and AtRange() and (StarfallAoE and (MultiUnits:GetByRangeInCombat(36, 3) >= 3 or Unit(unitID):IsBoss()) or not StarfallAoE) then
				return A.Starfall:Show(icon)
			end
			
			--Force of Nature on CD (cooldown toggle).
			if A.ForceofNature:IsReady(player) and A.BurstIsON(unitID) and AtRange() then
				return A.ForceofNature:Show(icon)
			end
			
			--If no Insect Swarm/Moonfire, Insect Swarm during Solar, Moonfire during Lunar.
			if A.InsectSwarm:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.InsectSwarm.ID, true) < A.GetGCD() then
				if Unit(player):HasBuffs(A.EclipseLunar, true) == 0 then
					return A.InsectSwarm:Show(icon)
				end
			end
			
			if A.Moonfire:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Moonfire.ID, true) < A.GetGCD() then
				if Unit(player):HasBuffs(A.EclipseSolar, true) == 0 then
					return A.Moonfire:Show(icon)
				end
			end			
			
			--Wrath if Eclipse (Solar).
			if Unit(player):HasBuffs(A.EclipseSolar.ID, true) > 0 then
				Temp.EclipseSolar = true
			end
			
			if Unit(player):HasBuffs(A.EclipseLunar.ID, true) > 0 then
				Temp.EclipseSolar = false
			end
			
			if Temp.EclipseSolar then
				if A.Wrath:IsReady(unitID) and canCast then
					return A.Wrath:Show(icon)
				end
			end
			
			if not Temp.EclipseSolar then
				if A.Starfire:IsReady(unitID) and canCast then
					return A.Starfire:Show(icon)
				end
			end
		end
		
		--CAT
		if SpecSelect == "FeralCat" or (SpecSelect == "Auto" and Unit(player):HasBuffs(A.CatForm.ID, true) > 0) then
			--Boss Opener Max DPS
			local DPSOpener = A.GetToggle(2, "CatOpener")
				--[1] = MaxDPS
				--[2] = Safer
				--[3] = None
			
			if A.CatForm:IsReady(player) and AutoForm == "CatForm" and Unit(player):HasBuffs(A.CatForm.ID, true) == 0 and not Temp.BearWeavingShift then
				return A.CatForm:Show(icon)
			end			
			
			if DPSOpener == "MaxDPS" and Temp.OpenerRotation and InMelee() and Unit(player):HasBuffs(A.CatForm.ID, true) > 0 then
				--Spam until Omen of Clarity
				
				--Tiger's Fury
				if A.TigersFury:IsReady(player) and Player:Energy() <= 15 and ((Unit(unitID):Health() > FerociousBiteDamage() and A.FerociousBite:IsTalentLearned()) or not A.FerociousBite:IsTalentLearned())	then
					return A.TigersFury:Show(icon)
				end
				--Berserk
				if A.Berserk:IsReady(player) and Unit(player):HasBuffs(A.TigersFury.ID, true) > 0 then
					return A.Berserk:Show(icon)
				end
				
				--MangleCat
				if A.MangleCat:IsReady(unitID) and A.MangleCat:AbsentImun(unitID, Temp.TotalAndPhys) and Unit(unitID):HasDeBuffs(A.MangleCat.ID) == 0 and Unit(unitID):HasDeBuffs(A.MangleBear.ID) == 0 and Unit(unitID):HasDeBuffs(A.Trauma.ID) == 0 and (BleedMissing or Player:ComboPoints() < 5) then
					return A.MangleCat:Show(icon)
				end
				--Rake
				if A.Rake:IsReady(unitID) and A.Rake:AbsentImun(unitID, Temp.TotalAndPhys) and Unit(unitID):HasDeBuffs(A.Rake.ID, true) < A.GetGCD() then
					return A.Rake:Show(icon)
				end
				--Savage Roar if combo points >= 4 otherwise Shred until combo points >= 4 then Savage Roar
				if A.SavageRoar:IsReady(player) and Player:ComboPoints() >= 4 and Unit(player):HasBuffs(A.SavageRoar.ID, true) < A.GetGCD() then
					return A.SavageRoar:Show(icon)
				end
				--Ferocious Bite
				if A.FerociousBite:IsReady(unitID) and A.FerociousBite:AbsentImun(unitID, Temp.TotalAndPhys) and Player:ComboPoints() >= 5 then
					return A.FerociousBite:Show(icon)
				end
				--Shred until energy < 10
				if A.Shred:IsReady(unitID) and A.Shred:AbsentImun(unitID, Temp.TotalAndPhys) and Player:IsBehind() then
					return A.Shred:Show(icon)
				end
				--End Opener when Berserk ends
				if Unit(player):HasBuffs(A.Berserk.ID, true) > 0 and Unit(player):HasBuffs(A.Berserk.ID, true) < A.GetGCD() then
					Temp.OpenerRotation = false
				end
			end
			
			--Boss Opener Safe
			if DPSOpener == "Safer" and Temp.OpenerRotation and InMelee() and Unit(player):HasBuffs(A.CatForm.ID, true) > 0 then
				--Berserk
				if A.Berserk:IsReady(player) then
					return A.Berserk:Show(icon)
				end
				--Tiger's Fury
				if A.TigersFury:IsReady(player) and Player:Energy() <= 15 and ((Unit(unitID):Health() > FerociousBiteDamage() and A.FerociousBite:IsTalentLearned()) or not A.FerociousBite:IsTalentLearned()) then
					return A.TigersFury:Show(icon)
				end						
				--MangleCat
				if A.MangleCat:IsReady(unitID) and A.MangleCat:AbsentImun(unit, Temp.TotalAndPhys) and Unit(unitID):HasDeBuffs(A.MangleCat.ID) == 0 and Unit(unitID):HasDeBuffs(A.MangleBear.ID) == 0 and Unit(unitID):HasDeBuffs(A.Trauma.ID) == 0 and (BleedMissing or Player:ComboPoints() < 5) then
					return A.MangleCat:Show(icon)
				end
				--Savage Roar if 2 CP.
				if A.SavageRoar:IsReady(player) and Player:ComboPoints() >= 2 and Unit(player):HasBuffs(A.SavageRoar.ID, true) < A.GetGCD() then
					return A.SavageRoar:Show(icon)
				end		
				--Rip at 5 CP.
				if A.Rip:IsReady(unitID) and A.Rip:AbsentImun(unitID, Temp.TotalAndPhys) and Player:ComboPoints() >= SpenderCP and Unit(unitID):HasDeBuffs(A.Rip.ID, true) < A.GetGCD() then
					return A.Rip:Show(icon)
				end	
				--Ferocious Bite 5 CP
				if A.FerociousBite:IsReady(unitID) and A.FerociousBite:AbsentImun(unitID, Temp.TotalAndPhys) and Player:ComboPoints() >= 5 then
					return A.FerociousBite:Show(icon)
				end				
				--Rake (Savage Roar if not from last step).
				if A.Rake:IsReady(unitID) and A.Rake:AbsentImun(unit, Temp.TotalAndPhys) and Unit(unitID):HasDeBuffs(A.Rake.ID, true) < A.GetGCD() then
					return A.Rake:Show(icon)
				end				
				--Shred to 5 CP.
				if A.Shred:IsReady(unitID) and A.Shred:AbsentImun(unit, Temp.TotalAndPhys) and Player:IsBehind() then
					return A.Shred:Show(icon)
				end
				if Unit(player):HasBuffs(A.Berserk.ID, true) > 0 and Unit(player):HasBuffs(A.Berserk.ID, true) < A.GetGCD() then
					Temp.OpenerRotation = false
				end				
			end
			
			--Bear Weaving
			local BearWeaving = A.GetToggle(2, "BearWeaving")
			local BearWeavingLacerate = A.GetToggle(2, "BearWeavingLacerate")
			if A.Furor:GetTalentRank() >= 5 and BearWeaving then
			
				if (A.DireBearForm:IsReady(player) or A.BearForm:IsReady(player)) and Player:Energy() < 40 and Unit(player):HasBuffs(A.Clearcasting.ID) == 0 and Unit(unitID):HasDeBuffs(A.Rip.ID, true) > 3.5 and Unit(player):HasBuffs(A.Berserk.ID) == 0 and not BearFormActive and Player:Mana() > (A.DireBearForm:GetSpellPowerCost() + A.CatForm:GetSpellPowerCost()) then
					Temp.BearWeavingShift = true
					return A.BearForm:Show(icon)
				end
				
				if BearFormActive and not BearWeavingLacerate then
					if A.CatForm:IsReady(player) and Player:Energy() >= 70 or Unit(unitID):HasDeBuffs(A.Rip.ID, true) <= 3 or Unit(player):HasBuffs(A.Clearcasting.ID) > 0 then
						Temp.BearWeavingShift = false
						return A.CatForm:Show(icon)
					end
					
					if A.Enrage:IsReady(player) then
						return A.Enrage:Show(icon)
					end
					
					if A.MangleBear:IsReady(unitID) then
						return A.MangleBear:Show(icon)
					end
					
					if A.Lacerate:IsReady(unitID) then
						return A.Lacerate:Show(icon)
					end
					
					if A.Maul:IsReady(unitID) and not A.Maul:IsSpellCurrent() and ((A.MangleBear:IsTalentLearned() and A.MangleBear:GetCooldown() > 0) or not A.MangleBear:IsTalentLearned()) then
						return A.Maul:Show(icon)
					end
				end
				
				if BearFormActive and BearWeavingLacerate then
					if A.Lacerate:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Lacerate.ID, true) < 3 then
						return A.Lacerate:Show(icon)
					end
					
					if A.CatForm:IsReady(player) and (Player:Energy() >= 70 or Unit(unitID):HasDeBuffs(A.Rip.ID, true) <= 3) then
						Temp.BearWeavingShift = false
						return A.CatForm:Show(icon)
					end

					if A.Lacerate:IsReady(unitID) and Unit(unitID):HasDeBuffsStacks(A.Lacerate.ID, true) < 5 then
						return A.Lacerate:Show(icon)
					end
					
					if A.Lacerate:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Lacerate.ID, true) < 9 then
						return A.Lacerate:Show(icon)
					end					

					if A.CatForm:IsReady(player) and (Player:Rage() < 10 or Unit(player):HasBuffs(A.Clearcasting.ID) > 0) then
						Temp.BearWeavingShift = false
						return A.CatForm:Show(icon)
					end
					
					if A.MangleBear:IsReady(unitID) then
						return A.MangleBear:Show(icon)
					end
					
					if A.Maul:IsReady(unitID) and not A.Maul:IsSpellCurrent() then
						return A.Maul:Show(icon)
					end
				end
			end
			
			--Rotation
			if Unit(player):HasBuffs(A.CatForm.ID, true) > 0 then
				local FBBerserk = A.GetToggle(2, "FBBerserk")
				--FerociousBite if will kill or Berserk active
				if A.FerociousBite:IsReady(unitID) and ((Unit(unitID):Health() <= FerociousBiteDamage() and Player:ComboPoints() > 0) or (FBBerserk and Unit(player):HasBuffs(A.Berserk.ID) > 0)) then
					return A.FerociousBite:Show(icon)
				end		
				--FaerieFire
				if inCombat and A.FaerieFireFeral:IsReady(unitID) and FaerieFireMissing then
					return A.FaerieFireFeral:Show(icon)
				end
				--Stealth open
				local StealthOpener = A.GetToggle(2, "StealthOpener")
				if A.Ravage:IsReady(unitID) and StealthOpener == "Ravage" then
					return A.Ravage:Show(icon)
				end
				if A.Pounce:IsReady(unitID) and StealthOpener == "Pounce" then
					return A.Pounce:Show(icon)
				end
				--Energy < 30 use Tiger's Fury
				if A.TigersFury:IsReady(player) and InMelee() and Player:Energy() <= 30 and ((Unit(unitID):Health() > FerociousBiteDamage() and A.FerociousBite:IsTalentLearned()) or not A.FerociousBite:IsTalentLearned()) then
					return A.TigersFury:Show(icon)
				end	
				--Berserk if energy > 50 and < 85 and Tiger's Fury buff < 2				
				if A.Berserk:IsReady(player) and InMelee() and BurstIsON(unitID) and Unit(player):HasBuffs(A.TigersFury.ID, true) < 2 and A.TigersFury:GetCooldown() > 13 and Player:Energy() > 50 and Player:Energy() < 85 then
					return A.Berserk:Show(icon)
				end
				--Savage Roar if < 1
				if A.SavageRoar:IsReady(player) and Player:ComboPoints() >= 1 and Unit(player):HasBuffs(A.SavageRoar.ID, true) < A.GetGCD() then
					return A.SavageRoar:Show(icon)
				end	
				--If Rip/Savage Roar within 3 seconds of each other and < 8 seconds then 1 CP Savage Roar to desync timers.
				if A.SavageRoar:IsReady(player) and Player:ComboPoints() == 1 and Unit(player):HasBuffs(A.SavageRoar.ID, true) < 8 and Unit(player):HasBuffs(A.SavageRoar.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.Rip.ID, true) < 8 and Unit(unitID):HasDeBuffs(A.Rip.ID, true) > 0 then
					return A.SavageRoar:Show(icon)
				end
				--Mangle if no debuff
				if A.MangleCat:IsReady(unitID) and A.MangleCat:AbsentImun(unitID, Temp.TotalAndPhys) and Unit(unitID):HasDeBuffs(A.MangleCat.ID) == 0 and Unit(unitID):HasDeBuffs(A.MangleBear.ID) == 0 and Unit(unitID):HasDeBuffs(A.Trauma.ID) == 0 and (BleedMissing or Player:ComboPoints() < 5) then
					return A.MangleCat:Show(icon)
				end						
				--Rip at 5 CP
				if A.Rip:IsReady(unitID) and A.Rip:AbsentImun(unitID, Temp.TotalAndPhys) and Player:ComboPoints() >= SpenderCP and Unit(unitID):HasDeBuffs(A.Rip.ID, true) == 0 then
					return A.Rip:Show(icon)
				end	
				--FB at 5 CP if Rip/SR > 8 seconds
				local FBTimer = A.GetToggle(2, "FBTimer")
				if A.FerociousBite:IsReady(unitID) and A.FerociousBite:AbsentImun(unitID, Temp.TotalAndPhys) and Player:ComboPoints() >= SpenderCP and Unit(unitID):HasDeBuffs(A.Rip.ID, true) > FBTimer and ((Unit(player):HasBuffs(A.SavageRoar.ID, true) > FBTimer and A.SavageRoar:IsSpellLearned() or not A.SavageRoar:IsSpellLearned())) then
					return A.FerociousBite:Show(icon)
				end	
				--Rake if no debuff and CP < 5
				if A.Rake:IsReady(unitID) and A.Rake:AbsentImun(unitID, Temp.TotalAndPhys) and Unit(unitID):HasDeBuffs(A.Rake.ID, true) == 0 then
					return A.Rake:Show(icon)
				end					
				--If Clearcast then Shred
				if A.Shred:IsReady(unitID) and A.Shred:AbsentImun(unitID, Temp.TotalAndPhys) and Unit(player):HasBuffs(A.Clearcasting.ID, true) > 0 and Player:IsBehind() then
					return A.Shred:Show(icon)
				end
				--if enemies > 2 and (SR > 5 or SR < 5 and CP >= 1) then SwipeCat
				if A.SwipeCat:IsReady(player) and InMelee() and UseAoE and not Pooling and A.Shred:AbsentImun(unitID, Temp.TotalAndPhys) and MultiUnits:GetByRange(7, 3) > 2 and (Unit(player):HasBuffs(A.SavageRoar.ID, true) > 5 or (Unit(player):HasBuffs(A.SavageRoar.ID, true) < 5 and Player:ComboPoints() >= 1)) then 
					return A.SwipeCat:Show(icon)
				end
				--Shred
				if A.Shred:IsReady(unitID) and not Pooling and A.Shred:AbsentImun(unitID, Temp.TotalAndPhys) and Player:IsBehind() then
					return A.Shred:Show(icon)
				end
				--Mangle spam
				if A.MangleCat:IsReady(unitID) and not Pooling and A.MangleCat:AbsentImun(unitID, Temp.TotalAndPhys) and Player:Energy() > A.Shred:GetSpellPowerCost() then
					return A.MangleCat:Show(icon)
				end	
				--Claw if nothing else
				if A.Claw:IsReady(unitID) and not Pooling and A.Claw:AbsentImun(unitID, Temp.TotalAndPhys) and Player:Energy() > A.Shred:GetSpellPowerCost() then
					return A.Claw:Show(icon)
				end	
			end
		end
		
		--BEAR
		if SpecSelect == "FeralBear" or (SpecSelect == "Auto" and Player:IsStance(1)) then
			if A.BearForm:IsReady(player) and Unit(player):HasBuffs(A.BearForm.ID, true) == 0 and Unit(player):HasBuffs(A.DireBearForm.ID, true) == 0 and AutoForm == "BearForm" then
				return A.BearForm:Show(icon)
			end
			if A.DireBearForm:IsReady(player) and Unit(player):HasBuffs(A.BearForm.ID, true) == 0 and Unit(player):HasBuffs(A.DireBearForm.ID, true) == 0 and AutoForm == "BearForm" then
				return A.DireBearForm:Show(icon)
			end			
            if A.Growl:IsReady(unitID, true, nil, nil, nil) and not Unit(unitID):IsBoss() and not Unit(unitID):IsDummy() and Unit(unitID):GetRange() <= 30 and ( Unit("targettarget"):InfoGUID() ~= Unit("player"):InfoGUID() and Unit("targettarget"):InfoGUID() ~= nil) then 
                return A.Growl:Show(icon)
            end 			
			--Pull with FaerieFireFeral
			if A.FaerieFireFeral:IsReady(unitID) and FaerieFireMissing then
				return A.FaerieFireFeral:Show(icon)
			end
			--Swipe if no aggro
			if A.SwipeBear:IsReady(player) and MultiUnits.GetByRangeTaunting(10, 1) >= 1 then
				return A.SwipeBear:Show(icon)
			end
			--DemoralizingRoar
			if A.DemoralizingRoar:IsReady(player) and InMelee() and (MultiUnits:GetByRangeMissedDoTs(10, 5, A.DemoralizingRoar.ID) > 0 or Unit(unitID):HasDeBuffs(A.DemoralizingRoar.ID, true) == 0) then
				return A.DemoralizingRoar:Show(icon)
			end
			--Rage < 40 then Enrage
			if A.Enrage:IsReady(player) and InMelee() and Player:Rage() < 40 then
				return A.Enrage:Show(icon)
			end
			--Berserk in range and target ttd > 10
			if A.Berserk:IsReady(player) and InMelee() and BurstIsON(unitID) and (Unit(unitID):TimeToDie() > 10 or MultiUnits.GetByRangeAreaTTD(10) > 10) then
				return A.Berserk:Show(icon)
			end
			--Barkskin in range and target ttd > 10
			if A.Barkskin:IsReady(player) and InMelee() and (Unit(unitID):TimeToDie() > 5) then
				return A.Barkskin:Show(icon)
			end
			--MangleBear
			if A.MangleBear:IsReady(unitID) then
				return A.MangleBear:Show(icon)
			end
			--Lacerate if stacks < 5
			if A.Lacerate:IsReady(unitID) and (Unit(unitID):HasDeBuffsStacks(A.Lacerate.ID, true) < 5 or Unit(unitID):HasDeBuffs(A.Lacerate.ID, true) < 3) then
				return A.Lacerate:Show(icon)
			end
			--Maul if no debuff and enemies >= 2
			if A.Maul:IsReady(unitID) and InMelee() and not A.Maul:IsSpellCurrent() and MultiUnits:GetByRange(10, 3) >= 2 and Unit(unitID):HasDeBuffs(A.Maul.ID, true) < A.GetGCD() then
				return A.Maul:Show(icon)
			end
			--SwipeBear if enemies >= 2
			if A.SwipeBear:IsReady(player) and MultiUnits:GetByRange(10, 3) >= 2 then
				return A.SwipeBear:Show(icon)
			end			
			--Maul
			if A.Maul:IsReady(unitID) and not A.Maul:IsSpellCurrent() then
				return A.Maul:Show(icon)
			end
		end
        
    end
    
	local function HealingRotation(unitID) 
		
        local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
		local getmembersAll = HealingEngine.GetMembersAll()		
        local unitGUID = UnitGUID(unitID)    	
		local DungeonGroup = TeamCache.Friendly.Size >= 2 and TeamCache.Friendly.Size <= 5
		local RaidGroup = TeamCache.Friendly.Size >= 5 		
		
		local Emergency = A.GetToggle(2, "Emergency")			
		local BlanketRejuv = A.GetToggle(2, "BlanketRejuv")
		local RejuvHP = A.GetToggle(2, "RejuvHP")
		local SwiftmendHP = A.GetToggle(2, "SwiftmendHP")		
		local NourishHP = A.GetToggle(2, "NourishHP")
		local RegrowthHP = A.GetToggle(2, "RegrowthHP")	
		local WildGrowthHP = A.GetToggle(2, "WildGrowthHP")	
		local WildGrowthTargets = A.GetToggle(2, "WildGrowthTargets")			
		local TranqHP = A.GetToggle(2, "TranqHP")
		local TranqTargets = A.GetToggle(2, "TranqTargets")		
		
		if A.TreeofLife:IsReady(player) and Unit(player):HasBuffs(A.TreeofLife.ID) == 0 then
			return A.TreeofLife:Show(icon)
		end
		
		--Emergency
		if inCombat and canCast and A.NaturesSwiftness:IsReady(player) and A.HealingTouch:IsReadyByPassCastGCD(unitID) then
			if Unit(unitID):HealthPercent() < Emergency then
				return A.NaturesSwiftness:Show(icon)
			end
		end
		
		if A.HealingTouch:IsReady(unitID) and Unit(player):HasBuffs(A.NaturesSwiftness.ID, true) > 0 and canCast then
			return A.HealingTouch:Show(icon)
		end
		
		--Swiftmend
		if inCombat and canCast then
            for i = 1, #getmembersAll do 
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 then 
                    if not Unit(getmembersAll[i].Unit):IsPet() and not Unit(getmembersAll[i].Unit):IsDead() and A.Swiftmend:IsReady(getmembersAll[i].Unit) and (Unit(getmembersAll[i].Unit):HealthPercent() <= SwiftmendHP) and (Unit(getmembersAll[i].Unit):HasBuffs(A.Rejuvenation.ID, true) > 0 or Unit(getmembersAll[i].Unit):HasBuffs(A.Regrowth.ID, true)) then
						HealingEngine.SetTarget(getmembersAll[i].Unit, 0.3)    
						return A.Swiftmend:Show(icon)
					end                    
                end                
            end    
        end 

		--Cleansing
		local Cleanse = A.GetToggle(2, "Cleanse")
		if A.AbolishPoison:IsReady(unitID) and Cleanse then
			for i = 1, #getmembersAll do 
				if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and AuraIsValid(getmembersAll[i].Unit, "UseDispel", "Poison") and Unit(getmembersAll[i].Unit):HasBuffs(A.AbolishPoison.ID) == 0 then
					HealingEngine.SetTarget(getmembersAll[i].Unit, 0.3)   
					return A.AbolishPoison:Show(icon)
				end                
			end
		end
		
		if A.CurePoison:IsReady(unitID) and Cleanse then
			for i = 1, #getmembersAll do 
				if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and AuraIsValid(getmembersAll[i].Unit, "UseDispel", "Poison") and Unit(getmembersAll[i].Unit):HasBuffs(A.AbolishPoison.ID) == 0 then
					HealingEngine.SetTarget(getmembersAll[i].Unit, 0.3)   
					return A.CurePoison:Show(icon)
				end                
			end
		end	

		if A.RemoveCurse:IsReady(unitID) and Cleanse then
			for i = 1, #getmembersAll do 
				if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and AuraIsValid(getmembersAll[i].Unit, "UseDispel", "Curse") then
					HealingEngine.SetTarget(getmembersAll[i].Unit, 0.3)   
					return A.RemoveCurse:Show(icon)
				end                
			end
		end			
	
		--Lifebloom Clearcast Only
		if A.Lifebloom:IsReady(unitID) and canCast and Unit(player):HasBuffs(A.Clearcasting.ID, true) > 0 and Unit(unitID):Role("TANK") and Unit(unit):HasBuffsStacks(A.Lifebloom.ID, true) < 3 then
			return A.Lifebloom:Show(icon)
		end

		--How to manage WildGrowth?
		if A.WildGrowth:IsReady(player) and DungeonGroup and canCast then
			if HealingEngine.GetBelowHealthPercentUnits(WildGrowthHP, 15) > WildGrowthTargets then
				return A.WildGrowth:Show(icon)
			end
		end
		
		--Tranq only if Wild Growth is on CD
		if A.Tranquility:IsReady(player) and canCast and DungeonGroup then
			if A.WildGrowth:GetCooldown() > 0 and HealingEngine.GetBelowHealthPercentUnits(TranqHP, 30) > TranqTargets then
				return A.Tranquility:Show(icon)
			end
		end
		
		--Rejuvenation + blanket option
		if A.Rejuvenation:IsReady(unitID) and canCast then
			if BlanketRejuv then
				for i = 1, #getmembersAll do 
					if Unit(getmembersAll[i].Unit):IsPlayer() and not IsUnitEnemy(getmembersAll[i].Unit) and Unit(getmembersAll[i].Unit):HealthPercent() < 95 and A.Rejuvenation:IsReady(getmembersAll[i].Unit) and Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HasBuffs(A.Rejuvenation.ID, true) == 0 then 
						if UnitGUID(getmembersAll[i].Unit) ~= currGUID then
							HealingEngine.SetTarget(getmembersAll[i].Unit, 0.3)      
							return A.Rejuvenation:Show(icon)
						end    
					end                
				end    
			end
		end
		
		if A.Rejuvenation:IsReady(unitID) and canCast and Unit(unitID):HealthPercent() <= RejuvHP and Unit(unitID):HasBuffs(A.Rejuvenation.ID, true) == 0 then
			return A.Rejuvenation:Show(icon)
		end
		
		--Regrowth
		if A.Regrowth:IsReady(unitID) and canCast and Unit(unitID):HealthPercent() <= RegrowthHP and Unit(unitID):HasBuffs(A.Regrowth.ID, true) == 0 then
			return A.Regrowth:Show(icon)
		end
		
		--Nourish
		if A.Nourish:IsReady(unitID) and canCast and Unit(unitID):HealthPercent() <= NourishHP and not isMoving and Unit(unitID):HasBuffs(A.Regrowth.ID or A.Rejuvenation.ID, true) > 0 then
			return A.Nourish:Show(icon)
		end
	
	end
     
	if A.IsUnitFriendly(target) then 
		unitID = target 
		if HealingRotation(unitID) then 
			return true 
		end 
	end	
	if A.IsUnitFriendly(focus) then 
		unitID = focus 
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
-- Finished

A[1] = nil

A[4] = nil

A[5] = nil

A[6] = nil

A[7] = nil

A[8] = nil
