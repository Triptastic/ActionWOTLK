--############################
--##### TRIP'S PRIEST UI #####
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
    DateTime = "v1.00 (21 August 2022)",
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
                        ANY = " ====== PRIEST ====== ",
                    },
                },
            },
            { -- PRIEST OPTIONS FIRST ROW
				{ -- SWDMoving
                    E = "Checkbox", 
                    DB = "SWDMoving",
                    DBV = true,
                    L = { 
                        ANY = "Shadow Word: Death with movement",
                    }, 
                    TT = { 
                        ANY = "Use Shadow Word: Death whenever moving to keep damage uptime.",
                    }, 
                    M = {},
                },	
				{ -- SWDMoving
                    E = "Checkbox", 
                    DB = "DPMoving",
                    DBV = true,
                    L = { 
                        ANY = "Devouring Plague with movement",
                    }, 
                    TT = { 
                        ANY = "Use Devouring Plague whenever moving to keep damage uptime. This will overwrite your previous Devouring Plague.",
                    }, 
                    M = {},
                },					
            },			
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },		
			{ -- HOLY HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== HOLY ====== ",
                    },
                },
            },			
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
			{ -- SHADOW HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== SHADOW ====== ",
                    },
                },
            },	
			{ -- MACRO LABEL
                {
                    E = "Label",
                    L = {
                        ANY = "Make sure you bind StopCast in GGL! We use StopCast to ensure that we don't waste any time channeling Mind Flay, especially when we can snipe an execute with Shadow Word: Death!",
                    },
                },
                {
                    E = "Label",
                    L = {
                        ANY = "Unfortunately, automatic target swapping for DoTs is too unreliable and can cause you to accidentally pull things that you shouldn't. You'll have to change targets manually to multi-dot.",
                    },
                },				
            },
			{
                { -- ShadowfiendMana
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 10,                            
                    DB = "MindSearTargets",
                    DBV = 5,
                    ONOFF = true,
                    L = { 
                        ANY = "Mind Sear Targets",
                    },
                    TT = { 
                        ANY = "Amount of targets to replace Mind Flay with Mind Sear. Please be aware that AoE detection is difficult on ranged/petless classes.", 
                    },                     
                    M = {},
                },							
			},				
		},
}