float2 scaleUV(float2 uv, float scale) //for eyestar
{
    float2 center = 0.5f;
    float2 offset = uv - center;
    offset *= scale;
    return offset + center;
}

float3 Saturate_Col(float3 color, float saturation)
{
    float3 gray = dot(color, float4(0.299, 0.587, 0.114, 0));
    return lerp(gray, color, saturation);
}


//honkai starrail functions
float3 outlineWidthAdjustZs = float3(0.01, 150., 200.);
float3 outlineWidthAdjustScales = float3(0.105, 0.2, .3);

float lerpByZ(float startScale, float endScale, float startZ, float endZ, float z){
   float t = (z - startZ) / max(endZ - startZ, 0.001);
   t = clamp(t,0.0f,1.0f);
   return lerp(startScale, endScale, t);
}

float outlineOffset(float z){ //couldnt get the same fov scaling working for whatever reason
   float2 zRange, scales;
   if (z < outlineWidthAdjustZs.y){
      zRange = outlineWidthAdjustZs.xy;
      scales = outlineWidthAdjustScales.xy;
   }else{
      zRange = outlineWidthAdjustZs.yz;
      scales = outlineWidthAdjustScales.yz;
   }
   float scale = lerpByZ(scales.x + 0.015, scales.y, zRange.x, zRange.y, z);
  return scale*.4971002;
}

