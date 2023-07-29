module( "BulletLib", package.seeall )


local plyMeta = FindMetaTable( "Player" )
local Projectiles = {}
local ArmorMaterials = {}


function RegisterProjectile( name, velocity, weight, burnTime )
	--Registering new projectile
	Projectiles[ name ] = velocity - weight * burnTime
	
	--Handle tracer related stuff so that we can have our tracers ready to go when ever needed
end

function RegisterArmorMaterial( name, resistence )
	--Registering new armor material
	--todo: Incorperate real world values for the armor material
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

	
	if shouldLagComp then owner:LagCompensation( true ) end
	ent:FireBullets( bulletInfo )
	if shouldLagComp then owner:LagCompensation( false ) end
end


--Metafunctions for getting/setting armor type and getting bullet resistence based on player's armor type
function plyMeta:GetBulletResistence()
	return self.armorType and ArmorMaterials[ self.armorType ] or 0
end

function plyMeta:GetArmorType()
	return self.armorType
end

function plyMeta:SetArmorType( name )
	self.armorType = name
end


if CLIENT then return end
local initialized = false

--Handle armor resistence, should also work with weapons that don't use our damage calculations. May result in other weapons doing hilariously low damage or possibly healing targets. Who knows
function Initialize()
	if initialized then return end
	initialized = true

	hook.Add( "EntityTakeDamage", "BalisticArmorCheck", function( target, dmginfo )
		if not target:IsPlayer() or not dmginfo:IsBulletDamage() then return end
		dmginfo:SubtractDamage( target:GetBulletResistence() )
	end)
end


