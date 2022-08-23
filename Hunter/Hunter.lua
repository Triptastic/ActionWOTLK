--################################
--##### TRIP'S WOTLK HUNTER #####
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
	WilloftheForsaken							= Create({ Type = "Spell", ID = 7744		}),
	ArcaneTorrent								= Create({ Type = "Spell", ID = 28730		}),	
	
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
		
	--Pet Spells

    --Misc
    Heroism										= Create({ Type = "Spell", ID = 32182        }),
    Bloodlust									= Create({ Type = "Spell", ID = 2825        }),
    Drums										= Create({ Type = "Spell", ID = 29529        }),
    SuperHealingPotion							= Create({ Type = "Potion", ID = 22829, QueueForbidden = true }),  
}

local A                                     = setmetatable(Action[Action.PlayerClass], { __index = Action })
Player:AddBag("SOUL_SHARD",     { itemID = A.SoulShard.ID})
Pet:AddActionsSpells(A.PlayerClass, { A.Torment, A.LashofPain, A.SpellLock, A.DevourMagic, A.FireShield, A.Seduction, }) --Need to add A.ShadowBite, A.Cleave when lib updated for WOTLK
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
    return A.ShadowBolt:IsInRange(unitID)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function Interrupts(unitID)
    local useKick, useCC, useRacial = A.InterruptIsValid(unitID, "TargetMouseover")   
    
   
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function CastCurse()

	local CurseofAgonyDebuff = Unit(unitID):HasDeBuffs(980 or 1014 or 6217 or 11711 or 11712 or 11713 or 27218 or 47863 or 47864) > 0
	local CurseoftheElementsDebuff = Unit(unitID):HasDeBuffs(1490 or 11721 or 11722 or 27228 or 47865) > 0
	local CurseofTonguesDebuff = Unit(unitID):HasDeBuffs(1714 or 11719) > 0
	local CurseofWeaknessDebuff = Unit(unitID):HasDeBuffs(702 or 1108 or 6205 or 7646 or 11707 or 11708 or 27224 or 30909 or 50511) > 0 
	local CurseofDoomDebuff = Unit(unitID):HasDeBuffs(603 or 30910 or 47867) > 0
	local CurseofExhaustionDebuff = Unit(unitID):HasDeBuffs(A.CurseofExhaustion) > 0	

	local CurseChoice = A.GetToggle(2, "CurseChoice")
	if CurseChoice == "Agony" then
		if A.CurseofAgony:IsReady(player) and not CurseofAgonyDebuff then
			return A.CurseofAgony
		end
	elseif CurseChoice == "Elements" then
		if A.CurseoftheElements:IsReady(player) and not CurseoftheElementsDebuff then
			return A.CurseoftheElements
		end
	elseif CurseChoice == "Tongues" then
		if A.CurseofTongues:IsReady(player) and not CurseofTonguesDebuff then
			return A.CurseofTongues
		end
	elseif CurseChoice == "Weakness" then
		if A.CurseofWeakness:IsReady(player) and not CurseofWeaknessDebuff then
			return A.CurseofWeakness
		end	
	elseif CurseChoice == "Doom" then
		if A.CurseofDoom:IsReady(player) and not CurseofAgonyDebuff then
			return A.CurseofDoom
		end	
	elseif CurseChoice == "Exhaustion" then
		if A.CurseofExhaustion:IsReady(player) and not CurseofExhaustionDebuff then
			return A.CurseofExhaustion
		end		
	end

end

local function BestArmor()

	local NoArmor = Unit(player):HasBuffs(28176 or 28189 or 687 or 696 or 706 or 1086 or 11733 or 11734 or 11735 or 27260 or 47892 or 47893) == 0

	if NoArmor then
		if A.FelArmor:IsReady(player) then
			return A.FelArmor
		elseif A.DemonSkin:IsReady(player) then
			return A.DemonSkin
		elseif A.DemonArmor:IsReady(player) then
			return A.DemonArmor
		end
	end
end

local function GetSoulShards()
    return Player:GetBag("SOUL_SHARD") and Player:GetBag("SOUL_SHARD").count or A.SoulShard:GetCount() or 0
end 
local SoulshardCount = GetSoulShards()

