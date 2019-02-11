// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ice_snow_shader"
{
	Properties
	{
		_Ice_basecolor("Ice_basecolor", 2D) = "white" {}
		_Ice_normal("Ice_normal", 2D) = "bump" {}
		_Ice_roughness("Ice_roughness", 2D) = "white" {}
		_snow__normal("snow__normal", 2D) = "bump" {}
		_SnowD("SnowD", Range( 0 , 1)) = 1
		_IceD("IceD", Range( 0 , 1)) = 1
		_snow_roughness("snow_roughness", 2D) = "white" {}
		_snowbasecolor("snowbasecolor", 2D) = "white" {}
		_Texture0("Texture 0", 2D) = "white" {}
		_Normal_object("Normal_object", 2D) = "white" {}
		_base_color_object("base_color_object", 2D) = "white" {}
		_texture_roughness("texture_roughness", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal_object;
		uniform float4 _Normal_object_ST;
		uniform sampler2D _Ice_normal;
		uniform float4 _Ice_normal_ST;
		uniform sampler2D _snow__normal;
		uniform float4 _snow__normal_ST;
		uniform float _SnowD;
		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform float _IceD;
		uniform sampler2D _base_color_object;
		uniform float4 _base_color_object_ST;
		uniform sampler2D _Ice_basecolor;
		uniform float4 _Ice_basecolor_ST;
		uniform sampler2D _snowbasecolor;
		uniform float4 _snowbasecolor_ST;
		uniform sampler2D _texture_roughness;
		uniform float4 _texture_roughness_ST;
		uniform sampler2D _Ice_roughness;
		uniform float4 _Ice_roughness_ST;
		uniform sampler2D _snow_roughness;
		uniform float4 _snow_roughness_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal_object = i.uv_texcoord * _Normal_object_ST.xy + _Normal_object_ST.zw;
			float2 uv_Ice_normal = i.uv_texcoord * _Ice_normal_ST.xy + _Ice_normal_ST.zw;
			float2 uv_snow__normal = i.uv_texcoord * _snow__normal_ST.xy + _snow__normal_ST.zw;
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float clampResult60 = clamp( floor( ( _SnowD + pow( tex2D( _Texture0, uv_Texture0 ).r , 1.0 ) ) ) , 0.0 , 1.0 );
			float3 lerpResult56 = lerp( UnpackNormal( tex2D( _Ice_normal, uv_Ice_normal ) ) , UnpackNormal( tex2D( _snow__normal, uv_snow__normal ) ) , clampResult60);
			float clampResult74 = clamp( floor( ( _IceD + pow( tex2D( _Texture0, uv_Texture0 ).r , 1.0 ) ) ) , 0.0 , 1.0 );
			float4 lerpResult77 = lerp( tex2D( _Normal_object, uv_Normal_object ) , float4( lerpResult56 , 0.0 ) , clampResult74);
			o.Normal = lerpResult77.rgb;
			float2 uv_base_color_object = i.uv_texcoord * _base_color_object_ST.xy + _base_color_object_ST.zw;
			float2 uv_Ice_basecolor = i.uv_texcoord * _Ice_basecolor_ST.xy + _Ice_basecolor_ST.zw;
			float2 uv_snowbasecolor = i.uv_texcoord * _snowbasecolor_ST.xy + _snowbasecolor_ST.zw;
			float4 lerpResult57 = lerp( tex2D( _Ice_basecolor, uv_Ice_basecolor ) , tex2D( _snowbasecolor, uv_snowbasecolor ) , clampResult60);
			float4 lerpResult76 = lerp( tex2D( _base_color_object, uv_base_color_object ) , lerpResult57 , clampResult74);
			o.Albedo = lerpResult76.rgb;
			o.Metallic = 0.0;
			float2 uv_texture_roughness = i.uv_texcoord * _texture_roughness_ST.xy + _texture_roughness_ST.zw;
			float2 uv_Ice_roughness = i.uv_texcoord * _Ice_roughness_ST.xy + _Ice_roughness_ST.zw;
			float2 uv_snow_roughness = i.uv_texcoord * _snow_roughness_ST.xy + _snow_roughness_ST.zw;
			float4 lerpResult55 = lerp( tex2D( _Ice_roughness, uv_Ice_roughness ) , tex2D( _snow_roughness, uv_snow_roughness ) , clampResult60);
			float4 lerpResult78 = lerp( tex2D( _texture_roughness, uv_texture_roughness ) , lerpResult55 , clampResult74);
			o.Smoothness = lerpResult78.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16100
7;23;1906;1010;-1456.371;-969.7083;1.164869;True;True
Node;AmplifyShaderEditor.TexturePropertyNode;79;-967.8931,525.2252;Float;True;Property;_Texture0;Texture 0;9;0;Create;True;0;0;False;0;8316c649b12f4485c811d707f6316577;8316c649b12f4485c811d707f6316577;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;65;-650.5732,7.954464;Float;False;1093.444;462.9209;DisolvSnow;9;54;53;63;60;58;59;52;61;62;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;66;-486.4206,863.9463;Float;False;1093.444;462.9209;Disolvice;9;75;74;73;72;71;70;69;68;67;;1,0,0,1;0;0
Node;AmplifyShaderEditor.SamplerNode;52;-600.5731,240.8753;Float;True;Property;_DisolvNoise;DisolvNoise;5;0;Create;True;0;0;False;0;8316c649b12f4485c811d707f6316577;8316c649b12f4485c811d707f6316577;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;59;-307.3193,263.425;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;67;-436.4206,1098.861;Float;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;False;0;8316c649b12f4485c811d707f6316577;8316c649b12f4485c811d707f6316577;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;54;-599.3646,57.95446;Float;False;Property;_SnowD;SnowD;4;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;68;-143.1671,1119.417;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;53;-138.7707,185.731;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-435.2121,913.9464;Float;False;Property;_IceD;IceD;5;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;36.98276,252.8714;Float;False;Constant;_Float1;Float 1;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;70;25.38165,1041.723;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;42.56926,329.9287;Float;False;Constant;_Float2;Float 2;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;63;36.72766,180.4707;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;676.1093,685.9725;Float;True;Property;_Ice_roughness;Ice_roughness;2;0;Create;True;0;0;False;0;6c86bffc4f167eb41ba1061ad5425994;6c86bffc4f167eb41ba1061ad5425994;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;60;267.8714,226.227;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;206.7215,1185.92;Float;False;Constant;_Float5;Float 5;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;46;659.3905,-241.902;Float;True;Property;_snow__normal;snow__normal;3;0;Create;True;0;0;False;0;4952f474d55b5944f893ccec44776491;4952f474d55b5944f893ccec44776491;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;51;661.9661,-460.5268;Float;True;Property;_snowbasecolor;snowbasecolor;7;0;Create;True;0;0;False;0;84dea5868f3f1ac4aa5eccbd6f6cec23;84dea5868f3f1ac4aa5eccbd6f6cec23;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;85;434.2625,1410.99;Float;False;381.9978;745.9338;map_object;3;83;82;81;;0,1,0.03342295,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;71;201.135,1108.863;Float;False;Constant;_Float4;Float 4;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;50;662.9172,-41.65495;Float;True;Property;_snow_roughness;snow_roughness;6;0;Create;True;0;0;False;0;b54e94ddfcb9d4b49839de66db28406e;b54e94ddfcb9d4b49839de66db28406e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;40;540.6631,249.2131;Float;True;Property;_Ice_basecolor;Ice_basecolor;0;0;Create;True;0;0;False;0;ac1b7c7af9f9da04b98d37c80b865b7c;78f701e11125cff4b91e606f4167598b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FloorOpNode;72;200.8799,1036.463;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;42;670.6122,494.2185;Float;True;Property;_Ice_normal;Ice_normal;1;0;Create;True;0;0;False;0;ce914e537ec9da34e8bfd84084772056;ce914e537ec9da34e8bfd84084772056;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;83;484.2625,1926.924;Float;True;Property;_texture_roughness;texture_roughness;12;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;81;492.4705,1460.99;Float;True;Property;_base_color_object;base_color_object;11;0;Create;True;0;0;False;0;80ab37a9e4f49c842903bb43bdd7bcd2;80ab37a9e4f49c842903bb43bdd7bcd2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;56;1343.483,269.0422;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;55;1366.035,525.7308;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;74;392.7145,1073.484;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;86;1918.555,514.7839;Float;False;378.703;1042.293;blend_final;4;77;76;78;89;;1,0,0,1;0;0
Node;AmplifyShaderEditor.SamplerNode;82;495.2603,1685.363;Float;True;Property;_Normal_object;Normal_object;10;0;Create;True;0;0;False;0;9a4a55d8d2e54394d97426434477cdcf;9a4a55d8d2e54394d97426434477cdcf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;57;1376.336,23.17892;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;77;2012.641,788.0161;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;90;2105.188,1677.09;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;75;-174.2306,929.7259;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;78;2006.952,1020.554;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;84;1683.466,1679.649;Float;True;Property;_Ice_oppacity1;Ice_oppacity 1;13;0;Create;True;0;0;False;0;81161af1bacc4a74db36d3d7d698f82d;81161af1bacc4a74db36d3d7d698f82d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;89;1974.122,1265.192;Float;True;Property;_Ice_oppacity;Ice_oppacity;8;0;Create;True;0;0;False;0;407f63f772e72fa44a4c468990890de2;407f63f772e72fa44a4c468990890de2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;91;1706.621,1949.576;Float;False;Constant;_Color0;Color 0;15;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;58;-338.3827,73.73409;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;76;2002.051,564.7839;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;80;2326.809,1182.454;Float;False;Constant;_Float0;Float 0;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3055.159,1168.621;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ice_snow_shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;52;0;79;0
WireConnection;59;0;52;1
WireConnection;67;0;79;0
WireConnection;68;0;67;1
WireConnection;53;0;54;0
WireConnection;53;1;59;0
WireConnection;70;0;69;0
WireConnection;70;1;68;0
WireConnection;63;0;53;0
WireConnection;60;0;63;0
WireConnection;60;1;61;0
WireConnection;60;2;62;0
WireConnection;72;0;70;0
WireConnection;56;0;42;0
WireConnection;56;1;46;0
WireConnection;56;2;60;0
WireConnection;55;0;45;0
WireConnection;55;1;50;0
WireConnection;55;2;60;0
WireConnection;74;0;72;0
WireConnection;74;1;71;0
WireConnection;74;2;73;0
WireConnection;57;0;40;0
WireConnection;57;1;51;0
WireConnection;57;2;60;0
WireConnection;77;0;82;0
WireConnection;77;1;56;0
WireConnection;77;2;74;0
WireConnection;90;0;89;0
WireConnection;90;1;91;0
WireConnection;75;0;69;0
WireConnection;78;0;83;0
WireConnection;78;1;55;0
WireConnection;78;2;74;0
WireConnection;58;0;54;0
WireConnection;76;0;81;0
WireConnection;76;1;57;0
WireConnection;76;2;74;0
WireConnection;0;0;76;0
WireConnection;0;1;77;0
WireConnection;0;3;80;0
WireConnection;0;4;78;0
ASEEND*/
//CHKSM=4CD39D235EDCE3A9CA0026D580CF4F73C73E6F1B