/*
 *    Copyright 2016 Anand Muralidhar
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

// shader associated with AssimpLoader


precision mediump float; // required in GLSL ES 1.00

varying vec2      textureCoords;
uniform sampler2D textureSampler;

varying float vs_isTexturePresent;
varying lowp vec3 frag_Normal;

struct Light {
    vec3 Color;
    float AmbientIntensity;
    float DiffuseIntensity;
    vec3 Direction;
};

uniform Light u_Light;


void main()
{

    if(vs_isTexturePresent > 0.5)
    {
    gl_FragColor.xyz = texture2D( textureSampler, textureCoords ).xyz;
    }
    else{
        // Ambient
        lowp vec3 AmbientColor = u_Light.Color * u_Light.AmbientIntensity;

        // Diffuse
        lowp vec3 Normal = normalize(frag_Normal);
        lowp float DiffuseFactor = max(-dot(Normal, u_Light.Direction), 0.0);
        lowp vec3 DiffuseColor = u_Light.Color * u_Light.DiffuseIntensity * DiffuseFactor;

        gl_FragColor = texture2D(textureSampler, textureCoords) * vec4((AmbientColor + DiffuseColor), 1.0);

        //gl_FragColor.xyz = vec3(1.0, 1.0, 1.0);
    }
}
