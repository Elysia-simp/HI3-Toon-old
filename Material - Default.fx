#define light_area 0.51f //inverts when lower than 0.5
//could be human error but 🤷‍♀️
//this value is very much the same with ALL models so change at your risk

#define lerpbyz

//optional textures
//just uncomment the one you need
//#define ColorMask_Tex "black.png"
//#define EyeStar_Tex "black.png"

//morph names
//MAKE SURE YOU SURE IN SHIFT-JIS FOR JAPANESE NAMES
#define Blush_Morph "blush"
#define Eye_Morph "eye_star"
#define Face_Morph "FaceShadow"

//you're more than welcome to guess all these colors but most of them are in ripped material files lol

//colors
#define ColorMask_r float4(1.0f, 1.0f, 1.0f, 1.0f)
#define ColorMask_g float4(1.0f, 1.0f, 1.0f, 1.0f)

//alpha stuff 
//#define alpha_mesh
//#define alpha_outline
#define Alpha_Thresh 1.0f //i couldn't find where some characters got this value or if it was defined somewhere i never saw

//rimlight options
#define HRRimPower 1.0f
#define HRRimIntensity 1.0f

//specular
#define SpecMulti 1.0f
#define Shininess 1.0f

#define LightSpecColor float4(1.0f, 1.0f, 1.0f, 1.0f)

//shadow
#define ShadowColor0 float4(0.6f, 0.6f, 0.6f, 1.0f)
#define ShadowColor1 float4(0.6f, 0.6f, 0.6f, 1.0f)
#define ShadowColor2 float4(0.6f, 0.6f, 0.6f, 1.0f)
#define ShadowColor3 float4(0.6f, 0.6f, 0.6f, 1.0f)
#define ShadowColor4 float4(0.6f, 0.6f, 0.6f, 1.0f)

//outline color
#define OutlineColor0 float4(0.0f, 0.0f, 0.0f, 1.0f)
#define OutlineColor1 float4(0.0f, 0.0f, 0.0f, 1.0f)
#define OutlineColor2 float4(0.0f, 0.0f, 0.0f, 1.0f)
#define OutlineColor3 float4(0.0f, 0.0f, 0.0f, 1.0f)
#define OutlineColor4 float4(0.0f, 0.0f, 0.0f, 1.0f)

//rim color
#define HRRimColor0 float4(0.0f, 0.0f, 0.0f, 1.0f)
//hoyov and their infinite wisdom made HRRimColor unused entirely
//it's not even in the decomp lol rest are used tho
#define HRRimColor1 float4(0.0f, 0.0f, 0.0f, 1.0f)
#define HRRimColor2 float4(0.0f, 0.0f, 0.0f, 1.0f)
#define HRRimColor3 float4(0.0f, 0.0f, 0.0f, 1.0f)
#define HRRimColor4 float4(0.0f, 0.0f, 0.0f, 1.0f)




#include <shader.fxh>
