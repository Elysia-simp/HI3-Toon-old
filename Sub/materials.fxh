float face_shadow_rate(float2 uv) //did some changing here and there but thanks mana
{
    // sample face shadows 
    float shadow_right = tex2D(FaceMapSampler, float2(      uv.x, uv.y)).w; 
    float shadow_left  = tex2D(FaceMapSampler, float2(1.0 - uv.x, uv.y)).w;
    //i don't get why they dedicated one whole fucking channel for this instead if just making it the whole texture like genshit
    //but who am i to question these people
    float ao = tex2D(LightMapSampler, uv).y;

    float3 head_right  = head_bone._11_12_13;
    float3 head_foward = head_bone._31_32_33;

    // calculate dot products
    float rdotl = dot((head_right.xz), -light_d.xz);
    float fdotl = dot((head_foward.xz), -light_d.xz);

    // initialize shadow
    float shadow = 1.0;

    // calculate light angle and shadow value
    if (rdotl > 0) {
        shadow = shadow_right;
    } else {
        shadow = shadow_left;
    }

    // calculate shadow step and facing step
    float shadow_step = step(abs(rdotl), ((shadow)- Shadow_range ));
    float facing_step = step(fdotl, 0);

    // return shadow step multiplied by facing step
    return shadow_step * facing_step * ao;
}

struct ColorInfo {
  float4 shadowColor;
  float4 HRRimColor;
  float4 outlineColor;
};

ColorInfo colordatabase[5] = {
  { ShadowColor0, HRRimColor0, OutlineColor0 },
  { ShadowColor1, HRRimColor1, OutlineColor1 },
  { ShadowColor2, HRRimColor2, OutlineColor2 },
  { ShadowColor3, HRRimColor3, OutlineColor3 },
  { ShadowColor4, HRRimColor4, OutlineColor4 }
}; 

void material_colors(float a, out float4 shadow_color, out float4 HRRim)
{
    int index = clamp(int((a) / 0.16f), 0, 4);
    shadow_color = use_subtexture ? colordatabase[index].shadowColor : ShadowColor0;
    HRRim = use_subtexture ? colordatabase[index].HRRimColor : HRRimColor0;
    //i couldn't make it do alpha's that are just 1.0f for whatever reason
    shadow_color = a >= 0.99 ? ShadowColor0 : shadow_color;
    HRRim = a >= 0.99 ? HRRimColor0 : HRRim;

}

float4 get_edge_color(float a)
{
    int index = clamp(int((a) / 0.16f), 0, 4);
    float4 edge_color = use_subtexture ? colordatabase[index].outlineColor : OutlineColor0;
    
    edge_color = a >= 0.99 ? OutlineColor0 : edge_color;
    return edge_color;
} //despite alpha being exactly 1.0 it doesnt work if i just a = 1.0f ? so idk

//this whole thing is a cry for help
//also i dont think this is accurate to how they did it at all LOL
//but it works just the same so who tf cares


float shadow_calc2(float ndotl, float vertexAO, float lightmapAO)
{
    float D = max(floor(vertexAO * lightmapAO + 1.5), 0.0f);
    float shadow_value = (D != 0) ? 1.25 : 1.2;
    return step(max((D * shadow_value - 0.125) * (0.5 - light_area) + 1.0, 0.0) * ndotl, 0.45);
}






float4 rimming_but_not_in_a_gay_way(float ndotv, float4 HRRim) {

    float ndotvClamped = clamp(1-ndotv, 0.001f, 1.0f);
    ndotv = pow(ndotvClamped, (0.5 * 2.0f) * (1+ RPow));
    //multiplied by 2 to avoid longhanding it
    ndotv = step(0.75, ndotv);
    return ndotv;
} //should be accurate to the decomp but also cleaned up



float4 who_am_i_kidding_theyre_all_lesbians(float ndoth,float b,float r)
{
   ndoth = use_subtexture ? max(ndoth, 0.0f) : 0.0f;
   ndoth = pow(ndoth, Shininess);
   ndoth = (r * ((b > 1-ndoth) ? 1.0f : 0.0f));
   return ndoth; //take that hoyov devs
}


#include <sub/functions.fxh> 