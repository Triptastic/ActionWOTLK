--################################
--##### TRIP'S WOTLK HUNTER #####
--################################

--[[Borrowed icons
Track Humanoids = Readiness
Track Hidden = Roar of Sacrifice - use on targettarget
Track Giants = Intervene - use on targettarget
Track Elementals = Cower]]


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
local TeamCacheFriendlyGUIDs                = TeamCacheFriendly.GUIDs -- unitGUID to unitID
local TeamCacheEnemy                        = TeamCache.Enemy
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
	Stoneform									= Create({ Type = "Spell", ID = 20594		}),		
	
	--Class Skills
	ArcaneShot			= Create({ Type = "Spell", ID = 3044, useMaxRank = true        }),
	AspectoftheBeast		= Create({ Type = "Spell", ID = 13161, useMaxRank = true        }),
	AspectoftheCheetah		= Create({ Type = "Spell", ID = 5118, useMaxRank = true        }),
	AspectoftheDragonhawk		= Create({ Type = "Spell", ID = 61846, useMaxRank = true        }),
	AspectoftheHawk			= Create({ Type = "Spell", ID = 13165, useMaxRank = true        }),
	AspectoftheMonkey		= Create({ Type = "Spell", ID = 13163, useMaxRank = true        }),
	AspectofthePack			= Create({ Type = "Spell", ID = 13159, useMaxRank = true        }),
	AspectoftheViper		= Create({ Type = "Spell", ID = 34074, useMaxRank = true        }),
	AspectoftheWild			= Create({ Type = "Spell", ID = 20043, useMaxRank = true        }),
	AutoShot			= Create({ Type = "Spell", ID = 75, useMaxRank = true        }),
	BeastLore			= Create({ Type = "Spell", ID = 1462, useMaxRank = true        }),
	CallPet				= Create({ Type = "Spell", ID = 883, useMaxRank = true        }),
	CallStabledPet			= Create({ Type = "Spell", ID = 62757, useMaxRank = true        }),
	ConcussiveShot			= Create({ Type = "Spell", ID = 5116, useMaxRank = true        }),
	Deterrence			= Create({ Type = "Spell", ID = 19263, useMaxRank = true        }),
	Disengage			= Create({ Type = "Spell", ID = 781, useMaxRank = true        }),
	DismissPet			= Create({ Type = "Spell", ID = 2641, useMaxRank = true        }),
	DistractingShot			= Create({ Type = "Spell", ID = 20736, useMaxRank = true        }),
	EagleEye			= Create({ Type = "Spell", ID = 6197, useMaxRank = true        }),
	ExplosiveTrap			= Create({ Type = "Spell", ID = 13813, useMaxRank = true        }),
	EyesoftheBeast			= Create({ Type = "Spell", ID = 1002, useMaxRank = true        }),
	FeedPet				= Create({ Type = "Spell", ID = 6991, useMaxRank = true        }),
	FeignDeath			= Create({ Type = "Spell", ID = 5384, useMaxRank = true        }),
	Flare				= Create({ Type = "Spell", ID = 1543, useMaxRank = true        }),
	FreezingArrow			= Create({ Type = "Spell", ID = 60192, useMaxRank = true        }),
	FreezingTrap			= Create({ Type = "Spell", ID = 1499, useMaxRank = true        }),
	FreezingTrapDebuff			= Create({ Type = "Spell", ID = 14309, useMaxRank = true        }),	
	FrostTrap			= Create({ Type = "Spell", ID = 13809, useMaxRank = true        }),
	HuntersMark			= Create({ Type = "Spell", ID = 1130, useMaxRank = true        }),
	ImmolationTrap			= Create({ Type = "Spell", ID = 13795, useMaxRank = true        }),
	KillCommand			= Create({ Type = "Spell", ID = 34026, useMaxRank = true        }),
	KillShot			= Create({ Type = "Spell", ID = 53351, useMaxRank = true        }),
	MastersCall			= Create({ Type = "Spell", ID = 53271, useMaxRank = true        }),
	MendPet				= Create({ Type = "Spell", ID = 136, useMaxRank = true        }),
	Misdirection			= Create({ Type = "Spell", ID = 34477, useMaxRank = true        }),
	MongooseBite			= Create({ Type = "Spell", ID = 1495, useMaxRank = true        }),
	MultiShot			= Create({ Type = "Spell", ID = 2643, useMaxRank = true        }),
	RapidFire			= Create({ Type = "Spell", ID = 3045, useMaxRank = true        }),
	RaptorStrike			= Create({ Type = "Spell", ID = 2973, useMaxRank = true        }),
	RevivePet			= Create({ Type = "Spell", ID = 982, useMaxRank = true        }),
	ScareBeast			= Create({ Type = "Spell", ID = 1513, useMaxRank = true        }),
	ScorpidSting			= Create({ Type = "Spell", ID = 3043, useMaxRank = true        }),
	SerpentSting			= Create({ Type = "Spell", ID = 1978, useMaxRank = true        }),
	SnakeTrap			= Create({ Type = "Spell", ID = 34600, useMaxRank = true        }),
	SteadyShot			= Create({ Type = "Spell", ID = 56641, useMaxRank = true        }),
	TameBeast			= Create({ Type = "Spell", ID = 1515, useMaxRank = true        }),
	TrackBeasts			= Create({ Type = "Spell", ID = 1494, useMaxRank = true        }),
	TrackDemons			= Create({ Type = "Spell", ID = 19878, useMaxRank = true        }),
	TrackDragonkin			= Create({ Type = "Spell", ID = 19879, useMaxRank = true        }),
	TrackElementals			= Create({ Type = "Spell", ID = 19880, useMaxRank = true        }),
	TrackGiants			= Create({ Type = "Spell", ID = 19882, useMaxRank = true        }),
	TrackHidden			= Create({ Type = "Spell", ID = 19885, useMaxRank = true        }),
	TrackHumanoids			= Create({ Type = "Spell", ID = 19883, useMaxRank = true        }),
	TrackUndead			= Create({ Type = "Spell", ID = 19884, useMaxRank = true        }),
	TranquilizingShot		= Create({ Type = "Spell", ID = 19801, useMaxRank = true        }),
	ViperSting			= Create({ Type = "Spell", ID = 3034, useMaxRank = true        }),
	Volley				= Create({ Type = "Spell", ID = 1510, useMaxRank = true        }),
	WingClip			= Create({ Type = "Spell", ID = 2974, useMaxRank = true        }),
	AimedShot			= Create({ Type = "Spell", ID = 19434, useMaxRank = true        }),
	BlackArrow			= Create({ Type = "Spell", ID = 63668, useMaxRank = true        }),
	BestialWrath			= Create({ Type = "Spell", ID = 19574, useMaxRank = true        }),
	ChimeraShot			= Create({ Type = "Spell", ID = 53209, useMaxRank = true        }),
	Counterattack			= Create({ Type = "Spell", ID = 19306, useMaxRank = true        }),
	ExplosiveShot			= Create({ Type = "Spell", ID = 53301, useMaxRank = true        }),
	Intimidation			= Create({ Type = "Spell", ID = 19577, useMaxRank = true        }),
	Readiness			= Create({ Type = "Spell", ID = 23989, useMaxRank = true        }),
	ScatterShot			= Create({ Type = "Spell", ID = 19503, useMaxRank = true        }),
	SilencingShot			= Create({ Type = "Spell", ID = 34490, useMaxRank = true        }),
	TrueshotAura			= Create({ Type = "Spell", ID = 19506, useMaxRank = true        }),
	WyvernSting			= Create({ Type = "Spell", ID = 19386, useMaxRank = true        }),

    -- Potions
    MajorManaPotion                            = Create({ Type = "Potion", ID = 13444	}),
    -- Hidden Items    
    -- Note: Healthstone items created in Core.lua
	SoulShard									= Create({ Type = "Item", ID = 6265      }),

	--Glyphs

	
	--Talents
	LockandLoad		= Create({ Type = "Spell", ID = 56453, useMaxRank = true, Hidden = true       }),
	TNT				= Create({ Type = "Spell", ID = 56337, useMaxRank = true, Hidden = true       }),
		
	--Pet Spells
	CalloftheWild		= Create({ Type = "Spell", ID = 53435, useMaxRank = true        }),
	FuriousHowl			= Create({ Type = "Spell", ID = 64495, useMaxRank = true        }),
	RoarofSacrifice		= Create({ Type = "Spell", ID = 53480, useMaxRank = true        }),	
	Intervene			= Create({ Type = "Spell", ID = 53476, useMaxRank = true        }),	
	Cower			= Create({ Type = "Spell", ID = 1742, useMaxRank = true        }),		
	Growl			= Create({ Type = "Spell", ID = 2649, useMaxRank = true        }),	
	Bite			= Create({ Type = "Spell", ID = 17253, useMaxRank = true        }),
	Claw			= Create({ Type = "Spell", ID = 16827, useMaxRank = true        }),
	Smack			= Create({ Type = "Spell", ID = 49966, useMaxRank = true        }),
	Gore			= Create({ Type = "Spell", ID = 35290, useMaxRank = true        }),	

    --Misc
    Heroism										= Create({ Type = "Spell", ID = 32182        }),
    Bloodlust									= Create({ Type = "Spell", ID = 2825        }),
    Drums										= Create({ Type = "Spell", ID = 29529        }),
    SuperHealingPotion							= Create({ Type = "Potion", ID = 22829, QueueForbidden = true }),
	Fix										= Create({ Type = "Spell", ID = 51988, Desc = "Idle Icon Fix"        }),	
}

