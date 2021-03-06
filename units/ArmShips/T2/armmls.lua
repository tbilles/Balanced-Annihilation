return {
	armmls = {
		acceleration = 0.05,
		brakerate = 0.21,
		buildcostenergy = 3973,
		buildcostmetal = 227,
		builddistance = 136,
		builder = true,
		buildpic = "ARMMLS.DDS",
		buildtime = 5247,
		canmove = true,
		category = "ALL NOTSUB MINELAYER SHIP NOWEAPON NOTAIR NOTHOVER SURFACE",
		collisionvolumeoffsets = "0 -7 2",
		collisionvolumescales = "25 25 66",
		collisionvolumetype = "CylZ",
		corpse = "DEAD",
		description = "Naval Engineer",
		energymake = 0.5,
		energyuse = 0.5,
		explodeas = "mediumexplosiongeneric",
		floater = true,
		footprintx = 3,
		footprintz = 3,
		icontype = "sea",
		idleautoheal = 5,
		idletime = 1800,
		maxdamage = 1314,
		maxvelocity = 2.4,
		minwaterdepth = 15,
		movementclass = "BOAT44X4",
		name = "Valiant",
		objectname = "ARMMLS",
		seismicsignature = 0,
		selfdestructas = "mediumexplosiongenericSelfd",
		shownanospray = false,
		sightdistance = 260,
		terraformspeed = 2000,
		turninplace = false,
		turninplaceanglelimit = 140,
		turnrate = 388,
		waterline = 2,
		workertime = 400,
		buildoptions = {
			[1] = "armtide",
			[2] = "armuwmex",
			[3] = "armfrad",
			[4] = "armsy",
			[5] = "armcs",
			[6] = "armamsub",
			[7] = "armfrad",
			[8] = "armtl",
			[9] = "armfhlt",
			[10] = "armfflak",
			[11] = "armpt",
			[12] = "armdecade",
			[13] = "armroy",
			[14] = "armamph",
			[15] = "armfmine3",
		},
		customparams = {
			area_mex_def = "armuwmex",
			subfolder = "armships/t2",
			techlevel = 2,
		},
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "0.0 -1.85327148436e-05 2.73946380615",
				collisionvolumescales = "37.140838623 18.7893829346 66.6114349365",
				collisionvolumetype = "Box",
				damage = 788,
				description = "Valiant Wreckage",
				energy = 0,
				featuredead = "HEAP",
				featurereclamate = "SMUDGE01",
				footprintx = 4,
				footprintz = 4,
				height = 20,
				hitdensity = 100,
				metal = 138,
				object = "ARMMLS_DEAD",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				collisionvolumescales = "85.0 14.0 6.0",
				collisionvolumetype = "cylY",
				damage = 2016,
				description = "Valiant Heap",
				energy = 0,
				footprintx = 2,
				footprintz = 2,
				height = 4,
				hitdensity = 100,
				metal = 66,
				object = "4X4A",
				reclaimable = true,
				resurrectable = 0,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
		},
		sfxtypes = {
			pieceexplosiongenerators = {
				[1] = "deathceg2",
				[2] = "deathceg3",
				[3] = "deathceg4",
			},
		},
		sounds = {
			build = "nanlath1",
			canceldestruct = "cancel2",
			repair = "repair1",
			underattack = "warning1",
			working = "reclaim1",
			cant = {
				[1] = "cantdo4",
			},
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			ok = {
				[1] = "sharmmov",
			},
			select = {
				[1] = "sharmsel",
			},
		},
	},
}