local function GetHealthstonesByCastName(castName, checkHighRanks)
    -- @return number
    local count     
    if checkHighRanks then 
        for _, v in ipairs(Temp.CastHealthStoneToAllHisRankItems[castName]) do 
            count = v:GetCount()
            if count > 0 then 
                return count
            end 
        end 
    else         
        for _, v in ipairs(Temp.CastHealthStoneToItems[castName]) do             
            count = v:GetCount()
            if count > 0 then 
                return count
            end 
        end 
    end
    
    return 0
end 

local function GetSoulstoneInBag()
    -- @return itemID or nil 
    for i = 1, #Temp.BagSoulstone do 
        if Player:GetBag(Temp.BagSoulstone[i]) then 
            return Player:GetBag(Temp.BagSoulstone[i]).itemID 
        end 
    end 
end 

local function CanDispel(unitID, isFriendly)
    -- @return boolean 
    -- Note: Only [3] APL
    if A.DevourMagic:IsReady(unitID, true) and Pet:IsInRange(A.DevourMagic, unitID) then 
        if isFriendly then 
            if (AuraIsValid(unitID, "UseDispel", "Magic") or AuraIsValid(unitID, "UsePurge", "PurgeFriendly")) and Unit(pet):InCC() == 0 then 
                return A.DevourMagic
            end 
        else 
            if (AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow")) and Unit(pet):InCC() == 0 then 
                return A.DevourMagic
            end 
        end 
    end 
end 

local function CanInterrupt(unitID)
    -- @return boolean 
    -- Note: Only [3] APL
	local useKick, useCC, _, notInterruptable, castRemainsTime = InterruptIsValid(unitID, nil, nil, false)
	if (useKick or useCC) and castRemainsTime >= GetLatency() then 
		if useKick and not notInterruptable and Pet:IsInRange(A.SpellLock, unitID) and A.SpellLock:IsReady(unitID, true) and A.SpellLock:AbsentImun(unitID, Temp.AuraForInterrupt) and Unit(pet):InCC() == 0 then 
			return A.SpellLock   
		end 
		
		if useCC and Unit(unitID):IsHumanoid() and castRemainsTime > A.Seduction:GetSpellCastTimeCache() + GetPing() and Pet:IsInRange(A.Seduction, unitID) and A.Seduction:IsReady(unitID, true) and A.Seduction:AbsentImun(unitID, Temp.AuraForCC) and Unit(unitID):IsControlAble("fear") and Unit(pet):InCC() == 0 then 
			return A.Seduction        
		end 
	end 
end 

local function CanFear(unitID) 
    -- @return boolean 
    -- Note: Only [3] APL
    if GetActiveDoTsCounter((A.Fear:Info())) == 0 and not A.Fear:IsSpellLastGCD() and not A.Fear:IsSpellInFlight() and A.Fear:IsLatenced() and A.Fear:IsReadyByPassCastGCD(unitID) and A.Fear:AbsentImun(unitID, Temp.AuraForFear) and not Unit(unitID):IsTotem() and Unit(unitID):IsControlAble("fear") and Unit(unitID):InCC() == 0 then 
        return true 
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
    
	--Toaster AoE
	if not A.Toaster:IsPlaying("TripToast") then
		if A.IsUnitEnemy(target) and A.Shadowfury:GetCooldown() <= 2 and A.Shadowfury:IsTalentLearned() and UseAoE and inCombat and (Pet:GetInRange(A.LashofPain.ID, 5) >= 3  or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 or Pet:GetInRange(A.Cleave.ID, 5) >= 3 or MultiUnits:GetByRange(15, 4) >= 3) then
			A.Toaster:Spawn("TripToast", "Shadowfury!", "Shadowfury soon, get cursor ready!", A.Shadowfury.ID)
		end
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
	
	local DefensivesHP = A.GetToggle(2, "DefensivesHP")
	if inCombat then
       if petName == "Voidwalker" and A.Sacrifice:IsReadyByPassCastGCD(player) then 
            if Unit(player):HealthPercent() > DefensivesHP and Unit(player):GetRealTimeDMG() > 0 then 
                return A.Sacrifice:Show(icon)
            end  
        end 
	end
	
    if A.DeathCoil:IsReady(unitID) and Unit(player):IsExecuted() and A.DeathCoil:AbsentImun(target, Temp.AuraForCC) then 
        return A.DeathCoil:Show(icon)
    end	

	--Howl of Terror from Ayni
	if A.IsInPvP and A.HowlofTerror:IsReady(player, true) then 
		-- Enemy healer
		if A.Zone == "pvp" then 
			local enemyHealerInRange, _, enemyHealerUnitID = EnemyTeam("HEALER"):PlayersInRange(1)
			if enemyHealerInRange and not UnitIsUnit(enemyHealerUnitID, "target") and ((Unit(enemyHealerUnitID):GetRange() > 0 and Unit(enemyHealerUnitID):GetRange() <= 10) or (petIsActive and Temp.IsPetInMelee(enemyHealerUnitID) and Unit(pet):GetRange() <= 10)) and A.HowlofTerror:AbsentImun(enemyHealerUnitID, Temp.AuraForFear) and Unit(enemyHealerUnitID):IsControlAble("fear") then 
				return A.HowlofTerror:Show(icon)
			end 
		end 
		
		-- Enemy players 
		local namePlateUnitID
		local damagersOnPlayer = 0
		for namePlateUnitID in pairs(ActiveUnitPlates) do                 
			if Unit(namePlateUnitID):IsPlayer() and ((Unit(namePlateUnitID):GetRange() > 0 and Unit(namePlateUnitID):GetRange() <= 10) or (petIsActive and Temp.IsPetInMelee(namePlateUnitID) and Unit(pet):GetRange() <= 10)) and A.HowlofTerror:AbsentImun(namePlateUnitID, Temp.AuraForFear) and Unit(namePlateUnitID):IsControlAble("fear") then 
				if UnitIsUnit(namePlateUnitID .. "target", player) and Unit(namePlateUnitID):IsDamager() then 
					damagersOnPlayer = damagersOnPlayer + 1
				end 
				
				-- Multi-fear all damager who sits on player                    
				if damagersOnPlayer >= 3 then 
					return A.HowlofTerror:Show(icon)
				end 
				
				-- Fear nearest not selected in target:
				-- 1. With any burst buffs
				-- 2. With any casting spell 
				-- 3. If it's enemy healer 
				-- 4. If in unit's own target on execute phase any unit 
				if not UnitIsUnit(namePlateUnitID, "target") and (Unit(namePlateUnitID .. "target"):IsExecuted() or Unit(namePlateUnitID):IsCastingRemains() > 0 or Unit(namePlateUnitID):HasBuffs("DamageBuffs") > 2 or Unit(namePlateUnitID):IsHealer()) and (not Unit(namePlateUnitID):IsFocused() or Unit(namePlateUnitID):GetRealTimeDMG() == 0) then 
					return A.HowlofTerror:Show(icon)
				end 
			end 
		end 
	end         	
    
	--Will of the Forsaken
	if A.WilloftheForsaken:AutoRacial() then 
		return A.WilloftheForsaken:Show(icon)
	end 
	
	-- EscapeArtist
	if A.EscapeArtist:AutoRacial() and not mouseoverInRange30 and not targetInRange30 then 
		return A.EscapeArtist:Show(icon)
	end 	
	
    --###############
    --##### OOC #####
    --###############    

	if A.FelDomination:IsReady(player) and inCombat and not Unit(pet):IsExists() then
		return A.FelDomination:Show(icon)
	end

	local PetChoice = A.GetToggle(2, "PetChoice")
	if not Unit(pet):IsExists() and (not inCombat or Unit(player):HasBuffs(A.FelDomination.ID, true) > 0) then
		if PetChoice == "Imp" then
			if A.SummonImp:IsReady(player) then
				return A.SummonImp:Show(icon)
			end
		elseif PetChoice == "Voidwalker" then
			if A.SummonVoidwalker:IsReady(player) then
				return A.SummonVoidwalker:Show(icon)
			end
		elseif PetChoice == "Succubus" then
			if A.SummonSuccubus:IsReady(player) then
				return A.SummonSuccubus:Show(icon)
			end
		elseif PetChoice == "Incubus" then
			if A.SummonIncubus:IsReady(player) then
				return A.SummonIncubus:Show(icon)
			end	
		elseif PetChoice == "Felhunter" then
			if A.SummonFelhunter:IsReady(player) then
				return A.SummonFelhunter:Show(icon)
			end	
		elseif PetChoice == "Felguard" then
			if A.SummonSuccubus:IsReady(player) then
				return A.SummonFelguard:Show(icon)
			end
		end
	end
	
	--Warlock Armor
	local ArmorBuff = BestArmor()
	if ArmorBuff and canCast then
		return ArmorBuff:Show(icon)
	end		 

 
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unitID)

        local npcID = select(6, Unit(unitID):InfoGUID())		
		local SpecSelect = A.GetToggle(2, "SpecSelect")
    
		local CorruptionActive = Unit(unitID):HasDeBuffs(172 or 6222 or 6223 or 7648 or 11671 or 11672 or 25311 or 27216 or 47812 or 47813, true) > 0
		local ImmolateDown = Unit(unitID):HasDeBuffs(348 or 707 or 1094 or 2941 or 11665 or 11667 or 11668 or 25309 or 27215 or 47810, true) <= A.Immolate:GetSpellCastTime()
		local UARefresh = Player:GetDeBuffsUnitCount(30108 and 30404 and 30405 and 47841 and 47843) < 1 
    
		local DrainLifeHP = A.GetToggle(2, "DrainLifeHP")
		if A.DrainLife:IsReady(unitID) and Unit(player):HealthPercent() <= DrainLifeHP and canCast and not isMoving then
			return A.DrainLife:Show(icon)
		end

		local LifeTapMana = A.GetToggle(2, "LifeTapMana")
		local LifeTapHP = A.GetToggle(2, "LifeTapHP")		
		if A.LifeTap:IsReady(player) and Player:ManaPercentage() <= LifeTapMana and Unit(player):HealthPercent() >= LifeTapHP then
			return A.LifeTap:Show(icon)
		end
		
		local Soulshardcap = A.GetToggle(2, "Soulshardcap")
		if A.DrainSoul:IsReady(unitID) and not Unit(unitID):IsBoss() and SoulshardCount < Soulshardcap and Unit(unitID):HealthPercent() <= 25 then
			return A.DrainSoul:Show(icon)
		end

		local DoInterrupt = CanInterrupt(unitID)
		if DoInterrupt then 
			return DoInterrupt:Show(icon)
        end

		if A.DeathCoil:IsReady(unitID) then         
			local useKick, useCC, useRacial, _, castRemainsTime = InterruptIsValid(target, nil, nil, true)
			if (useKick or useCC or useRacial) and castRemainsTime >= A.GetLatency() and A.DeathCoil:AbsentImun(target, Temp.AuraForCC) and Unit(target):IsControlAble("fear") then 
				return A.DeathCoil:Show(icon)
			end 
		end 

		local DoPurge = CanDispel(unitID, isFriendly)
		if DoPurge then 
			return DoPurge:Show(icon)
        end
		
		--AFFLICTION
		if InRange and (SpecSelect == "Affliction" or (SpecSelect == "Auto" and A.Haunt:IsTalentLearned())) then
			if A.Shadowflame:IsReady(unitID) and UseAoE and MultiUnits:GetByRange(15, 4) >= 3 then
				return A.Shadowflame:Show(icon)
			end	

			if Pet:GetInRange(A.LashofPain.ID, 5) >= 3  or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 or Pet:GetInRange(A.Cleave.ID, 5) >= 3 or MultiUnits:GetByRange(15, 4) >= 3 then
				if A.SeedofCorruption:IsReady(unitID) and UseAoE and canCast and not isMoving then
					return A.SeedofCorruption:Show(icon)
				end
			end	
		
			if A.ShadowBolt:IsReady(unitID) and (A.ImprovedShadowBolt:IsTalentLearned() or not inCombat) and not isMoving and canCast then 
				if Unit(unitID):HasDeBuffs(A.ShadowMastery.ID) < A.ShadowBolt:GetSpellCastTime() and not A.ShadowBolt:IsSpellInFlight() then
					return A.ShadowBolt:Show(icon)
				end
			end
			
			if A.Corruption:IsReady(unitID) and not CorruptionActive and canCast and Unit(unitID):TimeToDie() >= 8 then
				if (A.ImprovedShadowBolt:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ImprovedShadowBolt.ID)) or not A.ImprovedShadowBolt:IsTalentLearned() then
					return A.Corruption:Show(icon)
				end
			end
			
			if A.UnstableAffliction:IsReady(unitID) and not isMoving and canCast and Unit(unitID):TimeToDie() >= 15 and UARefresh then
				return A.UnstableAffliction:Show(icon)
			end
			
			local DoCurse = CastCurse()
			if DoCurse and canCast then
				return DoCurse:Show(icon)
			end
			
			if A.Haunt:IsReady(unitID) and canCast and not isMoving then
				return A.Haunt:Show(icon)
			end
			
			if A.DrainSoul:IsReady(unitID) and Unit(unitID):HealthPercent() < 25 and not isMoving and canCast then
				return A.DrainSoul:Show(icon)
			end
			
			if A.ShadowBolt:IsReady(unitID) and not isMoving and canCast then
				return A.ShadowBolt:Show(icon)
			end

		end
		
		--DEMONOLOGY
		if InRange and (SpecSelect == "Demonology" or (SpecSelect == "Auto" and A.SummonFelguard:IsTalentLearned())) then

			if A.Metamorphosis:IsReady(player) and BurstIsON(unitID) then
				if (UseAoE and MultiUnits:GetByRange(15, 4) >= 3) or (Unit(unitID):TimeToDie() > 30 or Unit(unitID):IsBoss()) then 
					return A.Metamorphosis:Show(icon)
				end
			end

			if A.ShadowBolt:IsReady(unitID) and (A.ImprovedShadowBolt:IsTalentLearned() or not inCombat) and not isMoving and canCast then 
				if Unit(unitID):HasDeBuffs(A.ShadowMastery.ID) < A.ShadowBolt:GetSpellCastTime() and not A.ShadowBolt:IsSpellInFlight() then
					return A.ShadowBolt:Show(icon)
				end
			end		
			
			if A.DemonicEmpowerment:IsReadyByPassCastGCD(player) then --and Pet:IsInRange(A.Cleave.ID, unitID) once Cleave is added to PetLib. 
				return A.DemonicEmpowerment:Show(icon)
			end
			
			if A.ImmolationAura:IsReady(unitID) and Unit(player):HasBuffs(A.Metamorphosis.ID, true) > 0 and UseAoE and MultiUnits:GetByRange(15, 4) >= 3 then
				return A.ImmolationAura:Show(icon)
			end
			
			if A.ShadowCleave:IsReady(unitID) and Unit(player):HasBuffs(A.Metamorphosis.ID, true) > 0 and UseAoE and MultiUnits:GetByRange(15, 4) >= 3 then
				return A.ShadowCleave:Show(icon)
			end		

			if A.Shadowflame:IsReady(unitID) and UseAoE and MultiUnits:GetByRange(15, 4) >= 3 then
				return A.Shadowflame:Show(icon)
			end	

			if Pet:GetInRange(A.LashofPain.ID, 5) >= 3  or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 or Pet:GetInRange(A.Cleave.ID, 5) >= 3 or MultiUnits:GetByRange(15, 4) >= 3 then
				if A.SeedofCorruption:IsReady(unitID) and UseAoE and canCast and not isMoving then
					return A.SeedofCorruption:Show(icon)
				end
			end			

			local DoCurse = CastCurse()
			if DoCurse and canCast then
				return DoCurse:Show(icon)
			end

			if A.Corruption:IsReady(unitID) and not CorruptionActive and canCast and Unit(unitID):TimeToDie() >= 17 then
				if (A.ImprovedShadowBolt:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ImprovedShadowBolt.ID)) or not A.ImprovedShadowBolt:IsTalentLearned() then
					return A.Corruption:Show(icon)
				end
			end

			if A.Immolate:IsReady(unitID) and ImmolateDown and canCast and Unit(unitID):TimeToDie() >= 5 and not isMoving then
				return A.Immolate:Show(icon)
			end

			if A.SoulFire:IsReady(unitID) and Unit(player):HasBuffs(A.Decimation.ID) > 0 and canCast and not isMoving then
				return A.SoulFire:Show(icon)
			end
			
			if A.Incinerate:IsReady(unitID) and (Unit(player):HasBuffs(A.MoltenCore.ID) > 0 or not A.ImprovedShadowBolt:IsTalentLearned()) and not isMoving and canCast then
				return A.Incinerate:Show(icon)
			end
			
			if A.ShadowBolt:IsReady(unitID) and canCast and not isMoving then
				return A.ShadowBolt:Show(icon)
			end

		end
		
		--DESTRUCTION
		if InRange and (SpecSelect == "Destruction" or (SpecSelect == "Auto" and A.ChaosBolt:IsTalentLearned())) then

			if A.Incinerate:IsReady(unitID) and not inCombat and canCast and not isMoving then
				return A.Incinerate:Show(icon)
			end

			local DoCurse = CastCurse()
			if DoCurse and canCast then
				return DoCurse:Show(icon)
			end
			
			if Pet:GetInRange(A.LashofPain.ID, 5) >= 3 or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 or Pet:GetInRange(A.Cleave.ID, 5) >= 3 or MultiUnits:GetByRange(15, 4) >= 3  then
				if A.Shadowfury:IsReady(player) and UseAoE and canCast then
					return A.Shadowfury:Show(icon)
				end
			end	

			if A.Shadowflame:IsReady(unitID) and UseAoE and MultiUnits:GetByRange(15, 4) >= 3 then
				return A.Shadowflame:Show(icon)
			end	
			
			if Pet:GetInRange(A.LashofPain.ID, 5) >= 3 or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 or Pet:GetInRange(A.Cleave.ID, 5) >= 3 or MultiUnits:GetByRange(15, 4) >= 3  then
				if A.SeedofCorruption:IsReady(unitID) and UseAoE and canCast and not isMoving then
					return A.SeedofCorruption:Show(icon)
				end
			end				
			
			if A.Immolate:IsReady(unitID) and ImmolateDown and canCast and Unit(unitID):TimeToDie() >= 5 and not isMoving then
				return A.Immolate:Show(icon)
			end
			
			if A.Conflagrate:IsReady(unitID) and not ImmolateDown and canCast then
				return A.Conflagrate:Show(icon)
			end
			
			if A.ChaosBolt:IsReady(unitID) and canCast and not isMoving then
				return A.ChaosBolt:Show(icon)
			end
			
			if A.Incinerate:IsReady(unitID) and canCast and not isMoving then
				return A.Incinerate:Show(icon)
			end
			
			if A.Corruption:IsReady(unitID) and canCast and not CorruptionActive then
				return A.Corruption:Show(icon)
			end

		end
		
		--Failsafe if nothing selected
		if inRange then
			if A.ShadowBolt:IsReady(unitID) and (A.ImprovedShadowBolt:IsTalentLearned() or not inCombat) and not isMoving and canCast then 
				if Unit(unitID):HasDeBuffs(A.ShadowMastery.ID) < A.ShadowBolt:GetSpellCastTime() and not A.ShadowBolt:IsSpellInFlight() then
					return A.ShadowBolt:Show(icon)
				end
			end	

			if Pet:GetInRange(A.LashofPain.ID, 5) >= 3  or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 or Pet:GetInRange(A.Cleave.ID, 5) >= 3 or MultiUnits:GetByRange(15, 4) >= 3 then
				if A.SeedofCorruption:IsReady(unitID) and UseAoE and canCast and not isMoving then
					return A.SeedofCorruption:Show(icon)
				end
			end	
				
			if A.Corruption:IsReady(unitID) and canCast and not CorruptionActive then
				return A.Corruption:Show(icon)
			end
			
			if A.Immolate:IsReady(unitID) and ImmolateDown and canCast and Unit(unitID):TimeToDie() >= 5 and not isMoving then
				return A.Immolate:Show(icon)
			end			
        end
    end
    
     
	if A.IsUnitEnemy("target") and not Unit("target"):IsDead() then 
        unitID = "target"
        
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
