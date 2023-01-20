--###########################
--##### TRIP'S DRUID UI #####
--###########################

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
    DateTime = "v1.9 (15 October 2022)",
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
			},			
			{
                { -- Innervate
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "InnervatePercent",
                    DBV = 25,
                    ONOFF = false,
                    L = { 
                        ANY = "Mana (%) for Innervate (self only)",
                    },
                    TT = { 
                        ANY = "Mana (%) to use Innervate (self only). Make sure that your keybinding for Innervate is a macro: /cast [@player] Innervate", 
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
                        ANY = "HP (%) to use Defensive cooldowns (Survival Instincts, Frenzied Regeneration).", 
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
                    E = "Header",
                    L = {
                        ANY = " ====== DEFENSIVES ====== ",
                    },
                },
            },
            {
                { -- Barkskin
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "BarkskinHP",
                    DBV = 50,
                    ONOFF = false,
                    L = { 
                        ANY = "Barkskin",
                    },
                    TT = { 
                        ANY = "HP (%) to use Barkskin.", 
                    },                     
                    M = {},
                },
            },	
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },	             
			{ -- TRINKET HEADER
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
                        ANY = " ====== SPEC/SHAPESHIFT ====== ",
                    },
                },
            },
			{
				{ -- Spec
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Balance", value = "Balance" },
						{ text = "Feral (Cat)", value = "FeralCat" },
						{ text = "Feral (Bear)", value = "FeralBear" },
						{ text = "Restoration", value = "Restoration" },						
						{ text = "Automatic", value = "Auto" },						
                    },
                    DB = "SpecSelect",
                    DBV = "Auto",
                    L = { 
                        ANY = "Specialisation",
                    }, 
                    TT = { 
                        ANY = "Pick your specialisation!", 
                    }, 
                    M = {},
                },			
				{ -- Auto Form
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Moonkin Form", value = "MoonkinForm" },
						{ text = "Cat Form", value = "CatForm" },
						{ text = "Bear Form", value = "BearForm" },	
						{ text = "None", value = "None" },						
                    },
                    DB = "AutoForm",
                    DBV = "None",
                    L = { 
                        ANY = "Shapeshift Form",
                    }, 
                    TT = { 
                        ANY = "Pick the shapeshift form for your spec!", 
                    }, 
                    M = {},
                },
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
			{ -- BALANCE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== BALANCE ====== ",
                    },
                },
            },
            {
				{ -- Starfall AOE
                    E = "Checkbox", 
                    DB = "StarfallAoE",
                    DBV = true,
                    L = { 
                        ANY = "Starfall AoE/Boss Only", 
                    }, 
                    TT = { 
                        ANY = "Only use Starfall in AoE or in a boss fight."
                    }, 
                    M = {},
                },				
            },            
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
			{ -- FERAL HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== FERAL ====== ",
                    },
                },
            },
			{
				{ -- Opener
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Max DPS (Risky)", value = "MaxDPS" },
						{ text = "Safer", value = "Safer" },
						{ text = "None", value = "None" },						
                    },
                    DB = "CatOpener",
                    DBV = "Safer",
                    L = { 
                        ANY = "PvE Opener Type",
                    }, 
                    TT = { 
                        ANY = "Pick your opener type! Won't work until you've learned Savage Roar.", 
                    }, 
                    M = {},
                },
				{ -- StealthOpener
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Pounce", value = "Pounce" },
						{ text = "Ravage", value = "Ravage" },
						{ text = "None", value = "None" },						
                    },
                    DB = "StealthOpener",
                    DBV = "Pounce",
                    L = { 
                        ANY = "Stealth Opener",
                    }, 
                    TT = { 
                        ANY = "Pick the next move to use out of stealth!", 
                    }, 
                    M = {},
                },				
			},
			{
                { -- GlobalDamage
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 2, 
					Precision = 1,
                    DB = "GlobalDamage",
                    DBV = 1,
                    ONOFF = false,
                    L = { 
                        ANY = "Global Damage Modifier",
                    },
                    TT = { 
                        ANY = "Make this number higher if you wish to use Ferocious Bite earlier when finishing enemies. Calculations may not be 100% accurate so this slider enables you to manually adjust. Default is 1.", 
                    },                     
                    M = {},
                },
			},
			{
                { -- SpenderCP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 6,                            
                    DB = "SpenderCP",
                    DBV = 6,
                    ONOFF = true,
                    L = { 
                        ANY = "Finisher Combo Points",
                    },
                    TT = { 
                        ANY = "Combo Points to use Rip/FB. Auto will use at 5 combo points without Primal Fury talent, 4 combo points with Primal Fury talent.", 
                    },                     
                    M = {},
                },
                { -- FBTimer
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 10,                            
                    DB = "FBTimer",
                    DBV = 8,
                    ONOFF = false,
                    L = { 
                        ANY = "Finisher Timer",
                    },
                    TT = { 
                        ANY = "Amount of time in seconds remaining on Savage Roar/Rip before using Ferocious Bite. Default is 8 seconds.", 
                    },                     
                    M = {},
                },				
			},
			{
				{ -- FBBerserk
                    E = "Checkbox", 
                    DB = "FBBerserk",
                    DBV = false,
                    L = { 
                        ANY = "Ferocious Bite with Berserk"
                    }, 
                    TT = { 
                        ANY = "Use Ferocious Bite as your spender whenever Berserk is active."
                    }, 
                    M = {},
                },				
				{ -- ChargeBash
                    E = "Checkbox", 
                    DB = "ChargeBash",
                    DBV = true,
                    L = { 
                        ANY = "Feral Charge Interrupt"
                    }, 
                    TT = { 
                        ANY = "Use Feral Charge to get into Bash range to interrupt your target. Requires Furor talent 5/5 if in Cat Form."
                    }, 
                    M = {},
                },	
            },				
			{				
				{ -- BearWeaving
                    E = "Checkbox", 
                    DB = "BearWeaving",
                    DBV = true,
                    L = { 
                        ANY = "Bear Weaving"
                    }, 
                    TT = { 
                        ANY = "Use Bear Weaving rotation when Furor talent is 5/5."
                    }, 
                    M = {},
                },	
				{ -- BearWeaving
                    E = "Checkbox", 
                    DB = "BearWeavingLacerate",
                    DBV = false,
                    L = { 
                        ANY = "Lacerate while Bear Weaving"
                    }, 
                    TT = { 
                        ANY = "Maintain 5/5 Lacerate while Bear Weaving. Only use this if your fight is going to last longer than 100 seconds."
                    }, 
                    M = {},
                },
			},		
			{ -- RESTO HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== RESTORATION ====== ",
                    },
                },
            },
			{
                { -- Emergency Heal
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "Emergency",
                    DBV = 20,
                    ONOFF = true,
                    L = { 
                        ANY = "Emergency Healing Combo (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Nature's Swiftness + Healing Touch emergency combo.", 
                    },                     
                    M = {},
                },
			},	
			{
				{ -- Cleanse
                    E = "Checkbox", 
                    DB = "Cleanse",
                    DBV = true,
                    L = { 
                        ANY = "Cleanses", 
                    }, 
                    TT = { 
                        ANY = "Cleanse poisons/curses from targets (warning, delay not functioning correctly so may cleanse inhumanly fast).", 
                    }, 
                    M = {},
                },				
				{ -- BlanketRejuv
                    E = "Checkbox", 
                    DB = "BlanketRejuv",
                    DBV = true,
                    L = { 
                        ANY = "Blanket Rejuvenation", 
                    }, 
                    TT = { 
                        ANY = "Spread blanket rejuvenation whenever any ally is slightly hurt (usually for raid only).", 
                    }, 
                    M = {},
                },			
                { -- RejuvHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RejuvHP",
                    DBV = 80,
                    ONOFF = true,
                    L = { 
                        ANY = "Rejuvenation HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Rejuvenation. Only works if blanket mode is turned off (checkbox next to this).", 
                    },                     
                    M = {},
                },
			},	
			{
                { -- SwiftmendHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "SwiftmendHP",
                    DBV = 40,
                    ONOFF = true,
                    L = { 
                        ANY = "Swiftmend HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Swiftmend.", 
                    },                     
                    M = {},
                },
                { -- NourishHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "NourishHP",
                    DBV = 40,
                    ONOFF = true,
                    L = { 
                        ANY = "Nourish HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Nourish.", 
                    },                     
                    M = {},
                },
                { -- RegrowthHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RegrowthHP",
                    DBV = 50,
                    ONOFF = true,
                    L = { 
                        ANY = "Regrowth HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Regrowth.", 
                    },                     
                    M = {},
                },				
			},
			{
                { -- WildGrowthHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "WildGrowthHP",
                    DBV = 60,
                    ONOFF = true,
                    L = { 
                        ANY = "Wild Growth HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Wild Growth. Used in conjunction with the number of targets slider next to this one. ONLY WORKS IN DUNGEONS. MUST BE STANDING WITHIN 15 YARDS OF YOUR PARTY. CREATE A MACRO: /cast [@player] Wild Growth", 
                    },                     
                    M = {},
                },	
                { -- WildGrowthTargets
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 5,                            
                    DB = "WildGrowthTargets",
                    DBV = 4,
                    ONOFF = true,
                    L = { 
                        ANY = "Wild Growth Targets",
                    },
                    TT = { 
                        ANY = "Number of targets for Wild Growth to be used. Used in conjunction with the HP slider next to this one. ONLY WORKS IN DUNGEONS. MUST BE STANDING WITHIN 15 YARDS OF YOUR PARTY. CREATE A MACRO: /cast [@player] Wild Growth", 
                    },                     
                    M = {},
                },				
			},	
			{
                { -- TranqHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TranqHP",
                    DBV = 50,
                    ONOFF = true,
                    L = { 
                        ANY = "Tranquility HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Tranquility. Used in conjunction with the number of targets slider next to this one. ONLY WORKS IN DUNGEONS.", 
                    },                     
                    M = {},
                },
                { -- TranqHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 5,                            
                    DB = "TranqTargets",
                    DBV = 4,
                    ONOFF = true,
                    L = { 
                        ANY = "Tranquility Targets",
                    },
                    TT = { 
                        ANY = "Number of targets for Tranquility to be used. Used in conjunction with the HP slider next to this one. ONLY WORKS IN DUNGEONS.", 
                    },                     
                    M = {},
                },				
			},				
		},
}