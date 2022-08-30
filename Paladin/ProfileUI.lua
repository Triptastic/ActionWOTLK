--#############################
--##### TRIP'S PALADIN UI #####
--#############################

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
    DateTime = "v1.00 (23 August 2022)",
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
                { -- HealthStone
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 10,                            
                    DB = "AoEEnemies",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = "Enemies for AoE",
                    },
                    TT = { 
                        ANY = "Amount of enemies nearby to start AoE rotation.", 
                    },                     
                    M = {},
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
                { -- DivineProtectionHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DivineProtectionHP",
                    DBV = 35,
                    ONOFF = true,
                    L = { 
                        ANY = "Divine Protection HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Divine Protection.", 
                    },                     
                    M = {},
                },
                { -- DivineShieldHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DivineShieldHP",
                    DBV = 20,
                    ONOFF = true,
                    L = { 
                        ANY = "Divine Shield HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Divine Shield.", 
                    },                     
                    M = {},
                },				
			},
			{
                { -- ShadowfiendMana
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ShadowfiendMana",
                    DBV = 60,
                    ONOFF = true,
                    L = { 
                        ANY = "Mana (%) for Shadowfiend.",
                    },
                    TT = { 
                        ANY = "Mana (%) to use Shadowfiend.", 
                    },                     
                    M = {},
                },							
			},				
            { -- PRIEST HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== PALADIN ====== ",
                    },
                },
            },			
			{
				{ -- RECOVERY POTION CONTROLLER
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Seal of Light", value = "Light" },
						{ text = "Seal of Righteousness", value = "Righteousness" },
						{ text = "Seal of Wisdom", value = "Wisdom" },
						{ text = "Seal of Justice", value = "Justice" },
						{ text = "Seal of Command", value = "Command" },							
						{ text = "Seal of Vengeance/Corruption", value = "Vengeance" },		
                    },
                    DB = "SealChoice",
                    DBV = "Vengeance",
                    L = { 
                        ANY = "Seal Usage",
                    }, 
                    TT = { 
                        ANY = "Pick what Seal you would like to use.", 
                    }, 
                    M = {},
                },						
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },		
		},
}