local A                                     = setmetatable(Action[Action.PlayerClass], { __index = Action })
Pet:AddActionsSpells(A.PlayerClass, { A.Bite, A.Claw, A.Smack, A.Gore, })
Pet:AddTrackers(A.PlayerClass)

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
	UseAspectoftheViper						= false,
}

local ImmuneArcane = {
    [18864] = true,
    [18865] = true,
    [15691] = true,
    [20478] = true, -- Arcane Servant
}    

local ImmuneNature = {
    [2762] = true, -- Thundering Exile
    [2592] = true, -- Rumbling Exile	
	[2735] = true, -- Lesser Rock Elemental
	[92] = true, -- Rock Elemental	
	[2736] = true, -- Greater Rock Elemental	
	[5463] = true, -- Land Rager	
	[2752] = true, -- Rumbler (Greater Rock Elemental rarespawn)
	[2919] = true, -- Fam'retor Guardian (Badlands quest enemy)
	[9396] = true, -- Ground Pounder
	[5855] = true, -- Magma Elemental	
	[17156] = true, -- Tortured Earth Spirit
	[17158] = true, -- Dust Howler
	[17159] = true, -- Storm Rager
	[18062] = true, -- Enraged Crusher	
	[17154] = true, -- Muck Spawn
	[8278] = true, -- Smoulder (Rarespawn)
	[16491] = true, -- Mana Feeder	
	[26407] = true, -- Lightning Sentry		
	[28411] = true, -- Frozen Earth	
} 


