// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "test03"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_snow__normal("snow__normal", 2D) = "bump" {}
		_snow_metallic("snow_metallic", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_snow_roughness("snow_roughness", 2D) = "white" {}
		_snowbasecolor("snowbasecolor", 2D) = "white" {}
		_base_color("base_color", 2D) = "white" {}
		_Ice_basecolor("Ice_basecolor", 2D) = "white" {}
		_Ice_normal("Ice_normal", 2D) = "bump" {}
		_Ice_roughness("Ice_roughness", 2D) = "white" {}
		_Ice_oppacity1("Ice_oppacity 1", 2D) = "white" {}
		_snow("snow", Range( 0 , 1)) = 1
		_ice("ice", Range( 0 , 1)) = 1
		_normal("normal", 2D) = "white" {}
		_roughness("roughness", 2D) = "white" {}
		_metallic("metallic", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _normal;
		uniform float4 _normal_ST;
		uniform sampler2D _Ice_normal;
		uniform float4 _Ice_normal_ST;
		uniform float _ice;
		uniform sampler2D _snow__normal;
		uniform float4 _snow__normal_ST;
		uniform float _snow;
		uniform sampler2D _snowbasecolor;
		uniform float4 _snowbasecolor_ST;
		uniform sampler2D _base_color;
		uniform float4 _base_color_ST;
		uniform sampler2D _Ice_basecolor;
		uniform float4 _Ice_basecolor_ST;
		uniform sampler2D _metallic;
		uniform float4 _metallic_ST;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _snow_metallic;
		uniform float4 _snow_metallic_ST;
		uniform sampler2D _roughness;
		uniform float4 _roughness_ST;
		uniform sampler2D _Ice_roughness;
		uniform float4 _Ice_roughness_ST;
		uniform sampler2D _snow_roughness;
		uniform float4 _snow_roughness_ST;
		uniform sampler2D _Ice_oppacity1;
		uniform float4 _Ice_oppacity1_ST;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_normal = i.uv_texcoord * _normal_ST.xy + _normal_ST.zw;
			float2 uv_Ice_normal = i.uv_texcoord * _Ice_normal_ST.xy + _Ice_normal_ST.zw;
			float4 lerpResult21 = lerp( tex2D( _normal, uv_normal ) , float4( UnpackNormal( tex2D( _Ice_normal, uv_Ice_normal ) ) , 0.0 ) , _ice);
			float2 uv_snow__normal = i.uv_texcoord * _snow__normal_ST.xy + _snow__normal_ST.zw;
			float2 uv_snowbasecolor = i.uv_texcoord * _snowbasecolor_ST.xy + _snowbasecolor_ST.zw;
			float4 tex2DNode6 = tex2D( _snowbasecolor, uv_snowbasecolor );
			float4 temp_output_19_0 = ( _snow * tex2DNode6 );
			float4 lerpResult27 = lerp( lerpResult21 , float4( UnpackNormal( tex2D( _snow__normal, uv_snow__normal ) ) , 0.0 ) , temp_output_19_0);
			o.Normal = lerpResult27.rgb;
			float2 uv_base_color = i.uv_texcoord * _base_color_ST.xy + _base_color_ST.zw;
			float2 uv_Ice_basecolor = i.uv_texcoord * _Ice_basecolor_ST.xy + _Ice_basecolor_ST.zw;
			float4 tex2DNode8 = tex2D( _Ice_basecolor, uv_Ice_basecolor );
			float4 temp_output_17_0 = ( _ice * tex2DNode8 );
			float4 lerpResult15 = lerp( tex2D( _base_color, uv_base_color ) , tex2DNode8 , temp_output_17_0);
			float4 lerpResult18 = lerp( lerpResult15 , tex2DNode6 , temp_output_19_0);
			o.Albedo = lerpResult18.rgb;
			float2 uv_metallic = i.uv_texcoord * _metallic_ST.xy + _metallic_ST.zw;
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 lerpResult38 = lerp( tex2D( _metallic, uv_metallic ) , tex2D( _TextureSample0, uv_TextureSample0 ) , temp_output_17_0);
			float2 uv_snow_metallic = i.uv_texcoord * _snow_metallic_ST.xy + _snow_metallic_ST.zw;
			float4 lerpResult36 = lerp( lerpResult38 , tex2D( _snow_metallic, uv_snow_metallic ) , temp_output_19_0);
			o.Metallic = lerpResult36.r;
			float2 uv_roughness = i.uv_texcoord * _roughness_ST.xy + _roughness_ST.zw;
			float2 uv_Ice_roughness = i.uv_texcoord * _Ice_roughness_ST.xy + _Ice_roughness_ST.zw;
			float4 lerpResult28 = lerp( tex2D( _roughness, uv_roughness ) , tex2D( _Ice_roughness, uv_Ice_roughness ) , temp_output_17_0);
			float2 uv_snow_roughness = i.uv_texcoord * _snow_roughness_ST.xy + _snow_roughness_ST.zw;
			float4 lerpResult31 = lerp( lerpResult28 , tex2D( _snow_roughness, uv_snow_roughness ) , temp_output_19_0);
			o.Smoothness = lerpResult31.r;
			o.Alpha = 1;
			float2 uv_Ice_oppacity1 = i.uv_texcoord * _Ice_oppacity1_ST.xy + _Ice_oppacity1_ST.zw;
			clip( tex2D( _Ice_oppacity1, uv_Ice_oppacity1 ).r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16100
56;417;1906;731;2278.877;345.7084;1.673898;True;True
Node;AmplifyShaderEditor.CommentaryNode;25;-3836.843,-1363.801;Float;False;1113.863;2180.021;map_snow_ice;7;5;14;13;1;11;6;8;;0.9056604,0,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-2290.769,-706.1752;Float;False;Property;_ice;ice;12;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;23;-1387.248,-1958.913;Float;False;1627.71;883.8248;texture_objet;4;22;7;30;35;;0,1,0.5162258,1;0;0
Node;AmplifyShaderEditor.SamplerNode;8;-3492.771,-1306.91;Float;True;Property;_Ice_basecolor;Ice_basecolor;7;0;Create;True;0;0;False;0;78f701e11125cff4b91e606f4167598b;ac1b7c7af9f9da04b98d37c80b865b7c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-2133.059,-312.2347;Float;False;Property;_snow;snow;11;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-3471.196,-1089.258;Float;True;Property;_snowbasecolor;snowbasecolor;5;0;Create;True;0;0;False;0;84dea5868f3f1ac4aa5eccbd6f6cec23;84dea5868f3f1ac4aa5eccbd6f6cec23;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-3398.92,163.7586;Float;True;Property;_Ice_roughness;Ice_roughness;9;0;Create;True;0;0;False;0;6c86bffc4f167eb41ba1061ad5425994;6c86bffc4f167eb41ba1061ad5425994;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;30;-1340.431,-1435.076;Float;True;Property;_roughness;roughness;14;0;Create;True;0;0;False;0;None;ae457e1c85fba234483dfbd144088f0f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;22;-1353.727,-1654.169;Float;True;Property;_normal;normal;13;0;Create;True;0;0;False;0;None;9a4a55d8d2e54394d97426434477cdcf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-3431.594,-800.0709;Float;True;Property;_Ice_normal;Ice_normal;8;0;Create;True;0;0;False;0;ce914e537ec9da34e8bfd84084772056;ce914e537ec9da34e8bfd84084772056;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-1363.991,-1909.828;Float;True;Property;_base_color;base_color;6;0;Create;True;0;0;False;0;80ab37a9e4f49c842903bb43bdd7bcd2;80ab37a9e4f49c842903bb43bdd7bcd2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-1922.924,-927.9163;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;37;-1543.564,163.7103;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;56c250f6bbe6bb94cb5ae32a26c824ff;56c250f6bbe6bb94cb5ae32a26c824ff;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;35;-784.0178,-1734.161;Float;True;Property;_metallic;metallic;15;0;Create;True;0;0;False;0;None;2665c395410e391469e722b3071ed218;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-1413.025,-640.1215;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;21;-899.2032,-499.5004;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;15;-785.3845,-1041.464;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;28;-1549.148,-149.2866;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;24;-52.48314,-579.405;Float;False;1227.469;1248.849;blend_final;3;18;27;31;;1,0,0,1;0;0
Node;AmplifyShaderEditor.LerpOp;38;-952.8858,192.744;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-3406.03,-557.8187;Float;True;Property;_snow__normal;snow__normal;1;0;Create;True;0;0;False;0;4952f474d55b5944f893ccec44776491;4952f474d55b5944f893ccec44776491;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-3389.772,385.0278;Float;True;Property;_snow_roughness;snow_roughness;4;0;Create;True;0;0;False;0;b54e94ddfcb9d4b49839de66db28406e;b54e94ddfcb9d4b49839de66db28406e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-1547.454,412.3145;Float;True;Property;_snow_metallic;snow_metallic;2;0;Create;True;0;0;False;0;56c250f6bbe6bb94cb5ae32a26c824ff;56c250f6bbe6bb94cb5ae32a26c824ff;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;13;-3414.885,-67.33741;Float;True;Property;_Ice_oppacity1;Ice_oppacity 1;10;0;Create;True;0;0;False;0;81161af1bacc4a74db36d3d7d698f82d;ac1b7c7af9f9da04b98d37c80b865b7c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;18;0.8510704,-504.5247;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;27;-30.04467,-180.7874;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;36;-438.5816,353.3172;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;31;11.40694,72.36525;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1601.425,-17.88978;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;test03;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Transparent;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;16;0
WireConnection;17;1;8;0
WireConnection;19;0;20;0
WireConnection;19;1;6;0
WireConnection;21;0;22;0
WireConnection;21;1;11;0
WireConnection;21;2;16;0
WireConnection;15;0;7;0
WireConnection;15;1;8;0
WireConnection;15;2;17;0
WireConnection;28;0;30;0
WireConnection;28;1;14;0
WireConnection;28;2;17;0
WireConnection;38;0;35;0
WireConnection;38;1;37;0
WireConnection;38;2;17;0
WireConnection;18;0;15;0
WireConnection;18;1;6;0
WireConnection;18;2;19;0
WireConnection;27;0;21;0
WireConnection;27;1;1;0
WireConnection;27;2;19;0
WireConnection;36;0;38;0
WireConnection;36;1;3;0
WireConnection;36;2;19;0
WireConnection;31;0;28;0
WireConnection;31;1;5;0
WireConnection;31;2;19;0
WireConnection;0;0;18;0
WireConnection;0;1;27;0
WireConnection;0;3;36;0
WireConnection;0;4;31;0
WireConnection;0;10;13;0
ASEEND*/
//CHKSM=873F8A9774F7AD2DA56DBA2BDA7CF748016C7F2D