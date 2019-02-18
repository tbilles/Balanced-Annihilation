return {
	armuwms = {
		acceleration = 0,
		brakerate = 0,
		buildangle = 8192,
		buildcostenergy = 1200,
		buildcostmetal = 400,
		buildinggrounddecaldecayspeed = 30,
		buildinggrounddecalsizex = 6,
		buildinggrounddecalsizey = 6,
		buildinggrounddecaltype = "decals/armuwms_aoplane.dds",
		buildpic = "ARMUWMS.DDS",
		buildtime = 3741,
		canrepeat = false,
		category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR NOTHOVER SURFACE UNDERWATER",
		corpse = "DEAD",
		description = "Increases Metal Storage (3000)",
		explodeas = "largeBuildingexplosiongeneric-uw",
		footprintx = 4,
		footprintz = 4,
		icontype = "building",
		idleautoheal = 5,
		idletime = 1800,
		maxdamage = 3250,
		maxslope = 20,
		metalstorage = 3000,
		minwaterdepth = 31,
		name = "Underwater Metal Storage",
		objectname = "ARMUWMS",
		seismicsignature = 0,
		selfdestructas = "largeBuildingExplosionGenericSelfd-uw",
		sightdistance = 182,
		usebuildinggrounddecal = true,
		yardmap = "oooooooooooooooo",
		customparams = {
			bar_buildinggrounddecalsizex = 4,
			bar_buildinggrounddecalsizey = 3.6,
			model_author = "FireStorm",
			removestop = true,
			removewait = true,
			subfolder = "armbuildings/seaeconomy",
		},
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "0.0 0.0 0.0956878662109",
				collisionvolumescales = "62.4999694824 41.0 75.6147460938",
				collisionvolumetype = "Box",
				damage = 1950,
				description = "Underwater Metal Storage Wreckage",
				energy = 0,
				featuredead = "HEAP",
				footprintx = 4,
				footprintz = 4,
				height = 20,
				hitdensity = 100,
				metal = 234,
				object = "ARMUWMS_DEAD",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				collisionvolumescales = "85.0 14.0 6.0",
				collisionvolumetype = "cylY",
				damage = 975,
				description = "Underwater Metal Storage Heap",
				energy = 0,
				footprintx = 4,
				footprintz = 4,
				height = 4,
				hitdensity = 100,
				metal = 94,
				object = "4X4B",
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
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			select = {
				[1] = "stormtl1",
			},
		},
	},
}
