--##########################
--##### TRIP'S MAGE UI #####
--##########################

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
    DateTime = "v2.0 (26 September 2022)",
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
                { -- AoEEnemies
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 10,                            
                    DB = "AoEEnemies",
                    DBV = 4,
                    ONOFF = true,
                    L = { 
                        ANY = "Enemies to use AoE",
                    },
                    TT = { 
                        ANY = "Enemies to use AoE", 
                    },                     
                    M = {},
                },					
			},
			{
                {-- MACRO LABEL
                    E = "Label",
                    L = {
                        ANY = "Blizzard (the company) made AoE detection pretty hard for ranged classes. Mage's AoE detection is based on how many targets have been in combat with the player in the past 3 seconds and are still alive. If AoE isn't being detected properly, try changing targets to tag 3+ enemies.",
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
			},
            { -- MAGE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== MAGE ====== ",
                    },
                },
            },
			{
				{ -- ArmorSelect
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Mage Armor", value = "MageArmor" },
						{ text = "Molten Armor", value = "MoltenArmor" },
						{ text = "Frost Armor", value = "FrostArmor" },					
                    },
                    DB = "ArmorSelect",
                    DBV = "MageArmor",
                    L = { 
                        ANY = "Magic Armor",
                    }, 
                    TT = { 
                        ANY = "Choose your armor type.", 
                    }, 
                    M = {},
                },
			},
			{
                { -- ManaGem
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ManaGem",
                    DBV = 20,
                    ONOFF = true,
                    L = { 
                        ANY = "Mana Gem Mana (%)",
                    },
                    TT = { 
                        ANY = "Mana (%) to use Mana Gem", 
                    },                     
                    M = {},
                },
                { -- EvocationMana
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "EvocationMana",
                    DBV = 20,
                    ONOFF = true,
                    L = { 
                        ANY = "Evocation Mana (%)",
                    },
                    TT = { 
                        ANY = "Mana (%) to use Evocation. Will wait until burned all stacks of Arcane Blast.", 
                    },                     
                    M = {},
                },				
			},
			{
                { -- ManaShield
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ManaShieldMana",
                    DBV = 60,
                    ONOFF = true,
                    L = { 
                        ANY = "Mana Shield Mana (%)",
                    },
                    TT = { 
                        ANY = "Uses Mana Shield if Ice Barrier isn't ready and player has more mana than this value.", 
                    },                     
                    M = {},
                },
			},
			{
				{ -- AutoInterrupt
                    E = "Checkbox", 
                    DB = "AutoInterrupt",
                    DBV = true,
                    L = { 
                        ANY = "Automatic Interrupt",
                    },
                    TT = { 
                        ANY = "Automatic Interrupt in main rotation. Turn off if you want to use AntiFake or Secondary Rotation instead.", 
                    }, 
                    M = {},
                },
				{ -- InterruptRotation
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Target", value = "Target" },
						{ text = "Focus", value = "Focus" },			
                    },
                    DB = "InterruptRotation",
                    DBV = "Focus",
                    L = { 
                        ANY = "Interrupt Rotation",
                    }, 
                    TT = { 
                        ANY = "Utilises the Secondary Rotation bind to use CC/interrupts on either focus or target, depending on your choice here. IF YOU CHOOSE FOCUS, YOU NEED TO SET YOUR REGULAR TARGET BINDS TO FOCUS MACROS INSTEAD: /cast [@focus,harm][]Deep Freeze", 
                    }, 
                    M = {},
                },
			},
			{
				{ -- BlinkStun
                    E = "Checkbox", 
                    DB = "BlinkStun",
                    DBV = true,
                    L = { 
                        ANY = "Blink when stunned",
                    },
                    TT = { 
                        ANY = "Attempt to Blink when stunned. Won't work 100% of the time.", 
                    }, 
                    M = {},
                },	
				{ -- TotemStomp
                    E = "Checkbox", 
                    DB = "TotemStomp",
                    DBV = true,
                    L = { 
                        ANY = "Totem Stomp",
                    },
                    TT = { 
                        ANY = "Automatically switch targets to destroy important totems.", 
                    }, 
                    M = {},
                },					
			},			
		},
}