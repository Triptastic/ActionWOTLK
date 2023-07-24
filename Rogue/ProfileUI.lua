--##########################
--##### TRIP'S ROGUE UI #####
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
    DateTime = "v2.0 (25 June 2023)",
    -- Class settings
    [2] = {
        { -- GENERAL HEADER
            {
                E = "Header",
                L = {
                    ANY = " ====== REBIND INFO ====== ",
                },
            },
        }, 
        {
            {
                E = "Label",
                L = {
                    ANY = "Rebinds occur when a pixel is broken or an ability is missing from the loader. In the list below, the first ability is the binding that you use in the game and the second ability is the binding that you use in the launcher. Ensure that they are the same.",
                },
            },
        },			
        {
            {
                E = "Label",
                L = {
                    ANY = "Goblin Sapper Charge -> Distract",
                },
            },
        },      
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
            { -- FoKEnemies
                E = "Slider",                                                     
                MIN = 0, 
                MAX = 10,                            
                DB = "FoKEnemies",
                DBV = 4,
                ONOFF = true,
                L = { 
                    ANY = "Fan of Knives Targets",
                },
                TT = { 
                    ANY = "Enemies to use Fan of Knives", 
                },                     
                M = {},
            },	
            { -- Blade Flurry
                E = "Slider",                                                     
                MIN = 0, 
                MAX = 10,                            
                DB = "BFEnemies",
                DBV = 2,
                ONOFF = true,
                L = { 
                    ANY = "Blade Flurry Targets",
                },
                TT = { 
                    ANY = "Enemies to use Blade Flurry", 
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
        },						
        {
            { -- EvasionHP
                E = "Slider",                                                     
                MIN = 0, 
                MAX = 100,                            
                DB = "EvasionHP",
                DBV = 30,
                ONOFF = true,
                L = { 
                    ANY = "Evasion HP (%)",
                },
                TT = { 
                    ANY = "HP (%) to use Evasion.", 
                },                     
                M = {},
            },				
        },		
        { -- LAYOUT SPACE   
            {
                E = "LayoutSpace",                                                                         
            },
        },
        { -- Trinkets
            {
                E = "Header",
                L = {
                    ANY = " ====== TRINKETS ====== ",
                },
            },
        },
        {
            { -- Trinket Type 1
                E = "Dropdown",                                                         
                OT = {
                    { text = "Damage", value = "Damage" },
                    { text = "Friendly", value = "Friendly" },
                    { text = "Self Defensive", value = "SelfDefensive" },
                    { text = "Mana Gain", value = "ManaGain" },						
                },
                DB = "TrinketType1",
                DBV = "Damage",
                L = { 
                    ANY = "First Trinket",
                }, 
                TT = { 
                    ANY = "Pick what type of trinket you have in your first/upper trinket slot (only matters for trinkets with Use effects).", 
                }, 
                M = {},
            },	
            { -- Trinket Type 2
                E = "Dropdown",                                                         
                OT = {
                    { text = "Damage", value = "Damage" },
                    { text = "Friendly", value = "Friendly" },
                    { text = "Self Defensive", value = "SelfDefensive" },
                    { text = "Mana Gain", value = "ManaGain" },						
                },
                DB = "TrinketType2",
                DBV = "Damage",
                L = { 
                    ANY = "Second Trinket",
                }, 
                TT = { 
                    ANY = "Pick what type of trinket you have in your second/lower trinket slot (only matters for trinkets with Use effects).", 
                }, 
                M = {},
            },				
        },			
        {
            { -- TrinketValue1
                E = "Slider",                                                     
                MIN = 0, 
                MAX = 100,                            
                DB = "TrinketValue1",
                DBV = 40,
                ONOFF = false,
                L = { 
                    ANY = "First Trinket Value",
                },
                TT = { 
                    ANY = "HP/Mana (%) to use your first trinket, based on what you've chosen for your trinket type. Damage trinkets will be used on burst targets.", 
                },                     
                M = {},
            },	
            { -- TrinketValue2
                E = "Slider",                                                     
                MIN = 0, 
                MAX = 100,                            
                DB = "TrinketValue2",
                DBV = 40,
                ONOFF = false,
                L = { 
                    ANY = "Second Trinket Value",
                },
                TT = { 
                    ANY = "HP/Mana (%) to use your second trinket, based on what you've chosen for your trinket type. Damage trinkets will be used on burst targets.", 
                },                     
                M = {},
            },					
        },				
        { -- LAYOUT SPACE   
            {
                E = "LayoutSpace",                                                                         
            },
        },
        { -- PVE HEADER
            {
                E = "Header",
                L = {
                    ANY = " ====== PvE ====== ",
                },
            },
        },	
        {
            { -- sunder
                E = "Checkbox", 
                DB = "sunderGlyph",
                DBV = false,
                L = { 
                    ANY = "Glyph of Expose Armor", 
                }, 
                TT = { 
                    ANY = "Tick this if you have Glyph of Expose Armor.",
                }, 
                M = {},
            },
            { -- snd
                E = "Checkbox", 
                DB = "sndGlyph",
                DBV = false,
                L = { 
                    ANY = "Glyph of Slice and Dice", 
                }, 
                TT = { 
                    ANY = "Tick this if you have Glyph of Slice and Dice",
                }, 
                M = {},
            },
        },
        {
            { -- StealthOpener
                E = "Dropdown",                                                         
                OT = {
                    { text = "Garrote", value = "openGarrote" },
                    { text = "Cheap Shot", value = "openCheapShot" },
                    { text = "Ambush", value = "openAmbush" },		
                    { text = "Manual", value = "openManual" },							
                },
                DB = "openStealth",
                DBV = "openManual",
                L = { 
                    ANY = "Stealth Opener",
                }, 
                TT = { 
                    ANY = "Choose the ability to use from Stealth. Manual will not use anything.", 
                }, 
                M = {},
            },
        },	
        {
            { -- useToT
                E = "Checkbox", 
                DB = "useToT",
                DBV = false,
                L = { 
                    ANY = "Use Tricks of the Trade", 
                }, 
                TT = { 
                    ANY = "Use Tricks of the Trade",
                }, 
                M = {},
            },
            { -- sunderBitch
                E = "Checkbox", 
                DB = "sunderBitch",
                DBV = false,
                L = { 
                    ANY = "Use Expose Armor", 
                }, 
                TT = { 
                    ANY = "Check this box if you have to do the sundering (usually when no warrior in group).",
                }, 
                M = {},
            },
        },
        { -- ROGUE HEADER
            {
                E = "Header",
                L = {
                    ANY = " ====== PvP ====== ",
                },
            },
        },            				
    },      
}