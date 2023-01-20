--#############################
--##### TRIP'S WARLOCK UI #####
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
    DateTime = "v1.5 (25 October 2022)",
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
            { -- WARLOCK HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== WARLOCK ====== ",
                    },
                },
            },
			{
				{ -- Spec
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Affliction", value = "Affliction" },
						{ text = "Demonology", value = "Demonology" },
						{ text = "Destruction", value = "Destruction" },
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
				{ -- Pet
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Imp", value = "Imp" },
						{ text = "Voidwalker", value = "Voidwalker" },
						{ text = "Succubus", value = "Succubus" },
						{ text = "Incubus", value = "Incubus" },
						{ text = "Felhunter", value = "Felhunter" },
						{ text = "Felguard", value = "Felguard" },						
                    },
                    DB = "PetChoice",
                    DBV = "Felhunter",
                    L = { 
                        ANY = "Summon Pet",
                    }, 
                    TT = { 
                        ANY = "Pick your pet!", 
                    }, 
                    M = {},
                },					
			},
			{
				{ -- Spirit of the Dead
                    E = "Checkbox", 
                    DB = "SpiritsoftheDamned",
                    DBV = false,
                    L = { 
                        ANY = "Spirits of the Damned buff",
                    }, 
                    TT = { 
                        ANY = "Maintain Spirits of the Damned buff with T7 4-set bonus. IMPORTANT: Requires binding Rank 1 Life Tap to Sense Demons binding in GGL!"
                    }, 
                    M = {},
                },	
			},
			{
                { -- LifeTap
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "LifeTapMana",
                    DBV = 50,
                    ONOFF = true,
                    L = { 
                        ANY = "Life Tap Mana (%)",
                    },
                    TT = { 
                        ANY = "Mana (%) to use Life Tap.", 
                    },                     
                    M = {},
                },
                { -- LifeTap
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "LifeTapHP",
                    DBV = 50,
                    ONOFF = true,
                    L = { 
                        ANY = "Life Tap Health (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to stop using Life Tap.", 
                    },                     
                    M = {},
                },				
			},
			{
                { -- DrainLife
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DrainLifeHP",
                    DBV = 30,
                    ONOFF = true,
                    L = { 
                        ANY = "Drain Life Health (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Drain Life.", 
                    },                     
                    M = {},
                },	
                { -- Soulshardcap
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 30,                            
                    DB = "Soulshardcap",
                    DBV = 15,
                    ONOFF = false,
                    L = { 
                        ANY = "Soul Shards to gather",
                    },
                    TT = { 
                        ANY = "Number of Soul Shards to try and get before no longer using Drain Soul (independent of Affliction Drain Soul execute).", 
                    },                     
                    M = {},
                },				
			},			
			{
				{ -- Curse
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Agony", value = "Agony" },
						{ text = "Elements", value = "Elements" },
						{ text = "Tongues", value = "Tongues" },
						{ text = "Weakness", value = "Weakness" },	
						{ text = "Doom", value = "Doom" },						
						{ text = "Exhaustion", value = "Exhaustion" },							
                    },
                    DB = "CurseChoice",
                    DBV = "Elements",
                    L = { 
                        ANY = "Curse Choice",
                    }, 
                    TT = { 
                        ANY = "Pick your curse!", 
                    }, 
                    M = {},
                },
			},
			{
                { -- TTDCorruption
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 30,                            
                    DB = "TTDCorruption",
                    DBV = 8,
                    ONOFF = false,
                    L = { 
                        ANY = "Corruption Time To Die",
                    },
                    TT = { 
                        ANY = "Approximate amount of seconds left for target to stay alive before using Corruption.", 
                    },                     
                    M = {},
                },	
                { -- TTDImmolate
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 30,                            
                    DB = "TTDImmolate",
                    DBV = 5,
                    ONOFF = false,
                    L = { 
                        ANY = "Immolate Time To Die",
                    },
                    TT = { 
                        ANY = "Approximate amount of seconds left for target to stay alive before using Immolate.", 
                    },                     
                    M = {},
                },	
			},
			{
                { -- TTDUA
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 30,                            
                    DB = "TTDUA",
                    DBV = 8,
                    ONOFF = false,
                    L = { 
                        ANY = "Unstable Affliction Time To Die",
                    },
                    TT = { 
                        ANY = "Approximate amount of seconds left for target to stay alive before using Unstable Affliction.", 
                    },                     
                    M = {},
                },					
			},			
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },	
			{ -- MACRO LABEL
                {
                    E = "Label",
                    L = {
                        ANY = "AoE detection currently only works with pet thanks to limitations in WoW API. Please drag the following pet abilities to ANY slot on your action bar (does not need to be bound): Cleave (Felguard), Lash of Pain (Succubus/Incubus), Torment (Voidwalker), Shadow Bite (Felhunter). Currently, Felguard and Felhunter are not working due to needing updates in PetLib. If this message is still here on release, please let me know so I can check if it's updated!",
                    },
                },
            },		
			{ -- AFFLICTION HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== AFFLICTION ====== ",
                    },
                },
            },
			{ -- LABEL
                {
                    E = "Label",
                    L = {
                        ANY = "Manually target each enemy to apply DoTs (auto-target is far too wonky to be safe thanks to WoW API limitations). Seed of Corruption will only be used if your pet is in melee range and you have one of the supported spells on your action bar as above, or if you're close enough to the enemies yourself. Otherwise, simply manually spam Seed of Corruption in enemy packs.",
                    },
                },
            },			
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
			{ -- DEMONOLOGY HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== DEMONOLOGY ====== ",
                    },
                },
            },
			{ -- MACRO LABEL
                {
                    E = "Label",
                    L = {
                        ANY = "Full Metamorphosis support - recommend pressing Metamorphosis manually to activate the burst rotation. Use near melee range at the start of a big AoE pull for big numbers.",
                    },
                },
            },				
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },			
			{ -- DESTRUCTION HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== DESTRUCTION ====== ",
                    },
                },
            },
			{ -- LABEL
                {
                    E = "Label",
                    L = {
                        ANY = "Keep an eye out for the message box that warns you wen Shadowfury is about to be used so that you can get your cursor in the correct spot. If the message box is in a weird spot, you can move it around by going to the main menu (Esc) -> Interface -> AddOns -> The Action Toaster -> Show Anchor.",
                    },
                },
            },				
		},
}