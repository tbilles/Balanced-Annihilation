return {
	armlab = {
		acceleration = 0,
		brakerate = 0,
		buildangle = 1024,
		buildcostenergy = 1200,
		buildcostmetal = 650,
		builder = true,
		buildinggrounddecaldecayspeed = 30,
		buildinggrounddecalsizex = 9,
		buildinggrounddecalsizey = 9,
		buildinggrounddecaltype = "decals/armlab_aoplane.dds",
		buildpic = "ARMLAB.DDS",
		buildtime = 6500,
		canmove = true,
		category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR NOTHOVER SURFACE",
		collisionvolumeoffsets = "0 -1 0",
		collisionvolumescales = "95 22 95",
		collisionvolumetype = "Box",
		corpse = "DEAD",
		description = "Produces Level 1 Kbots",
		energystorage = 100,
		explodeas = "largeBuildingexplosiongeneric",
		footprintx = 6,
		footprintz = 6,
		icontype = "building",
		idleautoheal = 5,
		idletime = 1800,
		maxdamage = 2600,
		maxslope = 15,
		maxwaterdepth = 0,
		metalstorage = 100,
		name = "Kbot Lab",
		objectname = "ARMLAB",
		radardistance = 50,
		seismicsignature = 0,
		selfdestructas = "largeBuildingExplosionGenericSelfd",
		shownanospray = false,
		sightdistance = 290,
		terraformspeed = 500,
		usebuildinggrounddecal = true,
		workertime = 100,
		yardmap = "occccooccccooccccooccccooccccoocccco",
		buildoptions = {
			[1] = "armck",
			[2] = "armpw",
			[3] = "armrectr",
			[4] = "armrock",
			[5] = "armham",
			[6] = "armjeth",
			[7] = "armwar",
			[8] = "armflea",
		},
		customparams = {
			bar_collisionvolumescales = "95 22 95",
			bar_yardmap = "oooooooooooooooooocccccccccccccccccc",
			model_author = "Cremuss",
			subfolder = "armbuildings/landfactories",
		},
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "0 -7 0",
				collisionvolumescales = "95 22 95",
				collisionvolumetype = "Box",
				damage = 1614,
				description = "Kbot Lab Wreckage",
				energy = 0,
				featuredead = "HEAP",
				featurereclamate = "SMUDGE01",
				footprintx = 5,
				footprintz = 6,
				height = 40,
				hitdensity = 100,
				metal = 458,
				object = "ARMLAB_DEAD",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 807,
				description = "Kbot Lab Heap",
				energy = 0,
				featurereclamate = "SMUDGE01",
				footprintx = 5,
				footprintz = 5,
				height = 4,
				hitdensity = 100,
				metal = 183,
				object = "5X5B",
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
			canceldestruct = "cancel2",
			underattack = "warning1",
			unitcomplete = "untdone",
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			select = {
				[1] = "plabactv",
			},
		},
	},
}
