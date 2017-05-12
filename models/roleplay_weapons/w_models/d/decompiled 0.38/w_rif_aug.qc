// Created by Crowbar 0.38.0.0

$ModelName "weapons\pdr.mdl"

$BodyGroup "studio"
{
	studio "w_rif_aug_reference.smd"
}


$SurfaceProp "weapon"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\roleplay_weapons\pdr\"
$CDMaterials "models\roleplay_weapons\m4a1\"

$attachment "muzzle_flash" "ValveBiped.flash" 0.00 -0.30 -9.10 rotate -90 -0 0
$attachment "shell_eject" "ValveBiped.flash" -0.50 -0.30 -13.60 rotate -0 -179 -180

$CBox 0 0 0 0 0 0

$BBox -4.75 -0.767 -2.878 30.41 2.308 9.338


$Sequence "idle" {
	"w_rif_aug_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "w_rif_aug_physics.smd"
{
	$mass 95
	$inertia 1
	$damping 0.1
	$rotdamping 0.2
	$rootbone " "

}

$KeyValues
{
	prop_data 
	{
		"base" "Metal.Small"
	}
}