local StompMe = {
	5193, -- Tremor Totem
	2630, -- Earthbind
	10467, -- Mana Tide Totem
	--3579, 3911, 3912, 3913, 7398, 7399, 15478, 31120, 31121, 31122, --Stoneclaw Totem

}

local function InRange(unitID)
    -- @return boolean 
    return A.ArcaneShot:IsInRange(unitID)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function InMelee(unitID)
	return A.MongooseBite:IsInRange(unitID)
end
InMelee = A.MakeFunctionCachedDynamic(InMelee)

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(unitID, nil, nil, true)   
    if (useKick or useCC) and castRemainsTime >= GetLatency() then
		if useCC and A.Intimidation:IsReady(unitID) then
			return A.Intimidation
		end
		
		if useKick and A.SilencingShot:IsReady(unitID) and not notInterruptable then
			return A.SilencingShot
		end
	end
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function CanPurge(unitID)
    -- @return boolean 
    -- Note: Only [3] APL
    if A.TranquilizingShot:IsReady(unitID, true) then 
		if (AuraIsValid(unitID, "UseDispel", "PurgeHigh") or AuraIsValid(unitID, "nil", "Enrage")) then 
			return A.TranquilizingShot
		end 
    end 
end 

local function UseTrinkets(unitID)
	local TrinketType1 = A.GetToggle(2, "TrinketType1")
	local TrinketType2 = A.GetToggle(2, "TrinketType2")
	local TrinketValue1 = A.GetToggle(2, "TrinketValue1")
	local TrinketValue2 = A.GetToggle(2, "TrinketValue2")	

	if A.Trinket1:IsReady(unitID) then
		if TrinketType1 == "Damage" and Player:ManaPercentage() >= 20 and Unit(player):HasBuffs(A.AspectoftheViper.ID) == 0 then
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
		if TrinketType2 == "Damage" and Player:ManaPercentage() >= 20 and Unit(player):HasBuffs(A.AspectoftheViper.ID) == 0 then
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

local function SteadyShotNow(unitID)
	local ManaViperStart = A.GetToggle(2, "ManaViperStart")
	local ViperWeave = A.GetToggle(2, "ViperWeave")
	--ViperWeave[1] = SteadyShot
	--ViperWeave[2] = AimedShot
	--ViperWeave[3] = ArcaneShot

	local StingisActive = Unit(unitID):HasDeBuffs(A.SerpentSting.ID or A.ViperSting.ID or A.ScorpidSting.ID or A.WyvernSting.ID, true) > 0
	local SteadyShotCastTime = A.SteadyShot:GetSpellCastTime()
	local ExplosiveShotLearned = A.ExplosiveShot:IsTalentLearned()
	local BlackArrowLearned = A.BlackArrow:IsTalentLearned()
	local KillCommandLearned = A.KillCommand:IsTalentLearned()
	local ChimeraShotLearned = A.ChimeraShot:IsTalentLearned()
	local AimedShotLearned = A.AimedShot:IsTalentLearned()
	local KillShotLearned = A.KillShot:IsTalentLearned()	

	if A.SteadyShot:IsReady(unitID) and StingisActive then
		if ((SteadyShotCastTime <= A.ExplosiveShot:GetCooldown() and ExplosiveShotLearned) or not ExplosiveShotLearned) and
		((SteadyShotCastTime <= A.BlackArrow:GetCooldown() and BlackArrowLearned) or not BlackArrowLearned) and
		((SteadyShotCastTime <= A.KillCommand:GetCooldown() and KillCommandLearned) or not KillCommandLearned) and
		((SteadyShotCastTime <= A.ChimeraShot:GetCooldown() and ChimeraShotLearned) or not ChimeraShotLearned) and
		((SteadyShotCastTime <= A.AimedShot:GetCooldown() and AimedShotLearned) or not AimedShotLearned) and
		((SteadyShotCastTime <= A.KillShot:GetCooldown() and KillShotLearned) or not KillShotLearned) then
			if ViperWeave[1] and A.AspectoftheViper:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheViper.ID) == 0 and Player:ManaPercentage() <= ManaViperStart then
				Temp.UseAspectoftheViper = true
				return A.AspectoftheViper
			end
			return A.SteadyShot
		end
	end
		

end

local FreezingArrowAuras = {

		19503, -- Scatter Shot
		118, -- Polymorph
		853, -- HoJ
}


local DisarmBuffs = {
	
		46924, -- Bladestorm
        51690, -- Killing Spree
        51713, -- Shadow Dance
        13750, -- Adrenaline Rush
        59672, -- Metamorphosis (demonology)
        34692, -- The Beast Within 
        3045, -- Rapid Fire
        1719, -- Recklessness
        50213, -- Tiger's Fury (small burst)
        50334, -- Berserk 
        49016, -- Unholy Frenzy 
        31884, -- Avenging Wrath
		48505, -- Starfall
		
}

