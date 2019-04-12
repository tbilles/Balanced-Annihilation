return {
	correcl = {
		autoheal = 2,
		buildcostenergy = 4200,
		buildcostmetal = 420,
		builddistance = 140,
		builder = true,
		shownanospray = false,
		buildpic = "CORRECL.DDS",
		buildtime = 7596,
		canassist = false,
		canmove = true,
		canresurrect = true,
		category = "UNDERWATER ALL NOWEAPON NOTAIR NOTHOVER",
		collisionvolumeoffsets = "0 -3 2",
		collisionvolumescales = "37 15 48",
		collisionvolumetype = "box",
		description = "Ressurection Sub",
		explodeas = "smallexplosiongeneric-uw",
		footprintx = 2,
		footprintz = 2,
		icontype = "sea",
		idleautoheal = 3,
		idletime = 300,
		maxdamage = 621,
		minwaterdepth = 15,
		movementclass = "UBOAT33X3",
		name = "Death Cavalry",
		objectname = "CORRECL",
		seismicsignature = 0,
		selfdestructas = "smallexplosiongenericSelfd-uw",
		sightdistance = 430,
		sonardistance = 270,
		terraformspeed = 2250,
		waterline = 17,
		workertime = 450,
		--move
		acceleration = 0.13,
		brakerate = 0.075,
		maxvelocity = 2.61,
		turninplace = true,
		turninplaceanglelimit = 140,
		turninplacespeedlimit = 1.7226,
		turnrate = 600,
		--end move
		customparams = {

		},
		sfxtypes = { 
 			pieceExplosionGenerators = { 
				"deathceg2-builder",
				"deathceg3-builder",
				"deathceg4-builder",
			},
		},
		sounds = {
			build = "nanlath1",
			canceldestruct = "cancel2",
			capture = "capture1",
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
				[1] = "suarmmov",
			},
			select = {
				[1] = "suarmsel",
			},
		},
	},
}
