#define merge_strings(a,b) a##b 


texture diffuseTexture : MATERIALTEXTURE <>;
sampler diffuseSampler = sampler_state 
{
	texture = < diffuseTexture >;
	ADDRESSU = CLAMP;
	ADDRESSV = CLAMP;
};

texture LightMapTexture : MATERIALSPHEREMAP<>;
sampler LightMapSampler = sampler_state 
{
	texture = < LightMapTexture >;
	ADDRESSU = CLAMP;
	ADDRESSV = CLAMP;
};

texture FaceMapTexture : MATERIALTOONTEXTURE<>;
sampler FaceMapSampler = sampler_state 
{
	texture = < FaceMapTexture >;
	ADDRESSU = CLAMP;
	ADDRESSV = CLAMP;
};
#ifdef ColorMask_Tex
texture ColorMaskTexture : TEXTURE< string ResourceName = merge_strings("sub/textures/", ColorMask_Tex); >;
sampler ColorMaskSampler = sampler_state 
{
	texture = < ColorMaskTexture >;
	ADDRESSU = CLAMP;
	ADDRESSV = CLAMP;
};
#endif
#ifdef EyeStar_Tex
texture EyeStarTexture : TEXTURE< string ResourceName = merge_strings("sub/textures/", EyeStar_Tex); >;
sampler EyeStarSampler = sampler_state 
{
	texture = < EyeStarTexture >;
	ADDRESSU = CLAMP;
	ADDRESSV = CLAMP;
};
#endif