local BeastBuff = {
	
		5487, -- Bear Form
		768, -- Cat Form
		9634, -- Dire Bear Form
		
}

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
	local canAoE = UseAoE and MultiUnits:GetActiveEnemies() >= 3 --(Pet:GetInRange(A.Smack.ID) >= 3 or Pet:GetInRange(A.Claw.ID) >= 3  or Pet:GetInRange(A.Bite.ID) >= 3  or Pet:GetInRange(A.Gore.ID) >= 3 )
	local ManaViperStart = A.GetToggle(2, "ManaViperStart")
	local StaticMark = A.GetToggle(2, "StaticMark")
	local BossMark = A.GetToggle(2, "BossMark") 
	local StingController = A.GetToggle(2, "StingController")
	local ConcussiveShotPvE = A.GetToggle(2, "ConcussiveShotPvE")
	local IntimidationPvE = A.GetToggle(2, "IntimidationPvE")
	local EndCombatViper = A.GetToggle(2, "EndCombatViper")
	
	local Bursting = Unit(player):HasBuffs(A.RapidFire.ID) > 0 or Unit(player):HasBuffs(A.BestialWrath.ID) > 0 or Unit(player):HasBuffs(A.Berserking.ID) > 0 or Unit(player):HasBuffs(A.BloodFury.ID) > 0 or Unit(player):HasBuffs(A.Bloodlust.ID) > 0 or Unit(player):HasBuffs(A.Heroism.ID) > 0

	local ViperWeave = A.GetToggle(2, "ViperWeave")
	--ViperWeave[1] = SteadyShot
	--ViperWeave[2] = AimedShot
	--ViperWeave[3] = ArcaneShot


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
	
	local DefensivesHP = A.GetToggle(2, "DefensivesHP")
	if inCombat then
		if A.Deterrence:IsReady(player) and Unit(player):HealthPercent() <= DefensivesHP then
			return A.Deterrence:Show(icon)
		end	
	end
    
	local MendPetHP = A.GetToggle(2, "MendPetHP")
	if A.MendPet:IsReady(player) and Unit(pet):IsExists() and Unit(pet):HealthPercent() <= MendPetHP and Unit(pet):HealthPercent() > 0 and Unit(pet):HasBuffs(A.MendPet.ID, true) == 0 and Unit(pet):GetRange() < A.ArcaneShot:GetRange() then
		return A.MendPet:Show(icon)
	end
	
    --###############
    --##### OOC #####
    --###############    
    
	if not inCombat then
		Temp.UseAspectoftheViper = false
	end
	
    if A.CallPet:IsReady(player) and not Unit(pet):IsExists() and not inCombat then
        return A.CallPet:Show(icon)
    end
    
    if A.RevivePet:IsReady(player) and Unit(pet):IsDead() and not inCombat then
        return A.RevivePet:Show(icon)
    end

	--[[if A.Cower:IsReady(player) and inCombat and Unit(pet):HealthPercent() <= 30 then
		return A.TrackElementals:Show(icon)
	end]]

	if A.TrueshotAura:IsReady(player) and Unit(player):HasBuffs(A.TrueshotAura.ID) == 0 and Unit(player):HasBuffs(53138) == 0 then -- Abomination's Might
		return A.TrueshotAura:Show(icon)
	end
	
	if A.AspectoftheViper:IsReady(player) and EndCombatViper and Unit(player):HasBuffs(A.AspectoftheViper.ID) == 0 and Unit(player):HasBuffs(A.AspectoftheCheetah.ID) == 0 and not inCombat and not A.IsUnitEnemy(target) and Player:ManaPercentage() < 100 then
		return A.AspectoftheViper:Show(icon)
	end	
	
	if A.Misdirection:IsReady(player) and combatTime < 5 and A.IsUnitEnemy(target) and not A.IsInPvP then
		return A.Misdirection:Show(icon)
	end	
 
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function PvE(unitID)

	-- PVE ROTATION

		local npcID = select(6, Unit(unitID):InfoGUID())		
		local SpecSelect = A.GetToggle(2, "SpecSelect")
		
		local StingisActive = Unit(unitID):HasDeBuffs(A.SerpentSting.ID, true) > 0 or Unit(unitID):HasDeBuffs(A.ViperSting.ID, true) > 0 or Unit(unitID):HasDeBuffs(A.ScorpidSting.ID, true) > 0 or Unit(unitID):HasDeBuffs(A.WyvernSting.ID, true) > 0
		
		local DoInterrupt = Interrupts(unitID)
		if DoInterrupt then 
			return DoInterrupt:Show(icon)
		end

		local DoPurge = CanPurge(unitID)
		if DoPurge then
			return DoPurge:Show(icon)
		end

		if A.AspectoftheHawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheHawk.ID and A.AspectoftheDragonhawk.ID) == 0 and Player:ManaPercentage() > ManaViperStart and not Temp.UseAspectoftheViper then
			if A.AspectoftheDragonhawk:IsReady(player) then
				return A.AspectoftheDragonhawk:Show(icon)
			end
		end

		if A.KillShot:IsReady(unitID) then
			if A.AspectoftheHawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheHawk.ID and A.AspectoftheDragonhawk.ID) == 0 then
				if A.AspectoftheDragonhawk:IsReady(player) then
					return A.AspectoftheDragonhawk:Show(icon)
				end
			end
			return A.KillShot:Show(icon)				
		end

		if A.HuntersMark:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.HuntersMark.ID) == 0 and ((Player:GetDeBuffsUnitCount(A.HuntersMark.ID) == 0 and StaticMark) or not StaticMark) and Unit(unitID):TimeToDie() > 2 and not ImmuneArcane[npcID] and ((Unit(unitID):IsBoss() and BossMark) or not BossMark) and not Unit(unitID):IsTotem() then
			return A.HuntersMark:Show(icon)
		end
		
		if not Pet:IsAttacking() and A.GetToggle(1, "AutoAttack") and not Unit(unitID):IsDead() then
			return A:Show(icon, CONST.AUTOATTACK)
		end

		if A.ConcussiveShot:IsReady(unitID) and ConcussiveShotPvE and Unit(unitID):IsMelee() and UnitIsUnit(targettarget, player) and A.LastPlayerCastName ~= A.Intimidation:Info() and (not A.Intimidation:IsReady(unitID) or Unit(pet):HasBuffs(A.Intimidation.ID) == 0 or not IntimidationPvE) and Unit(unitID):HasDeBuffs(A.WingClip.ID) < A.GetGCD() and not ImmuneArcane[npcID] then
			return A.ConcussiveShot:Show(icon)
		end	

		if inCombat and BurstIsON(unitID) and Player:ManaPercentage() >= 30 and Unit(player):HasBuffs(A.AspectoftheViper.ID) == 0 then
			if A.CalloftheWild:IsReady(player) then
				return A.CalloftheWild:Show(icon)
			end
			
			if A.BestialWrath:IsReady(player) and Unit(player):HasBuffs(A.BestialWrath.ID, true) == 0 then
				return A.BestialWrath:Show(icon)
			end
			
			if A.FuriousHowl:IsReady(player) then
				return A.FuriousHowl:Show(icon)
			end
			
			if A.RapidFire:IsReady(player) and Unit(player):HasBuffs(A.RapidFire.ID, true) == 0 then
				return A.RapidFire:Show(icon)
			end			
			
			if A.BloodFury:IsReady(player) then
				return A.BloodFury:Show(icon)
			end
			
			if A.Berserking:IsReady(player) then
				return A.Berserking:Show(icon)
			end
			
			if A.Readiness:IsReady(player) and A.RapidFire:GetCooldown() > 30 and A.ChimeraShot:GetCooldown() > 1 then
				return A.TrackHumanoids:Show(icon)
			end
		end
		
		if A.KillCommand:IsReady(player) and Unit(pet):IsExists() and A.SteadyShot:AbsentImun(unitID, Temp.TotalAndPhys) then
			if not Pet:IsAttacking() then
				return A:Show(icon, CONST.AUTOATTACK) 
			end
			return A.KillCommand:Show(icon)
		end
		
		if A.ExplosiveShot:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.ExplosiveShot.ID, true) == 0 then
			if A.AspectoftheHawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheHawk.ID and A.AspectoftheDragonhawk.ID) == 0 then
				if A.AspectoftheDragonhawk:IsReady(player) then
					return A.AspectoftheDragonhawk:Show(icon)
				end
			end
			return A.ExplosiveShot:Show(icon)
		end
		
		if A.MultiShot:IsReady(unitID) and (canAoE or not A.AimedShot:IsTalentLearned()) then
			return A.MultiShot:Show(icon)
		end

		if A.BlackArrow:IsReady(unitID) then
			if A.AspectoftheHawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheHawk.ID and A.AspectoftheDragonhawk.ID) == 0 then
				if A.AspectoftheDragonhawk:IsReady(player) then
					return A.AspectoftheDragonhawk:Show(icon)
				end	
			end
			return A.BlackArrow:Show(icon)
		end
		
		if A.ExplosiveTrap:IsReady(player) and A.MongooseBite:IsInRange(unitID) then
			if A.AspectoftheHawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheHawk.ID and A.AspectoftheDragonhawk.ID) == 0 then
				if A.AspectoftheDragonhawk:IsReady(player) then
					return A.AspectoftheDragonhawk:Show(icon)
				end	
			end
			return A.ExplosiveTrap:Show(icon)
		end
		
		if A.Volley:IsReady(player) and canAoE and not isMoving then
			if A.AspectoftheHawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheHawk.ID and A.AspectoftheDragonhawk.ID) == 0 then
				if A.AspectoftheDragonhawk:IsReady(player) then
					return A.AspectoftheDragonhawk:Show(icon)
				end
			end
			return A.Volley:Show(icon)
		end
		
		if A.ChimeraShot:IsReady(unitID) and StingisActive then
			if A.AspectoftheHawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheHawk.ID and A.AspectoftheDragonhawk.ID) == 0 then
				if A.AspectoftheDragonhawk:IsReady(player) then
					return A.AspectoftheDragonhawk:Show(icon)
				end	
			end
			return A.ChimeraShot:Show(icon)
		end

		if StingController == "Auto" then
			if A.ViperSting:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.ViperSting.ID) == 0 and Unit(unitID):PowerType() == "MANA"  and Unit(unitID):Power() >= 10 and A.ChimeraShot:IsTalentLearned() and Player:ManaPercentage() < 50 and not Unit(unitID):IsBoss() then
				return A.ViperSting:Show(icon)
			elseif A.SerpentSting:IsReady(unitID) and not StingisActive and not ImmuneNature[npcID] then
				return A.SerpentSting:Show(icon)
			end
		end
		
		if StingController == "SerpentSting" then
			if A.SerpentSting:IsReady(unitID) and not StingisActive and not ImmuneNature[npcID] and ((Unit(unitID):TimeToDie() > 8 and not A.ChimeraShot:IsTalentLearned()) or A.ChimeraShot:IsTalentLearned()) then
				return A.SerpentSting:Show(icon)
			end
		end
		
		if StingController == "ScorpidSting" then
			if A.ScorpidSting:IsReady(unitID) and not StingisActive then
				return A.ScorpidSting:Show(icon)
			end
		end
		
		if StingController == "ViperSting" then
			if A.ViperSting:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.ViperSting.ID) == 0 then
				if Unit(unitID):PowerType() == "MANA" and Unit(unitID):Power() >= 10 then
					return A.ViperSting:Show(icon)
				elseif not StingisActive and not ImmuneNature[npcID] then
					return A.SerpentSting:Show(icon)
				end
			end
		end
		
		if A.AimedShot:IsReady(unitID) then
			if ViperWeave[2] then
				if A.AspectoftheViper:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheViper.ID) == 0 and Player:ManaPercentage() <= ManaViperStart then
					Temp.UseAspectoftheViper = true
					return A.AspectoftheViper:Show(icon)
				end
			elseif not ViperWeave[2] then
				if A.AspectoftheDragonhawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheDragonhawk.ID) == 0 then
					Temp.UseAspectoftheViper = false
					return A.AspectoftheDragonhawk:Show(icon)
				end
			end				
			return A.AimedShot:Show(icon)
		end
		
		local ArcaneMovingOnly = A.GetToggle(2, "ArcaneMovingOnly")
		if A.ArcaneShot:IsReady(unitID) and (Unit(player):HasBuffs(A.LockandLoad.ID, true) == 0 or not A.ExplosiveShot:IsTalentLearned()) and ((ArcaneMovingOnly and not isMoving) or not ArcaneMovingOnly) then
			if ViperWeave[3] then
				if A.AspectoftheViper:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheViper.ID) == 0 and Player:ManaPercentage() <= ManaViperStart then
					Temp.UseAspectoftheViper = true
					return A.AspectoftheViper:Show(icon)
				end
			elseif not ViperWeave[3] then
				if A.AspectoftheDragonhawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheDragonhawk.ID) == 0 then
					Temp.UseAspectoftheViper = false
					return A.AspectoftheDragonhawk:Show(icon)
				end
			end		
			return A.ArcaneShot:Show(icon)
		end
		
		local SteadyShotReady = SteadyShotNow(unitID)
		if SteadyShotReady and not isMoving then
			return SteadyShotReady:Show(icon)
		end

		if A.WingClip:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.WingClip.ID, true) <= A.GetGCD() then
			return A.WingClip:Show(icon)
		end            
		
		if A.MongooseBite:IsReady(unitID) then
			return A.MongooseBite:Show(icon)
		end
		
		if A.RaptorStrike:IsReady(unitID) and not A.RaptorStrike:IsSpellCurrent() and InMelee() then
			return A.RaptorStrike:Show(icon)
		end	

		if A.AspectoftheViper:IsReady(player) and Player:ManaPercentage() <= ManaViperStart and Unit(player):HasBuffs(A.AspectoftheViper.ID) == 0 then
			return A.AspectoftheViper:Show(icon)
		end

		if Player:IsShooting() or Player:IsAttacking() then
			return A.Fix:Show(icon)
		end

	end
		
	local function PvP(unitID)
	--PVP ROTATION		
		local KillWindow = IsUnitEnemy(unitID) and Unit(unitID):HealthPercent() <= 65
		local StingisActive = Unit(unitID):HasDeBuffs(A.SerpentSting.ID, true) > 0 or Unit(unitID):HasDeBuffs(A.ViperSting.ID, true) > 0 or Unit(unitID):HasDeBuffs(A.ScorpidSting.ID, true) > 0 or Unit(unitID):HasDeBuffs(A.WyvernSting.ID, true) > 0

		--[[local TotemNameplates = MultiUnits:GetActiveUnitPlates()
		if TotemNameplates then 
			for TotemUnit in pairs(TotemNameplates) do
				for i = 1, #StompMe do 
					local TotemID = select(6, Unit(TotemUnit):InfoGUID())
					if Unit(TotemUnit):IsTotem() and TotemID == 5925 then --Grounding Totem
						return A.Growl:Show(icon)
					end
					if Unit(TotemUnit):IsTotem() and TotemID == StompMe[i] and A.ArcaneShot:IsInRange(TotemUnit) then
						if not UnitIsUnit(TotemUnit, target) then
							return A:Show(icon, ACTION_CONST_AUTOTARGET)
						elseif UnitIsUnit(TotemUnit, target) then
							if not isMoving then
								return A:Show(icon, CONST.AUTOATTACK)
							end								
						end
					end
				end
			end
		end]]

		--[[if A.Intervene:IsReady(player) and Unit(unitID):HasBuffs("DamageBuffs") > 1 and Unit(targettarget):GetRange() < A.ArcaneShot:GetRange() and not Unit(pet):InCC() then
			return A.TrackGiants:Show(icon)
		end

		if A.RoarofSacrifice:IsReady(player) and Unit(unitID):HasBuffs("DamageBuffs") > 1 and Unit(targettarget):GetRange() < A.ArcaneShot:GetRange() and not Unit(pet):InCC() then
			return A.TrackHidden:Show(icon)
		end		]]

		if A.FreezingArrow:IsReady(player) and (Unit("arena1"):HasDeBuffs(FreezingArrowAuras) > 1 or Unit("arena2"):HasDeBuffs(FreezingArrowAuras) > 1 or Unit("arena3"):HasDeBuffs(FreezingArrowAuras) > 1 or Unit("arena4"):HasDeBuffs(FreezingArrowAuras) > 1 or Unit("arena5"):HasDeBuffs(FreezingArrowAuras) > 1 or Unit("target"):HasDeBuffs(FreezingArrowAuras) > 1) then
			return A.FreezingArrow:Show(icon)
		end

		if A.ChimeraShot:IsReady(unitID) and Unit(unitID):HasBuffs(DisarmBuffs) > 0 then
			if A.ScorpidSting:IsReady(unitID) then
				return A.ScorpidSting:Show(icon)
			end
			return A.ChimeraShot:Show(icon)
		end

		if A.ChimeraShot:IsReady(unitID) and Unit(player):Power() > (A.ChimeraShot:GetSpellPowerCost() + A.ViperSting:GetSpellPowerCost()) and Player:ManaPercentage() < 25 and not KillWindow then
			if A.ViperSting:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.ViperSting.ID) == 0 and Unit(unitID):PowerType() == "MANA" and Unit(unitID):Power() >= 10 then
				return A.ViperSting:Show(icon)
			end
			return A.ChimeraShot:Show(icon)
		end
		
		if A.SnakeTrap:IsReady(player) and A.MongooseBite:IsInRange(unitID) then
			return A.SnakeTrap:Show(icon)
		end

		if A.TranquilizingShot:IsReady(unitID) and A.IsUnitEnemy(unitID) then 
			if (AuraIsValid(unitID, "UseDispel", "PurgeHigh") or AuraIsValid(unitID, "UseExpelEnrage","Enrage")) then 
				return A.TranquilizingShot:Show(icon)
			end 
		end
		
		if KillWindow then

			if Unit(focus):IsExists() and A.IsUnitEnemy(focus) and Unit(focus):IsCasting() and Unit(focus):InLOS() then
				if A.SilencingShot:IsReady(focus) then
					return A.SilencingShot:Show(icon)
				end
				if A.ScatterShot:IsReady(focus) then
					return A.ScatterShot:Show(icon)
				end
			end

			if A.AspectoftheDragonhawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheDragonhawk.ID, true) == 0 then
				return A.AspectoftheDragonhawk:Show(icon)
			end

			local UseTrinket = UseTrinkets(unitID)
			if UseTrinket then
				return UseTrinket:Show(icon)
			end	

			if A.KillShot:IsReady(unitID) then
				if A.AspectoftheDragonhawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheDragonhawk.ID, true) == 0 then
					return A.AspectoftheDragonhawk:Show(icon)
				end
				return A.KillShot:Show(icon)
			end	

			if A.KillCommand:IsReady(player) and Unit(pet):IsExists() then
				if not Pet:IsAttacking() then
					return A:Show(icon, CONST.AUTOATTACK) 
				end
				return A.KillCommand:Show(icon)
			end

			if A.RapidFire:IsReady(unitID) and Unit(player):HasBuffs(A.RapidFire.ID) == 0 then
				return A.RapidFire:Show(icon)
			end
			
			if A.Readiness:IsReady(player) and A.RapidFire:GetCooldown() > 1 and A.KillCommand:GetCooldown() > 1 and A.AimedShot:GetCooldown() > 1 and A.ChimeraShot:GetCooldown() > 1 then
				return A.TrackHumanoids:Show(icon)
			end
		
		end	
		
		if A.ScareBeast:IsReady(unitID) and (Unit(unitID):HasBuffs(BeastBuff) > 0 or Unit(unitID):CreatureType() ~= "Beast") and not isMoving then
			return A.ScareBeast:Show(icon)
		end
		
		--[[if (Unit(unitID):HasDeBuffs(A.FreezingArrow.ID) > 0 or Unit(unitID):HasDeBuffs("BreakAble")) and MultiUnits:GetActiveEnemies(40, 3) >= 2 then
			return A:Show(icon, CONST.AUTOTARGET)
		end]]
	
		--[[if Unit(pet):IsExists() then
			if UnitIsUnit(targettarget, pet) or Unit(pet):HealthPercent() <= 50 then
				if Pet:IsAttacking() then
					return A.TrackUndead:Show(icon)
				end
			elseif not UnitIsUnit(targettarget, pet) and Unit(pet):HealthPercent() > 50 and not Unit(pet):InCC() then
				if not Pet:IsAttacking() then
					return A:Show(icon, CONST.AUTOATTACK)
				end
			end
		end]]
	
		if A.KillShot:IsReady(unitID) then
			if A.AspectoftheDragonhawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheDragonhawk.ID, true) == 0 then
				return A.AspectoftheDragonhawk:Show(icon)
			end
			return A.KillShot:Show(icon)
		end
	
		if A.AimedShot:IsReady(unitID) then
			if ViperWeave[2] then
				if A.AspectoftheViper:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheViper.ID) == 0 and Player:ManaPercentage() <= ManaViperStart then
					Temp.UseAspectoftheViper = true
					return A.AspectoftheViper:Show(icon)
				end
			elseif not ViperWeave[2] then
				if A.AspectoftheDragonhawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheDragonhawk.ID) == 0 then
					Temp.UseAspectoftheViper = false
					return A.AspectoftheDragonhawk:Show(icon)
				end
			end				
			return A.AimedShot:Show(icon)
		end
		
		if A.SerpentSting:IsReady(unitID) and not StingisActive then
			return A.SerpentSting:Show(icon)
		end
		
		if A.ChimeraShot:IsReady(unitID) then
			return A.ChimeraShot:Show(icon)
		end
		
		local ArcaneMovingOnly = A.GetToggle(2, "ArcaneMovingOnly")
		if A.ArcaneShot:IsReady(unitID) and ((ArcaneMovingOnly and not isMoving) or not ArcaneMovingOnly) then
			if ViperWeave[3] then
				if A.AspectoftheViper:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheViper.ID) == 0 and Player:ManaPercentage() <= ManaViperStart then
					Temp.UseAspectoftheViper = true
					return A.AspectoftheViper:Show(icon)
				end
			elseif not ViperWeave[3] then
				if A.AspectoftheDragonhawk:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheDragonhawk.ID) == 0 then
					Temp.UseAspectoftheViper = false
					return A.AspectoftheDragonhawk:Show(icon)
				end
			end				
			return A.ArcaneShot:Show(icon)
		end

		if A.HuntersMark:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.HuntersMark.ID) == 0 then
			return A.HuntersMark:Show(icon)
		end
		
		local SteadyShotReady = SteadyShotNow(unitID)
		if SteadyShotReady and not isMoving then
			return SteadyShotReady:Show(icon)
		end

		if A.WingClip:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.WingClip.ID, true) <= A.GetGCD() then
			return A.WingClip:Show(icon)
		end            
		
		if A.MongooseBite:IsReady(unitID) then
			return A.MongooseBite:Show(icon)
		end
		
		if A.RaptorStrike:IsReady(unitID) and not A.RaptorStrike:IsSpellCurrent() and InMelee() then
			return A.RaptorStrike:Show(icon)
		end		
	
	end

	if A.IsUnitEnemy(target) and not A.IsInPvP then 
		unitID = target 
		if PvE(unitID) then 
			return true 
		end 
	end
	if A.IsUnitEnemy(target) and A.IsInPvP then 
		unitID = target 
		if PvP(unitID) then 
			return true 
		end 
	end	
        
