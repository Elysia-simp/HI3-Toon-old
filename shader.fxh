
//includes
#include <sub/header.fxh>
#include <sub/controllers.fxh>
#include <sub/materials.fxh>

//base structure
struct vs_in
{
    float4 pos          : POSITION;
    float3 normal       : NORMAL;
    float2 uv           : TEXCOORD0;
    float2 uv2          : TEXCOORD1;
    float4 vertex       : TEXCOORD2; 
};


struct vs_out
{
    float4 pos          : POSITION;
    float2 uv           : TEXCOORD0;
    float4 vertex       : TEXCOORD1;
    float2 uv2          : TEXCOORD4;
    float3 normal       : TEXCOORD2;
    float3 view         : TEXCOORD3;
};

struct edge_in
{
    float4 pos          : POSITION; 
    float3 normal       : NORMAL;
    float2 uv           : TEXCOORD0;
    float4 vertex       : TEXCOORD2;
};

struct edge_out
{
    float4 pos          : POSITION; 
    float2 uv           : TEXCOORD0;
    float4 vertex       : TEXCOORD3;
    float3 view         : TEXCOORD4;
};

edge_out vs_edge (edge_in i)
{
    edge_out o = (edge_out)0;
    float4 mView = mul(i.pos, mul(model_world, mmd_view));
    float viewDepth = mView.z / mView.w * 0.03;
    viewDepth = clamp(viewDepth, 1, 300); //it's only so high cause i didnt want it to be small when up close
    o.vertex = i.vertex;
    o.uv = i.uv;
    o.view = normalize(mmd_cameraPosition - mul(i.pos.xyz, (float3x3)mmd_world));
    float4 vViewPosition = mul(i.pos, mul(model_world, mmd_view));
    float offset = outlineOffset(vViewPosition)* i.vertex.r;

    i.pos.xyz += i.normal.xyz * offset * i.vertex.a * viewDepth;
    i.pos.z *= i.pos.w; // i actually have no idea what this does i just see them do it
    o.pos = mul(i.pos, mmd_wvp);
    return o; 
}

vs_out vs_model ( vs_in i)
{
    vs_out o = (vs_out)0; //you're not mentally sane if you write this as INPUT/OUTPUT
    o.pos = mul(i.pos, mmd_wvp);
    o.uv = i.uv;
    o.uv2 = i.uv2;
    o.vertex = i.vertex;
	o.normal = normalize(mul((float3x3) mmd_world, i.normal));
    o.view = normalize(mmd_cameraPosition - mul(i.pos.xyz, (float3x3)mmd_world));
    return o;
}

//initialize colors
float4 ps_edge(edge_out i) : COLOR0
{
    float4 color = get_edge_color(tex2D(LightMapSampler, i.uv).a);
    if(i.vertex.a <= 0.05) //alpha meshes don't use vertex colors and i'm not fighting with it
    {
        discard;
    } //one of the VERY few if else's you'll see
    #ifdef alpha_outline
    color.a = tex2D(diffuseSampler, i.uv).a;
    #endif
    //color.rgb = Saturate_Col(color.rgb, 1 + Sat_Slider_add - Sat_Slider_sub);
    return color * egColor;
}

