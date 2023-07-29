module( "BulletLib", package.seeall )


local plyMeta = FindMetaTable( "Player" )
local Projectiles = {}
local ArmorMaterials = {}


--[[
	9mm example
	Velocity: 900
	Weight: 115
	Burn Time: 7
	Target Resistance: 50
	Damage: 45
		
	5.56 nato example
	velocity: 2750
	weight: 55
	Burn Time: 14.5
	Target Resistance: 50
	Damage: 1902.5
	
	This highlights just how important bullet resistence is. Think of it as you would body armor. You still feel the impact even if it doesn't penetrate
	and even if it does penetrate, some of the bullets power is lost after going through the armor. Obviously higher power rounds will punch through armor and retain more damage
	
	Velocity in these examples above is the lowest reported fps for real world ammo
	weight is based on lowest real world bullet grain weight
	Burn Time is the optimal barrel length to ensure all powder has been burned before the round leaves the barrel
	Target resistence is the balistic resistence of a target
	
	damage calculation formula:
		( Velocity - Weight * BurnTime ) - Resistance
		
	This is not the MOST realistic way to determine damage for bullets, but it is close while still being reasonable. If we find a better way later, then this will change
]]
function RegisterProjectile( name, velocity, weight, burnTime )
	--Registering new projectile
	Projectiles[ name ] = velocity - weight * burnTime,
	
	--Handle tracer related stuff so that we can have our tracers ready to go when ever needed
end

function RegisterArmorMaterial( name, resistence )
	--Registering new armor material
	ArmorMaterials[ name ] = resistence
end


--Our own function for firing bullets. helps handle setting up damage, tracer and other settings for us
function FireBullet( ent, bullet )
	local owner = ent:GetOwner()
	local shouldLagComp = owner:IsPlayer() and SERVER or false

	local bulletInfo = {
		Damage = Projectiles[ bullet ],
		Force = 0,
		Distance = 10000,
		Num = 1,
		Tracer = 1,
		TracerName = bullet
	}

	--setup lagcompensation here
	if shouldLagComp then owner:LagCompensation( true ) end
	ent:FireBullets( bulletInfo )
	if shouldLagComp then owner:LagCompensation( false ) end
end


--Metafunctions for getting/setting armor type and getting bullet resistence based on player's armor type
function plyMeta:GetBulletResistence()
	if self.armorType then
		return ArmorMaterials[ self.armorType ] or 0
	end

	return 0
end

function plyMeta:GetArmorType()
	return self.armorType
end

function plyMeta:SetArmorType( name )
	self.armorType = name
end


--Handle armor resistence, should also work with weapons that don't use our damage calculations. May result in other weapons doing hilariously low damage or possibly healing targets. Who knows
if SERVER then
	local initialized = false

	function Initialize()
		if initialized then return end
		initialized = true

		hook.Add( "EntityTakeDamage", "BalisticArmorCheck", function( targetm, dmginfo )
			if target:IsPlayer() and dmginfo:IsBulletDamage() then
				dmginfo:SubtractDamage( target:GetBulletResistence() )
			end
		end)
	end
end