end
-- Finished

A[1] = nil

A[4] = nil

A[5] = nil

local PassiveUnitID = {
    raid = {
        [1] = "raid1",
        [2] = "raid2",
        [3] = "raid3",
    },
    party = {
        [1] = "party1",
        [2] = "party2",
        [3] = "party3",
    },
    arena = {
        [1] = "arena1",
        [2] = "arena2",
        [3] = "arena3",
    },
}

local function ArenaRotation(icon)

    local n = icon.ID and icon.ID - 5
    if n then  
        local unitIDe
		local unitIDf
        if TeamCacheEnemy.Type then 
            unitIDe = PassiveUnitID[TeamCacheEnemy.Type][n]
        end 
        
        if TeamCacheFriendly.Type then 
            unitIDf = PassiveUnitID[TeamCacheFriendly.Type][n]
        end 

		if unitIDe and Unit(unitIDe):IsExists() and A.IsInPvP and A.Zone == "arena" and not Player:IsStealthed() and not Player:IsMounted() and not Unit(unitIDe):InLOS() then     
		

			
		end

		
		if unitIDf and Unit(unitIDf):IsExists() and A.IsInPvP and A.Zone == "arena" and not Player:IsStealthed() and not Player:IsMounted() and not Unit(unitIDf):InLOS() then	

			if A.MastersCall:IsReady(unitIDf) and (Unit(unitIDf):HasDeBuffs("Rooted") or (Unit(unitIDf):HasDeBuffs("Slowed") and Unit(unitIDf):HealthPercent() <= 70)) then
				return A.MastersCall:Show(icon)
			end
		
		end
		
	end
end

A[6] = function(icon)

	return ArenaRotation(icon)
end

--AntiFake CC Focus
A[7] = function(icon)

	--[[local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(focus, nil, nil, true)
	if useCC and A.PsychicScreamGreen:IsReady(player) and Unit(focus):GetRange() <= 8 and A.PsychicScream:AbsentImun(focus, Temp.TotalAndMag) then
		return A.PsychicScreamGreen:Show(icon)
	end
	
	if useCC and A.PsychicHorrorRed:IsReady(focus) and A.PsychicHorror:AbsentImun(focus, Temp.TotalAndMag) then
		return A.PsychicHorrorRed:Show(icon)
	end]]

	return ArenaRotation(icon)
end

--AntiFake Interrupt Focus
A[8] = function(icon)  

	--[[local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(focus, nil, nil, true)   
	if useKick and A.SilenceGreen:IsReady(focus) and not notInterruptable and A.Silence:AbsentImun(focus, Temp.TotalAndMagKick) then
		return A.SilenceGreen:Show(icon)
	end		]]

	return ArenaRotation(icon)
end