float4 ps_model(vs_out i, float vface : VFACE, uniform bool use_uv2) : COLOR0
{
    
    //lightdirection check
    light_d = (light_check) ? light_bone._11_12_13 : light_d;
    //this is an actual function in the game
    float2 uv = use_uv2 ? i.uv2 : i.uv;
    //im not sure how this'll look compiled in say unity or whatever
    //but this is basically short handing if else
    //would compile faster supposively
    
    float3 normal = i.normal;
    normal.z *= vface; //they actually flip the whole thing
    //but im not them
    float3 view = i.view;
    float3 h = normalize(view + -light_d);
    float4 vertex = i.vertex;


    //
    float4 color = 1;

    float4 diffuse = tex2D(diffuseSampler, uv);
    float4 lightmap = tex2D(LightMapSampler, uv);

    lightmap =  use_spheremap ? lightmap : float4(1.0f,0.45f,0.0f,1.0f); //mmd flag

    float4 shad_color, HRRim;
    material_colors(lightmap.a, shad_color, HRRim);
    //dots
    float ndotl = dot(light_d, normal) * 0.5 + 0.5; //the second 0.5 was light_area
    //but i'm not hoyo and that value is typically at 0.51 anyways

    float Toon = !use_subtexture ? face_shadow_rate(uv) : shadow_calc2(ndotl, vertex.r, lightmap.g);

    float ndotv = dot(normal, view);
    ndotv *= (1 + RRange_add - RRange_sub);
    ndotv = rimming_but_not_in_a_gay_way(ndotv, HRRim);
    ndotv *= HRRimIntensity;

    float4 rim_color = float4(1+Rim_R, 1+Rim_G, 1+Rim_B, 1.0f);
    float3 ndoth = dot(normal, h);
    ndoth = who_am_i_kidding_theyre_all_lesbians(ndoth, lightmap.b, lightmap.r);
    color.rgb = diffuse.rgb * vertex.r;
    //morph colors
    float4 blush = ColorMask_r * Blush_Slider;

    #ifdef ColorMask_Tex
    float4 mask = tex2D(ColorMaskSampler, uv);
    color.rgb = lerp(color.rgb, color.rgb * ColorMask_r, (mask.r * Blush_Slider * 0.35));
    color.rgb = lerp(color.rgb, color.rgb * ColorMask_g, (mask.g * Face_Slider));
    #endif

    #ifdef EyeStar_Tex
    float4 eye = tex2D(EyeStarSampler, scaleUV(uv, 2.3f));
    color.rgb = lerp(color.rgb, eye.rgb, eye.a * Eye_Slider);
    #endif

    color.rgb = lerp(color.rgb.rgb * shad_color.rgb, color.rgb.rgb, saturate(Toon + (0.5 + ShadowInt_add - ShadowInt_sub)); //can't find out how they actually did it
    //for now

    color.rgb += ((ndotv * rim_color) * (HRRim)) * i.vertex.b + (ndoth * saturate(LightSpecColor * SpecMulti) *lightmap.b);

    color.rgb *= (ray_valid) ? 0.66f : 1.0f;
    //this might look stupid
    //but raycast does actually color correct this lol

    #ifdef alpha_mesh
    color.a = diffuse.a * Alpha_Thresh; //honkai actually use the alpha channel for what it's intended for sometimes
    //though some genshin models actually use this
    #endif
    color.rgb = Saturate_Col(color.rgb, 1 + (Sat_Slider_add) - (Sat_Slider_sub));
    //color.rgb = Toon;
    return color * egColor;
}

technique model_SS_tech <string MMDPASS = "object_ss"; >
{
    #ifdef uv2_Backface
    pass main
    {   cullmode = cw;
        #ifdef alpha_mesh
        AlphaBlendEnable = true;
        #endif        
        ZFunc = LESS;
        VertexShader = compile vs_3_0 vs_model();
        PixelShader = compile ps_3_0 ps_model(true);
    }
    #endif
    pass main
    {   cullmode = none;
        #ifdef uv2_Backface
        cullmode = ccw;
        #endif
        #ifdef alpha_mesh
        AlphaBlendEnable = true;
        #endif        
        ZFunc = LESS;
        VertexShader = compile vs_3_0 vs_model();
        PixelShader = compile ps_3_0 ps_model(false);
    }
    pass edge
    {
        cullmode = cw;
        ZFunc = LESS;
        VertexShader = compile vs_3_0 vs_edge();
        PixelShader = compile ps_3_0 ps_edge();
    }

}

technique model_tech <string MMDPASS = "object"; >
{
    #ifdef uv2_Backface
    pass main
    {   cullmode = cw;
        #ifdef alpha_mesh
        AlphaBlendEnable = true;
        #endif        
        ZFunc = LESS;
        VertexShader = compile vs_3_0 vs_model();
        PixelShader = compile ps_3_0 ps_model(true);
    }
    #endif
    pass main
    {   cullmode = none;
        #ifdef uv2_Backface
        cullmode = ccw;
        #endif
        #ifdef alpha_mesh
        AlphaBlendEnable = true;
        #endif        
        ZFunc = LESS;
        VertexShader = compile vs_3_0 vs_model();
        PixelShader = compile ps_3_0 ps_model(false);
    }
    pass edge
    {
        cullmode = cw;
        ZFunc = LESS;
        VertexShader = compile vs_3_0 vs_edge();
        PixelShader = compile ps_3_0 ps_edge();
    }

}

technique tech_edge < string MMDPass = "edge"; > //i don't use it
{
}
