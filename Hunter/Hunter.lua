--################################
--##### TRIP'S WOTLK HUNTER #####
--################################


--BORROWED ICONS: Hunter's Mark = Stoneform

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
}

local ImmuneArcane = {
    [18864] = true,
    [18865] = true,
    [15691] = true,
    [20478] = true, -- Arcane Servant
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
	local canAoE = UseAoE and (Pet:GetInRange(A.Smack.ID) >= 3 or Pet:GetInRange(A.Claw.ID) >= 3  or Pet:GetInRange(A.Bite.ID) >= 3  or Pet:GetInRange(A.Gore.ID) >= 3 )
	local ManaViperStart = A.GetToggle(2, "ManaViperStart")
	local ManaViperEnd = A.GetToggle(2, "ManaViperEnd")
	local StaticMark = A.GetToggle(2, "StaticMark")
	local BossMark = A.GetToggle(2, "BossMark") 
	local StingController = A.GetToggle(2, "StingController")
	local ConcussiveShotPvE = A.GetToggle(2, "ConcussiveShotPvE")
	local IntimidationPvE = A.GetToggle(2, "IntimidationPvE")
	local ProtectFreeze = A.GetToggle(2, "ProtectFreeze")
	local ReadinessMisdirection = A.GetToggle(2, "ReadinessMisdirection")
	local AspectController = A.GetToggle(2, "AspectController")
	--AspectController[1] = Hawk
	--AspectController[2] = Cheetah
	--AspectController[3] = Viper

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
	if A.MendPet:IsReady(player) and Unit(pet):HealthPercent() <= MendPetHP and Unit(pet):HasBuffs(A.MendPet.ID, true) == 0 then
		return A.MendPet:Show(icon)
	end
	
	--Will of the Forsaken
	if A.WilloftheForsaken:AutoRacial() then 
		return A.WilloftheForsaken:Show(icon)
	end 
	
	-- EscapeArtist
	if A.EscapeArtist:AutoRacial() then 
		return A.EscapeArtist:Show(icon)
	end 	
	
    --###############
    --##### OOC #####
    --###############    

   if AspectController[3] then --Viper
        if A.AspectoftheViper:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheViper.ID, true) == 0 and Player:ManaPercentage() < ManaViperStart and not Player:IsMounted() then
            return A.AspectoftheViper:Show(icon)
        end
    end
    
    if AspectController[2] then --Cheetah
        if A.AspectoftheCheetah:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheCheetah.ID, true) == 0 and ((Player:ManaPercentage() > ManaViperEnd and AspectController[3]) or not AspectController[3]) and not inCombat and not Player:IsMounted() and not A.IsUnitEnemy(target) then
            return A.AspectoftheCheetah:Show(icon)
        end
    end
    
    if A.CallPet:IsReady(player) and Pet:CanCall() then
        return A.CallPet:Show(icon)
    end
    
    if A.RevivePet:IsReady(player) and Unit(pet):IsDead() then
        return A.RevivePet:Show(icon)
    end

	if A.TrueshotAura:IsReady(player) and Unit(player):HasBuffs(A.TrueshotAura.ID, true) == 0 then
		return A.TrueshotAura:Show(icon)
	end

	local function HunterTracking()
		local name, texture, active, category = GetTrackingInfo(1) 
		if not active then 
			return A.TrackBeasts
		end
	end
	local HunterTracking = HunterTracking()
	if A.TrackBeasts:IsReady(player) and HunterTracking then
		return HunterTracking:Show(icon)
	end
 
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unitID)

        local npcID = select(6, Unit(unitID):InfoGUID())		
		local SpecSelect = A.GetToggle(2, "SpecSelect")
		
		local StingisActive = Unit(unitID):HasDeBuffs(A.SerpentSting.ID or A.ViperSting.ID or A.ScorpidSting.ID or A.WyvernSting.ID, true) > 0
		local SteadyShotReady = A.SteadyShot:GetSpellCastTime() <= A.ExplosiveShot:GetCooldown() and A.BlackArrow:GetCooldown() and A.KillCommand:GetCooldown() and Unit(unitID):HasDeBuffs(A.SerpentSting.ID or A.ViperSting.ID or A.ScorpidSting.ID or A.WyvernSting.ID, true) and A.KillShot:GetCooldown() and A.ChimeraShot:GetCooldown() and A.AimedShot:GetCooldown() and A.ArcaneShot:GetCooldown() 

		local DoInterrupt = Interrupts(unitID)
		if DoInterrupt then 
			return DoInterrupt:Show(icon)
		end

		local DoPurge = CanPurge(unitID)
		if DoPurge then
			return DoPurge:Show(icon)
		end

        if AspectController[1] then --Hawk
            if Unit(player):HasBuffs(A.AspectoftheHawk.ID or A.AspectoftheDragonhawk.ID, true) == 0 and (inCombat or A.IsUnitEnemy(unitID)) and ((Player:ManaPercentage() > ManaViperEnd and AspectController[3]) or not AspectController[3]) and not Player:IsMounted() then
				if A.AspectoftheDragonhawk:IsReady(player) then 
					return A.AspectoftheDragonhawk:Show(icon)
				elseif A.AspectoftheHawk:IsReady(player) then
					return A.AspectoftheHawk:Show(icon)
				end
            end
        end

		if ProtectFreeze and Unit(unitID):HasDeBuffs(A.FreezingTrapDebuff.ID) > 0 and A.MultiUnits:GetActiveEnemies() >= 2 then
            return A:Show(icon, CONST.AUTOTARGET)
        end
        
        if A.FreezingTrap:IsReady(player) and FreezingTrapPvE and A.MultiUnits:GetActiveEnemies() >= 2 and A.MultiUnits:GetByRangeInCombat(5, 1, 5) >= 1 then
            return A.FreezingTrap:Show(icon)
        end

        if A.HuntersMark:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.HuntersMark.ID) == 0 and ((Player:GetDeBuffsUnitCount(A.HuntersMark.ID) == 0 and StaticMark) or not StaticMark) and Unit(unitID):TimeToDie() > 2 and not ImmuneArcane[npcID] and ((Unit(unitID):IsBoss() and BossMark) or not BossMark) then
            return A.Stoneform:Show(icon)
        end

		if A.ConcussiveShot:IsReady(unitID) and ConcussiveShotPvE and Unit(unitID):IsMelee() and UnitIsUnit(targettarget, player) and A.LastPlayerCastName ~= A.Intimidation:Info() and (not A.Intimidation:IsReady(unitID) or Unit(pet):HasBuffs(A.Intimidation.ID) == 0 or not IntimidationPvE) and Unit(unitID):HasDeBuffs(A.WingClip.ID) < A.GetGCD() and not ImmuneArcane[npcID] then
			return A.ConcussiveShot:Show(icon)
		end

		if inCombat and BurstIsON(unitID) then
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
			
			if A.Readiness:IsReady(player) then
				if (not ReadinessMisdirection or combatTime > 10) and A.RapidFire:GetCooldown() >= 20 then
					return A.Readiness:Show(icon)
				end
				if ReadinessMisdirection and combatTime < 10 and A.Misdirection:GetCooldown() > 1 then
					return A.Readiness:Show(icon)
				end
			end				
			
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
		
		if A.KillCommand:IsReadyByPassCastGCD(player) and Unit(pet):IsExists() and Pet:IsInRange(A.Claw.ID, unitID) then
			return A.KillCommand:Show(icon)
		end

		if A.KillShot:IsReady(unitID) and Unit(unitID):HealthPercent() <= 20 then
			return A.KillShot:Show(icon)
		end
		
		if A.ExplosiveShot:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.ExplosiveShot.ID, true) == 0 then
			return A.ExplosiveShot:Show(icon)
		end
		
		local MultiShotST = A.GetToggle(2, "MultiShotST")
		if A.MultiShot:IsReady(unitID) and (canAoE or (MultiShotST and Player:ManaPercentage() >= 40)) then
			return A.MultiShot:Show(icon)
		end
		
		if A.BlackArrow:IsTalentLearned() and A.BlackArrow:GetCooldown() < 6 and A.BlackArrow:GetCooldown() > 0 then
			A.Toaster:SpawnByTimer("TripToast", 6, "Black Arrow/Explosive Trap!", "Black Arrow/Explosive Trap coming off CD!", A.BlackArrow.ID)
		end

		if A.BlackArrow:IsReady(unitID) and not canAoE then
			return A.BlackArrow:Show(icon)
		end
		
		if A.ExplosiveTrap:IsReady(player) and (MultiUnits:GetByRange(8, 5) >= 3 or (A.TNT:IsTalentLearned() and A.RaptorStrike:IsInRange(unitID))) then
			return A.ExplosiveTrap:Show(icon)
		end
		
		if A.Volley:IsReady(player) and canAoE then
			return A.Volley:Show(icon)
		end
		
		if A.ChimeraShot:IsReady(unitID) and StingisActive then
			return A.ChimeraShot:Show(icon)
		end
		
		if StingController == "SerpentSting" then
			if A.SerpentSting:IsReady(unitID) and not StingisActive then
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
				elseif not StingisActive then
					return A.SerpentSting:Show(icon)
				end
			end
		end
		
		if A.AimedShot:IsReady(unitID) then
			return A.AimedShot:Show(icon)
		end
		
		if A.ArcaneShot:IsReady(unitID) and (Unit(player):HasBuffs(A.LockandLoad.ID, true) == 0 or not A.ExplosiveShot:IsTalentLearned()) then
			return A.ArcaneShot:Show(icon)
		end
		
		if A.SteadyShot:IsReady(unitID) and not isMoving and SteadyShotReady then
			return A.SteadyShot:Show(icon)
		end

		if A.WingClip:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.WingClip.ID, true) <= A.GetGCD() and A.WingClip:AbsentImun(unitID, Temp.TotalAndPhysAndCC) then
			return A.WingClip:Show(icon)
		end            
		
		if A.MongooseBite:IsReady(unitID) then
			return A.MongooseBite:Show(icon)
		end
		
		if A.RaptorStrike:IsReady(unitID) and not A.RaptorStrike:IsSpellCurrent() and InMelee then
			return A.RaptorStrike:Show(icon)
		end		

		return A.Fix:Show(icon)	

    end

	if A.IsUnitEnemy("target") and A.GetCurrentGCD() <= A.GetLatency() then 
        return EnemyRotation("target")
    end 
	
	return A.Fix:Show(icon)	
        
end
-- Finished

A[1] = nil

A[4] = nil

A[5] = nil

A[6] = nil

A[7] = nil

A[8] = nil
