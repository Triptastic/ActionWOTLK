--############################
--##### TRIP'S HUNTER UI #####
--############################

local TMW											= TMW 
local CNDT											= TMW.CNDT
local Env											= CNDT.Env

local A												= Action
local GetToggle										= A.GetToggle
local InterruptIsValid								= A.InterruptIsValid

local UnitCooldown									= A.UnitCooldown
local Unit											= A.Unit 
local Player										= A.Player 
local Pet											= A.Pet
local LoC											= A.LossOfControl
local MultiUnits									= A.MultiUnits
local EnemyTeam										= A.EnemyTeam
local FriendlyTeam									= A.FriendlyTeam
local TeamCache										= A.TeamCache
local InstanceInfo									= A.InstanceInfo
local select, setmetatable							= select, setmetatable

A.Data.ProfileEnabled[Action.CurrentProfile] = true
A.Data.ProfileUI = {    
    DateTime = "v1.2 (15 September 2022)",
    -- Class settings
    [2] = {        
            { -- GENERAL HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== GENERAL ====== ",
                    },
                },
            },            
            { -- GENERAL OPTIONS FIRST ROW
				{ -- AOE
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {},
                },
			},
			{
                {-- MACRO LABEL
                    E = "Label",
                    L = {
                        ANY = "AoE detection currently only works with pet thanks to limitations in WoW API. Please drag the following pet abilities that your pet knows to ANY slot on your action bar (does not need to be bound): Claw, Smack, Gore, Bite. Reload your UI after putting the ability on your action bar.",
                    },
                },			
            },
			{
				{ -- RECOVERY POTION CONTROLLER
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Healing Potion", value = "HealingPotion" },
						{ text = "Limited Invulnerability", value = "LimitedInvulnerabilityPotion" },
						{ text = "Living Action", value = "LivingActionPotion" },
						{ text = "Restorative", value = "RestorativePotion" },						
                    },
                    DB = "PotionController",
                    DBV = "HealingPotion",
                    L = { 
                        ANY = "Potion Usage",
                    }, 
                    TT = { 
                        ANY = "Pick what potion you would like to use. Use slider on the first page of /action to set health value.", 
                    }, 
                    M = {},
                },						
			},
			{
                { -- HealthStone
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HSHealth",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "HP (%) for HealthStone",
                    },
                    TT = { 
                        ANY = "HP (%) to use HealthStone", 
                    },                     
                    M = {},
                },							
			},						
			{
                { -- Defensives
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DefensivesHP",
                    DBV = 20,
                    ONOFF = true,
                    L = { 
                        ANY = "Defensive Cooldown HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Defensive cooldowns.", 
                    },                     
                    M = {},
                },
                { -- MendPet
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "MendPetHP",
                    DBV = 40,
                    ONOFF = true,
                    L = { 
                        ANY = "Mend Pet HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Mend Pet.", 
                    },                     
                    M = {},
                },				
			},
            { -- HUNTER HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== HUNTER ====== ",
                    },
                },
            },
			{
				{ -- STING CONTROLLER
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Serpent Sting", value = "SerpentSting" },
						{ text = "Scorpid Sting", value = "ScorpidSting" },
						{ text = "Viper Sting", value = "ViperSting" },	
						{ text = "None", value = "None" },						
                    },
                    DB = "StingController",
                    DBV = "ViperSting",
                    L = { 
                        ANY = "Sting Usage",
                    }, 
                    TT = { 
                        ANY = "Pick your sting to use in your rotation. Selecting Viper Sting will have it only be used if target has mana, otherwise it will use Serpent Sting.", 
                    }, 
                    M = {},
                },
			},
			{
				{ -- Static Hunter's Mark
                    E = "Checkbox", 
                    DB = "StaticMark",
                    DBV = true,
                    L = { 
                        ANY = "Static Hunter's Mark", 
                    }, 
                    TT = { 
                        ANY = "Check this box to not change your Hunter's Mark target until it expires/dies (useful if you swap targets a lot).", 
                    }, 
                    M = {},
                },
				{ -- Static Hunter's Mark
                    E = "Checkbox", 
                    DB = "BossMark",
                    DBV = false,
                    L = { 
                        ANY = "Hunter's Mark Boss Only", 
                    }, 
                    TT = { 
                        ANY = "Check this box to only use Hunter's Mark on bosses.", 
                    }, 
                    M = {},
                },				
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },			
			{
				{ -- FreezingTrapPvE
                    E = "Checkbox", 
                    DB = "FreezingTrapPvE",
                    DBV = true,
                    L = { 
                        ANY = "Freezing Trap Aggro", 
                    }, 
                    TT = { 
                        ANY = "Drop a Freezing Trap if you have aggro on an enemy in melee and in combat with multiple enemies.", 
                    }, 
                    M = {},
                },
				{ -- FreezingTrapPvE
                    E = "Checkbox", 
                    DB = "ProtectFreeze",
                    DBV = true,
                    L = { 
                        ANY = "Untarget Frozen", 
                    }, 
                    TT = { 
                        ANY = "Automatically swap targets if accidentally targeting an enemy with Freezing Trap (only when in combat with mulitple enemies, make sure you're facing the other enemy you want to target).", 
                    }, 
                    M = {},
                },
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            }, 			
			{
				{ -- ConcussiveShotPvE
                    E = "Checkbox", 
                    DB = "ConcussiveShotPvE",
                    DBV = true,
                    L = { 
                        ANY = "Concussive Shot Aggro", 
                    }, 
                    TT = { 
                        ANY = "Use Concussive Shot to slow target if aggro swaps to you.", 
                    }, 
                    M = {},
                },					
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
			{
				{ -- READINESS
                    E = "Checkbox", 
                    DB = "ReadinessMisdirection",
                    DBV = true,
                    L = { 
                        ANY = "Readiness with Misdirection", 
                    }, 
                    TT = { 
                        ANY = "Automatically use Readiness with Misdirection at the start of a boss fight. All subsequent uses of Readiness in the same encounter will be used on Rapid Fire.", 
                    }, 
                    M = {},
                },
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },			
			{
				{
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Hawk", value = 1 },
						{ text = "Cheetah", value = 2 },
						{ text = "Viper", value = 3 },
                    },
                    MULT = true,
                    DB = "AspectController",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                    }, 
                    L = { 
                        ANY = "Automatic Aspects",
                    }, 
                    TT = { 
                        ANY = "Automatically use Aspects", 
                    }, 
                    M = {},
                },
			},			
			{
                { -- Mana Viper
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ManaViperStart",
                    DBV = 10, -- Set healthpercentage @30% life. 
                    ONOFF = false,
                    L = { 
                        ANY = "Viper Aspect Mana Start(%)",
                    },
                    TT = { 
                        ANY = "Value (%) to turn on Aspect of the Viper. )", 
                    },                     
                    M = {},
                },	
                { -- Mana Viper
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ManaViperEnd",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = false,
                    L = { 
                        ANY = "Viper Aspect Mana End(%)",
                    },
                    TT = { 
                        ANY = "Value (%) to turn off Aspect of the Viper.)", 
                    },                     
                    M = {},
                },					
			},			
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },	
            { -- HUNTER OPTIONS
				{ -- MultiShotST
                    E = "Checkbox", 
                    DB = "MultiShotST",
                    DBV = true,
                    L = { 
                        ANY = "MultiShot Single Target", 
                    }, 
                    TT = { 
                        ANY = "MultiShot on single target if mana isn't too low.", 
                    }, 
                    M = {},
                },				
            },					
		},
}