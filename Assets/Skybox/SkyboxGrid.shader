Shader "Skybox/Grid"
{
    Properties
    {
        _Intensity ("Intensity Amplifier", Float) = 1.0
    }

    CGINCLUDE

    #include "UnityCG.cginc"
    
    #define PI 3.141592653589793

    struct appdata
    {
        float4 position : POSITION;
        float3 texcoord : TEXCOORD0;
    };
    
    struct v2f
    {
        float4 position : SV_POSITION;
        float3 texcoord : TEXCOORD0;
    };
    
    half _Intensity;
    
    v2f vert (appdata v)
    {
        v2f o;
        o.position = UnityObjectToClipPos (v.position);
        o.texcoord = v.texcoord;
        return o;
    }
    
    half4 frag (v2f i) : COLOR
    {
        float u = atan2(i.texcoord.z, i.texcoord.x) / PI;
        float v = acos(i.texcoord.y) / PI;
        float uu = abs(frac(u * 20) - 0.5);
        float vv = abs(frac(v * 20) - 0.5);
        float a = 0.01 / uu + 0.01 / vv;
        a *= _Intensity;
        return half4(a, a, a, 1.0);
    }

    ENDCG

    SubShader
    {
        Tags { "RenderType"="Background" "Queue"="Background" }
        Pass
        {
            ZWrite Off
            Cull Off
            Fog { Mode Off }
            CGPROGRAM
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
        }
    } 
}