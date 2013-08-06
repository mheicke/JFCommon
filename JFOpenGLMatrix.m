//
// JFOpenGLMatrix.m
// JFCommon
//
// Created by Jason Fuerstenberg on 2009/06/17.
// Copyright (c) 2009 Jason Fuerstenberg. All rights reserved.
//
// http://www.jayfuerstenberg.com
// jay@jayfuerstenberg.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "JFOpenGLMatrix.h"


// TODO: relocate these precalced sines and cosines somewhere.

/**
 * Precalculated SINE constants for each angle.
 */
float ___SINES[] = {
    0.0f,
    0.01745240643728351f,
    0.03489949670250097f,
    0.05233595624294383f,
    0.0697564737441253f,
    0.08715574274765817f,
    0.10452846326765346f,
    0.12186934340514748f,
    0.13917310096006544f,
    0.15643446504023087f,
    0.17364817766693033f,
    0.1908089953765448f,
    0.20791169081775931f,
    0.224951054343865f,
    0.24192189559966773f,
    0.25881904510252074f,
    0.27563735581699916f,
    0.29237170472273677f,
    0.3090169943749474f,
    0.32556815445715664f,
    0.3420201433256687f,
    0.35836794954530027f,
    0.374606593415912f,
    0.3907311284892737f,
    0.40673664307580015f,
    0.42261826174069944f,
    0.4383711467890774f,
    0.45399049973954675f,
    0.4694715627858908f,
    0.48480962024633706f,
    0.49999999999999994f,
    0.5150380749100542f,
    0.5299192642332049f,
    0.5446390350150271f,
    0.5591929034707469f,
    0.573576436351046f,
    0.5877852522924731f,
    0.6018150231520483f,
    0.6156614753256582f,
    0.6293203910498374f,
    0.6427876096865393f,
    0.6560590289905072f,
    0.6691306063588582f,
    0.6819983600624985f,
    0.6946583704589973f,
    0.7071067811865475f,
    0.7193398003386511f,
    0.7313537016191705f,
    0.7431448254773942f,
    0.754709580222772f,
    0.766044443118978f,
    0.7771459614569708f,
    0.788010753606722f,
    0.7986355100472928f,
    0.8090169943749475f,
    0.8191520442889918f,
    0.8290375725550417f,
    0.8386705679454239f,
    0.8480480961564261f,
    0.8571673007021122f,
    0.8660254037844386f,
    0.8746197071393957f,
    0.8829475928589269f,
    0.8910065241883678f,
    0.898794046299167f,
    0.9063077870366499f,
    0.9135454576426009f,
    0.9205048534524403f,
    0.9271838545667874f,
    0.9335804264972017f,
    0.9396926207859083f,
    0.9455185755993167f,
    0.9510565162951535f,
    0.9563047559630354f,
    0.9612616959383189f,
    0.9659258262890683f,
    0.9702957262759965f,
    0.9743700647852352f,
    0.9781476007338056f,
    0.981627183447664f,
    0.984807753012208f,
    0.9876883405951378f,
    0.9902680687415703f,
    0.992546151641322f,
    0.9945218953682733f,
    0.9961946980917455f,
    0.9975640502598242f,
    0.9986295347545738f,
    0.9993908270190958f,
    0.9998476951563913f,
    1.0f,
    0.9998476951563913f,
    0.9993908270190958f,
    0.9986295347545738f,
    0.9975640502598242f,
    0.9961946980917455f,
    0.9945218953682734f,
    0.9925461516413221f,
    0.9902680687415704f,
    0.9876883405951377f,
    0.984807753012208f,
    0.981627183447664f,
    0.9781476007338057f,
    0.9743700647852352f,
    0.9702957262759965f,
    0.9659258262890683f,
    0.9612616959383189f,
    0.9563047559630355f,
    0.9510565162951536f,
    0.9455185755993168f,
    0.9396926207859084f,
    0.9335804264972017f,
    0.9271838545667874f,
    0.9205048534524404f,
    0.913545457642601f,
    0.90630778703665f,
    0.8987940462991669f,
    0.8910065241883679f,
    0.8829475928589271f,
    0.8746197071393959f,
    0.8660254037844387f,
    0.8571673007021123f,
    0.8480480961564261f,
    0.838670567945424f,
    0.8290375725550417f,
    0.819152044288992f,
    0.8090169943749475f,
    0.7986355100472927f,
    0.788010753606722f,
    0.777145961456971f,
    0.766044443118978f,
    0.7547095802227718f,
    0.7431448254773942f,
    0.7313537016191706f,
    0.7193398003386514f,
    0.7071067811865476f,
    0.6946583704589971f,
    0.6819983600624986f,
    0.6691306063588583f,
    0.6560590289905073f,
    0.6427876096865395f,
    0.6293203910498377f,
    0.6156614753256584f,
    0.6018150231520482f,
    0.5877852522924732f,
    0.5735764363510464f,
    0.5591929034707469f,
    0.5446390350150269f,
    0.5299192642332049f,
    0.5150380749100544f,
    0.49999999999999994f,
    0.48480962024633717f,
    0.4694715627858911f,
    0.45399049973954686f,
    0.4383711467890773f,
    0.4226182617406995f,
    0.40673664307580043f,
    0.39073112848927416f,
    0.37460659341591224f,
    0.3583679495453002f,
    0.3420201433256689f,
    0.325568154457157f,
    0.3090169943749475f,
    0.29237170472273705f,
    0.27563735581699966f,
    0.258819045102521f,
    0.24192189559966773f,
    0.22495105434386478f,
    0.20791169081775931f,
    0.19080899537654497f,
    0.17364817766693028f,
    0.15643446504023098f,
    0.13917310096006574f,
    0.12186934340514755f,
    0.10452846326765373f,
    0.08715574274765864f,
    0.06975647374412552f,
    0.05233595624294381f,
    0.0348994967025007f,
    0.01745240643728344f,
    1.2246467991473532E-16f,
    -0.017452406437283192f,
    -0.0348994967025009f,
    -0.052335956242943564f,
    -0.06975647374412483f,
    -0.08715574274765794f,
    -0.10452846326765305f,
    -0.12186934340514775f,
    -0.13917310096006552f,
    -0.15643446504023073f,
    -0.17364817766693047f,
    -0.19080899537654472f,
    -0.20791169081775907f,
    -0.22495105434386498f,
    -0.2419218955996675f,
    -0.25881904510252035f,
    -0.275637355816999f,
    -0.2923717047227364f,
    -0.30901699437494773f,
    -0.32556815445715676f,
    -0.34202014332566866f,
    -0.35836794954530043f,
    -0.374606593415912f,
    -0.39073112848927355f,
    -0.4067366430757998f,
    -0.4226182617406993f,
    -0.43837114678907707f,
    -0.45399049973954625f,
    -0.46947156278589086f,
    -0.48480962024633695f,
    -0.5000000000000001f,
    -0.5150380749100542f,
    -0.5299192642332048f,
    -0.5446390350150271f,
    -0.5591929034707467f,
    -0.5735764363510458f,
    -0.587785252292473f,
    -0.601815023152048f,
    -0.6156614753256578f,
    -0.6293203910498376f,
    -0.6427876096865393f,
    -0.6560590289905074f,
    -0.6691306063588582f,
    -0.6819983600624984f,
    -0.6946583704589974f,
    -0.7071067811865475f,
    -0.7193398003386509f,
    -0.7313537016191701f,
    -0.743144825477394f,
    -0.7547095802227717f,
    -0.7660444431189779f,
    -0.7771459614569711f,
    -0.7880107536067221f,
    -0.7986355100472928f,
    -0.8090169943749473f,
    -0.8191520442889916f,
    -0.8290375725550414f,
    -0.838670567945424f,
    -0.848048096156426f,
    -0.8571673007021121f,
    -0.8660254037844385f,
    -0.8746197071393959f,
    -0.882947592858927f,
    -0.8910065241883678f,
    -0.8987940462991668f,
    -0.9063077870366497f,
    -0.913545457642601f,
    -0.9205048534524403f,
    -0.9271838545667873f,
    -0.9335804264972016f,
    -0.9396926207859082f,
    -0.9455185755993168f,
    -0.9510565162951535f,
    -0.9563047559630353f,
    -0.9612616959383189f,
    -0.9659258262890683f,
    -0.9702957262759965f,
    -0.9743700647852351f,
    -0.9781476007338056f,
    -0.9816271834476639f,
    -0.984807753012208f,
    -0.9876883405951377f,
    -0.9902680687415704f,
    -0.9925461516413221f,
    -0.9945218953682734f,
    -0.9961946980917455f,
    -0.9975640502598242f,
    -0.9986295347545738f,
    -0.9993908270190957f,
    -0.9998476951563913f,
    -1.0f,
    -0.9998476951563913f,
    -0.9993908270190958f,
    -0.9986295347545738f,
    -0.9975640502598243f,
    -0.9961946980917455f,
    -0.9945218953682734f,
    -0.992546151641322f,
    -0.9902680687415704f,
    -0.9876883405951378f,
    -0.9848077530122081f,
    -0.9816271834476641f,
    -0.9781476007338058f,
    -0.9743700647852352f,
    -0.9702957262759966f,
    -0.9659258262890682f,
    -0.9612616959383188f,
    -0.9563047559630354f,
    -0.9510565162951536f,
    -0.945518575599317f,
    -0.9396926207859085f,
    -0.9335804264972021f,
    -0.9271838545667874f,
    -0.9205048534524405f,
    -0.9135454576426008f,
    -0.9063077870366498f,
    -0.898794046299167f,
    -0.891006524188368f,
    -0.8829475928589271f,
    -0.8746197071393961f,
    -0.8660254037844386f,
    -0.8571673007021123f,
    -0.8480480961564261f,
    -0.8386705679454243f,
    -0.8290375725550421f,
    -0.8191520442889918f,
    -0.8090169943749476f,
    -0.798635510047293f,
    -0.7880107536067218f,
    -0.7771459614569708f,
    -0.7660444431189781f,
    -0.7547095802227721f,
    -0.7431448254773946f,
    -0.731353701619171f,
    -0.7193398003386517f,
    -0.7071067811865477f,
    -0.6946583704589976f,
    -0.6819983600624983f,
    -0.6691306063588581f,
    -0.6560590289905074f,
    -0.6427876096865396f,
    -0.6293203910498378f,
    -0.6156614753256588f,
    -0.6018150231520483f,
    -0.5877852522924734f,
    -0.5735764363510465f,
    -0.5591929034707473f,
    -0.544639035015027f,
    -0.5299192642332058f,
    -0.5150380749100545f,
    -0.5000000000000004f,
    -0.4848096202463369f,
    -0.4694715627858908f,
    -0.45399049973954697f,
    -0.438371146789077f,
    -0.4226182617407f,
    -0.40673664307580015f,
    -0.3907311284892747f,
    -0.37460659341591235f,
    -0.35836794954530077f,
    -0.3420201433256686f,
    -0.32556815445715753f,
    -0.3090169943749476f,
    -0.29237170472273627f,
    -0.2756373558169998f,
    -0.2588190451025207f,
    -0.24192189559966787f,
    -0.22495105434386534f,
    -0.20791169081775987f,
    -0.19080899537654467f,
    -0.17364817766693127f,
    -0.15643446504023112f,
    -0.13917310096006588f,
    -0.12186934340514811f,
    -0.10452846326765342f,
    -0.08715574274765832f,
    -0.06975647374412476f,
    -0.05233595624294437f,
    -0.034899496702500823f,
    -0.01745240643728445f
};


/**
 * Precalculated COSINE constants for each angle.
 */
float ___COSINES[] = {
    1.0f,
    0.9998476951563913f,
    0.9993908270190958f,
    0.9986295347545738f,
    0.9975640502598242f,
    0.9961946980917455f,
    0.9945218953682733f,
    0.992546151641322f,
    0.9902680687415704f,
    0.9876883405951378f,
    0.984807753012208f,
    0.981627183447664f,
    0.9781476007338057f,
    0.9743700647852352f,
    0.9702957262759965f,
    0.9659258262890683f,
    0.9612616959383189f,
    0.9563047559630354f,
    0.9510565162951535f,
    0.9455185755993168f,
    0.9396926207859084f,
    0.9335804264972017f,
    0.9271838545667874f,
    0.9205048534524404f,
    0.9135454576426009f,
    0.9063077870366499f,
    0.898794046299167f,
    0.8910065241883679f,
    0.882947592858927f,
    0.8746197071393957f,
    0.8660254037844387f,
    0.8571673007021123f,
    0.848048096156426f,
    0.838670567945424f,
    0.8290375725550416f,
    0.8191520442889918f,
    0.8090169943749475f,
    0.7986355100472928f,
    0.788010753606722f,
    0.7771459614569709f,
    0.766044443118978f,
    0.754709580222772f,
    0.7431448254773942f,
    0.7313537016191706f,
    0.7193398003386512f,
    0.7071067811865476f,
    0.6946583704589974f,
    0.6819983600624985f,
    0.6691306063588582f,
    0.6560590289905073f,
    0.6427876096865394f,
    0.6293203910498375f,
    0.6156614753256583f,
    0.6018150231520483f,
    0.5877852522924731f,
    0.573576436351046f,
    0.5591929034707468f,
    0.5446390350150272f,
    0.5299192642332049f,
    0.5150380749100544f,
    0.5000000000000001f,
    0.4848096202463371f,
    0.46947156278589086f,
    0.45399049973954686f,
    0.43837114678907746f,
    0.42261826174069944f,
    0.4067366430758002f,
    0.39073112848927394f,
    0.37460659341591196f,
    0.3583679495453004f,
    0.3420201433256688f,
    0.32556815445715676f,
    0.30901699437494745f,
    0.29237170472273677f,
    0.27563735581699916f,
    0.25881904510252074f,
    0.2419218955996679f,
    0.22495105434386492f,
    0.20791169081775945f,
    0.19080899537654492f,
    0.17364817766693041f,
    0.15643446504023092f,
    0.1391731009600657f,
    0.12186934340514749f,
    0.10452846326765346f,
    0.08715574274765814f,
    0.06975647374412546f,
    0.052335956242943966f,
    0.03489949670250108f,
    0.017452406437283376f,
    6.123233995736766E-17f,
    -0.017452406437283477f,
    -0.03489949670250073f,
    -0.05233595624294362f,
    -0.06975647374412533f,
    -0.08715574274765824f,
    -0.10452846326765333f,
    -0.12186934340514737f,
    -0.13917310096006535f,
    -0.15643446504023104f,
    -0.1736481776669303f,
    -0.1908089953765448f,
    -0.20791169081775912f,
    -0.2249510543438648f,
    -0.24192189559966779f,
    -0.25881904510252085f,
    -0.27563735581699905f,
    -0.29237170472273666f,
    -0.30901699437494734f,
    -0.3255681544571564f,
    -0.3420201433256687f,
    -0.35836794954530027f,
    -0.37460659341591207f,
    -0.3907311284892736f,
    -0.4067366430758001f,
    -0.42261826174069933f,
    -0.4383711467890775f,
    -0.45399049973954675f,
    -0.46947156278589053f,
    -0.484809620246337f,
    -0.4999999999999998f,
    -0.5150380749100543f,
    -0.5299192642332048f,
    -0.5446390350150271f,
    -0.5591929034707467f,
    -0.5735764363510458f,
    -0.587785252292473f,
    -0.6018150231520484f,
    -0.6156614753256583f,
    -0.6293203910498373f,
    -0.6427876096865394f,
    -0.6560590289905075f,
    -0.6691306063588582f,
    -0.6819983600624984f,
    -0.694658370458997f,
    -0.7071067811865475f,
    -0.7193398003386513f,
    -0.7313537016191705f,
    -0.7431448254773941f,
    -0.754709580222772f,
    -0.7660444431189779f,
    -0.7771459614569707f,
    -0.7880107536067219f,
    -0.7986355100472929f,
    -0.8090169943749473f,
    -0.8191520442889916f,
    -0.8290375725550416f,
    -0.8386705679454242f,
    -0.848048096156426f,
    -0.8571673007021122f,
    -0.8660254037844387f,
    -0.8746197071393957f,
    -0.8829475928589268f,
    -0.8910065241883678f,
    -0.898794046299167f,
    -0.9063077870366499f,
    -0.9135454576426008f,
    -0.9205048534524402f,
    -0.9271838545667873f,
    -0.9335804264972017f,
    -0.9396926207859083f,
    -0.9455185755993167f,
    -0.9510565162951535f,
    -0.9563047559630354f,
    -0.9612616959383187f,
    -0.9659258262890682f,
    -0.9702957262759965f,
    -0.9743700647852352f,
    -0.9781476007338057f,
    -0.981627183447664f,
    -0.984807753012208f,
    -0.9876883405951377f,
    -0.9902680687415703f,
    -0.992546151641322f,
    -0.9945218953682733f,
    -0.9961946980917455f,
    -0.9975640502598242f,
    -0.9986295347545738f,
    -0.9993908270190958f,
    -0.9998476951563913f,
    -1.0f,
    -0.9998476951563913f,
    -0.9993908270190958f,
    -0.9986295347545738f,
    -0.9975640502598243f,
    -0.9961946980917455f,
    -0.9945218953682734f,
    -0.992546151641322f,
    -0.9902680687415703f,
    -0.9876883405951378f,
    -0.984807753012208f,
    -0.981627183447664f,
    -0.9781476007338057f,
    -0.9743700647852352f,
    -0.9702957262759966f,
    -0.9659258262890684f,
    -0.9612616959383189f,
    -0.9563047559630355f,
    -0.9510565162951535f,
    -0.9455185755993167f,
    -0.9396926207859084f,
    -0.9335804264972017f,
    -0.9271838545667874f,
    -0.9205048534524404f,
    -0.9135454576426011f,
    -0.90630778703665f,
    -0.8987940462991671f,
    -0.8910065241883681f,
    -0.8829475928589269f,
    -0.8746197071393959f,
    -0.8660254037844386f,
    -0.8571673007021123f,
    -0.8480480961564261f,
    -0.838670567945424f,
    -0.8290375725550418f,
    -0.819152044288992f,
    -0.8090169943749475f,
    -0.798635510047293f,
    -0.7880107536067222f,
    -0.7771459614569708f,
    -0.7660444431189781f,
    -0.7547095802227719f,
    -0.7431448254773942f,
    -0.7313537016191706f,
    -0.7193398003386511f,
    -0.7071067811865477f,
    -0.6946583704589975f,
    -0.6819983600624989f,
    -0.6691306063588585f,
    -0.6560590289905077f,
    -0.6427876096865395f,
    -0.6293203910498371f,
    -0.6156614753256581f,
    -0.6018150231520483f,
    -0.5877852522924732f,
    -0.5735764363510464f,
    -0.5591929034707472f,
    -0.544639035015027f,
    -0.529919264233205f,
    -0.5150380749100545f,
    -0.5000000000000004f,
    -0.48480962024633684f,
    -0.46947156278589075f,
    -0.4539904997395469f,
    -0.43837114678907774f,
    -0.42261826174069994f,
    -0.4067366430758001f,
    -0.3907311284892738f,
    -0.3746065934159123f,
    -0.3583679495453007f,
    -0.3420201433256694f,
    -0.32556815445715664f,
    -0.30901699437494756f,
    -0.2923717047227371f,
    -0.2756373558169989f,
    -0.25881904510252063f,
    -0.24192189559966779f,
    -0.22495105434386525f,
    -0.2079116908177598f,
    -0.19080899537654547f,
    -0.17364817766693033f,
    -0.15643446504023104f,
    -0.13917310096006494f,
    -0.12186934340514717f,
    -0.10452846326765336f,
    -0.08715574274765825f,
    -0.06975647374412558f,
    -0.052335956242944306f,
    -0.03489949670250165f,
    -0.017452406437283498f,
    -1.8369701987210297E-16f,
    0.01745240643728313f,
    0.03489949670250128f,
    0.052335956242943946f,
    0.06975647374412522f,
    0.08715574274765789f,
    0.10452846326765299f,
    0.12186934340514768f,
    0.13917310096006547f,
    0.15643446504023067f,
    0.17364817766692997f,
    0.19080899537654425f,
    0.20791169081775857f,
    0.22495105434386492f,
    0.24192189559966745f,
    0.25881904510252113f,
    0.2756373558169994f,
    0.2923717047227367f,
    0.30901699437494723f,
    0.3255681544571563f,
    0.34202014332566816f,
    0.35836794954529955f,
    0.37460659341591196f,
    0.3907311284892735f,
    0.40673664307580054f,
    0.4226182617406996f,
    0.4383711467890774f,
    0.45399049973954664f,
    0.4694715627858904f,
    0.4848096202463365f,
    0.5000000000000001f,
    0.5150380749100542f,
    0.5299192642332047f,
    0.5446390350150266f,
    0.5591929034707462f,
    0.573576436351046f,
    0.5877852522924729f,
    0.6018150231520479f,
    0.6156614753256585f,
    0.6293203910498375f,
    0.6427876096865393f,
    0.656059028990507f,
    0.6691306063588578f,
    0.6819983600624979f,
    0.6946583704589966f,
    0.7071067811865474f,
    0.7193398003386509f,
    0.7313537016191707f,
    0.7431448254773942f,
    0.7547095802227719f,
    0.7660444431189778f,
    0.7771459614569706f,
    0.7880107536067216f,
    0.7986355100472928f,
    0.8090169943749473f,
    0.8191520442889916f,
    0.8290375725550414f,
    0.838670567945424f,
    0.8480480961564254f,
    0.8571673007021121f,
    0.8660254037844384f,
    0.8746197071393959f,
    0.882947592858927f,
    0.8910065241883678f,
    0.8987940462991671f,
    0.9063077870366497f,
    0.913545457642601f,
    0.9205048534524399f,
    0.9271838545667873f,
    0.9335804264972015f,
    0.9396926207859084f,
    0.9455185755993165f,
    0.9510565162951535f,
    0.9563047559630357f,
    0.9612616959383187f,
    0.9659258262890683f,
    0.9702957262759965f,
    0.9743700647852351f,
    0.9781476007338056f,
    0.981627183447664f,
    0.9848077530122079f,
    0.9876883405951377f,
    0.9902680687415703f,
    0.992546151641322f,
    0.9945218953682733f,
    0.9961946980917455f,
    0.9975640502598243f,
    0.9986295347545738f,
    0.9993908270190958f,
    0.9998476951563913f
};


@implementation JFOpenGLMatrix

#pragma mark - Object lifecycle methods

/*
 * Convenience constructor.
 */
+ (id) matrix {
	
	JFOpenGLMatrix *matrix = [[JFOpenGLMatrix alloc] init];

	#if !__has_feature(objc_arc)
		[matrix autorelease];
	#endif
	
	return matrix;	
}

/*
 * Constructor.
 */
- (id) init {
	
	self = [super init];
    if (self != nil) {
        // All matrices are defaulted to identity.
        [self setIdentity];
    }
	
	return self;
}


#pragma mark - Calculation methods

/*
 * Sets the matrix to zero.
 */
- (void) setZero {
	
	_m00 = _m01 = _m02 = _m03 =
	_m10 = _m11 = _m12 = _m13 =
	_m20 = _m21 = _m22 = _m23 =
	_m30 = _m31 = _m32 = _m33 = 0.0f;
}


/*
 * Sets the matrix to identity.
 */
- (void) setIdentity {
	
	_m00 = _m11 = _m22 = _m33 = 1.0f;
	
	_m01 = _m02 = _m03 =
	_m10 = _m12 = _m13 =
	_m20 = _m21 = _m23 =
	_m30 = _m31 = _m32 = 0.0f;
}


/*
 * Translates the matrix by the provided arguments.
 */
- (void) setTranslationX: (GLfloat) x y: (GLfloat) y z: (GLfloat) z {
	
	_m00 = _m11 = _m22 = _m33 = 1.0f;
	
	_m01 = _m02 = _m03 =
	_m10 = _m12 = _m13 =
	_m20 = _m21 = _m23 = 0.0f;
	
    
	_m30 = -x;
	_m31 = -y;
	_m32 = -z;
}


/*
 * Scales the matrix with the provided arguments.
 */
- (void) setScaleX: (GLfloat) x y: (GLfloat) y z: (GLfloat) z {
	
	_m00 = x;
	_m11 = y;
	_m22 = z; 
	
	_m01 = _m02 = _m03 =
	_m10 = _m12 = _m13 =
	_m20 = _m21 = _m23 =
	_m30 = _m31 = _m32 = 0.0f;
	
	_m33 = 1.0f;
}


/*
 * Rotates the matrix by the provided angle around the X axis.
 */
- (void) setXAngle: (UInt16) angle {
    
    if (angle > 360) {
        // Block invalid angles.
        return;
    }
	
	_m00 = _m33 = 1.0f;
	
	_m01 = _m02 = _m03 =
	_m10 = _m13 =
	_m20 = _m23 =
	_m30 = _m31 = _m32 = 0.0f;
	
	_m11 = _m22 = ___COSINES[angle];
	_m12 = -(_m21 = ___SINES[angle]);
}


/*
 * Rotates the matrix by the provided angle around the Y axis.
 */
- (void) setYAngle: (UInt16) angle {
    
    if (angle > 360) {
        // Block invalid angles.
        return;
    }
	
	_m11 = _m33 = 1.0f;
	
	_m01 = _m03 =
	_m10 = _m12 = _m13 =
	_m21 = _m23 =
	_m30 = _m31 = _m32 = 0.0f;
	
	_m00 = _m22 = ___COSINES[angle];
	_m20 = -(_m02 = ___SINES[angle]);
}


/*
 * Rotates the matrix by the provided angle around the Z axis.
 */
- (void) setZAngle: (UInt16) angle {
    
    if (angle > 360) {
        // Block invalid angles.
        return;
    }
	
	_m22 = _m33 = 1.0f;
	
	_m02 = _m03 =
	_m12 = _m13 =
	_m20 = _m21 = _m23 =
	_m30 = _m31 = _m32 = 0.0f;
	
	_m00 = _m11 = ___COSINES[angle];
	_m01 = -(_m10 = ___SINES[angle]);
}


/*
 * Multiplies the vertex by this matrix.
 */
- (void) multiplyVertex: (JFOpenGLVertex *) vertex {
    
    if (vertex == nil) {
        // Nothing to multiply so just return.
        return;
    }
	
	GLfloat x = (vertex->_x * _m00) + (vertex->_y * _m10) + (vertex->_z * _m20) + _m30;
	GLfloat y = (vertex->_x * _m01) + (vertex->_y * _m11) + (vertex->_z * _m21) + _m31;
	GLfloat z = (vertex->_x * _m02) + (vertex->_y * _m12) + (vertex->_z * _m22) + _m32;
	
	vertex->_x = x;
	vertex->_y = y;
	vertex->_z = z;
}


/*
 * Multiplies the first vertex into the second by this matrix.
 */
- (void) mulitplyVertex: (JFOpenGLVertex *) vertex1 into: (JFOpenGLVertex *) vertex2 {
    
    if (vertex1 == nil || vertex2) {
        // Nothing to multiply so just return.
        return;
    }
	
	vertex2->_x = (vertex1->_x * _m00) + (vertex1->_y * _m10) + (vertex1->_z * _m20) + _m30;
	vertex2->_y = (vertex1->_x * _m01) + (vertex1->_y * _m11) + (vertex1->_z * _m21) + _m31;
	vertex2->_z = (vertex1->_x * _m02) + (vertex1->_y * _m12) + (vertex1->_z * _m22) + _m32;
}

- (void) mirror: (JFOpenGLMatrix *) other {
	
	if (other == nil) {
		return;
	}
	
	_m00 = other->_m00;
	_m01 = other->_m01;
	_m02 = other->_m02;
	_m03 = other->_m03;
	
	_m10 = other->_m10;
	_m11 = other->_m11;
	_m12 = other->_m12;
	_m13 = other->_m13;
	
	_m20 = other->_m20;
	_m21 = other->_m21;
	_m22 = other->_m22;
	_m23 = other->_m23;
	
	_m30 = other->_m30;
	_m31 = other->_m31;
	_m32 = other->_m32;
	_m33 = other->_m33;
}


/*
 * Merges this matrix with the provided one, storing the results in this matrix.
 */
- (void) mergeWith: (JFOpenGLMatrix *) other {
    
    if (other == nil) {
        // Nothing with which to merge so just return.
        return;
    }
	
	GLfloat r00 = (_m00 * other->_m00) + (_m01 * other->_m10) + (_m02 * other->_m20) + (_m03 * other->_m30);
	GLfloat r04 = (_m10 * other->_m00) + (_m11 * other->_m10) + (_m12 * other->_m20) + (_m13 * other->_m30);
	GLfloat r08 = (_m20 * other->_m00) + (_m21 * other->_m10) + (_m22 * other->_m20) + (_m23 * other->_m30);
	GLfloat r12 = (_m30 * other->_m00) + (_m31 * other->_m10) + (_m32 * other->_m20) + (_m33 * other->_m30);
	GLfloat r01 = (_m00 * other->_m01) + (_m01 * other->_m11) + (_m02 * other->_m21) + (_m03 * other->_m31);
	GLfloat r05 = (_m10 * other->_m01) + (_m11 * other->_m11) + (_m12 * other->_m21) + (_m13 * other->_m31);
	GLfloat r09 = (_m20 * other->_m01) + (_m21 * other->_m11) + (_m22 * other->_m21) + (_m23 * other->_m31);
	GLfloat r13 = (_m30 * other->_m01) + (_m31 * other->_m11) + (_m32 * other->_m21) + (_m33 * other->_m31);
	GLfloat r02 = (_m00 * other->_m02) + (_m01 * other->_m12) + (_m02 * other->_m22) + (_m03 * other->_m32);
	GLfloat r06 = (_m10 * other->_m02) + (_m11 * other->_m12) + (_m12 * other->_m22) + (_m13 * other->_m32);
	GLfloat r10 = (_m20 * other->_m02) + (_m21 * other->_m12) + (_m22 * other->_m22) + (_m23 * other->_m32);
	GLfloat r14 = (_m30 * other->_m02) + (_m31 * other->_m12) + (_m32 * other->_m22) + (_m33 * other->_m32);
	GLfloat r03 = (_m00 * other->_m03) + (_m01 * other->_m13) + (_m02 * other->_m23) + (_m03 * other->_m33);
	GLfloat r07 = (_m10 * other->_m03) + (_m11 * other->_m13) + (_m12 * other->_m23) + (_m13 * other->_m33);
	GLfloat r11 = (_m20 * other->_m03) + (_m21 * other->_m13) + (_m22 * other->_m23) + (_m23 * other->_m33);
	GLfloat r15 = (_m30 * other->_m03) + (_m31 * other->_m13) + (_m32 * other->_m23) + (_m33 * other->_m33);
	
	_m00 = r00;
	_m01 = r01;
	_m02 = r02;
	_m03 = r03;
	_m10 = r04;
	_m11 = r05;
	_m12 = r06;
	_m13 = r07;
	_m20 = r08;
	_m21 = r09;
	_m22 = r10;
	_m23 = r11;
	_m30 = r12;
	_m31 = r13;
	_m32 = r14;
	_m33 = r15;
}


- (BOOL) invert { // based on impl found here:   http://stackoverflow.com/questions/1148309/inverting-a-4x4-matrix

    GLfloat inv[16], det;

	
	GLfloat m[16];
	m[0] = _m00;
	m[1] = _m01;
	m[2] = _m02;
	m[3] = _m03;
	
	m[4] = _m10;
	m[5] = _m11;
	m[6] = _m12;
	m[7] = _m13;
	
	m[8] = _m20;
	m[9] = _m21;
	m[10] = _m22;
	m[11] = _m23;
	
	m[12] = _m30;
	m[13] = _m31;
	m[14] = _m32;
	m[15] = _m33;
	
	
    inv[0] = m[5]  * m[10] * m[15] - 
	m[5]  * m[11] * m[14] - 
	m[9]  * m[6]  * m[15] + 
	m[9]  * m[7]  * m[14] +
	m[13] * m[6]  * m[11] - 
	m[13] * m[7]  * m[10];
	
    inv[4] = -m[4]  * m[10] * m[15] + 
	m[4]  * m[11] * m[14] + 
	m[8]  * m[6]  * m[15] - 
	m[8]  * m[7]  * m[14] - 
	m[12] * m[6]  * m[11] + 
	m[12] * m[7]  * m[10];
	
    inv[8] = m[4]  * m[9] * m[15] - 
	m[4]  * m[11] * m[13] - 
	m[8]  * m[5] * m[15] + 
	m[8]  * m[7] * m[13] + 
	m[12] * m[5] * m[11] - 
	m[12] * m[7] * m[9];
	
    inv[12] = -m[4]  * m[9] * m[14] + 
	m[4]  * m[10] * m[13] +
	m[8]  * m[5] * m[14] - 
	m[8]  * m[6] * m[13] - 
	m[12] * m[5] * m[10] + 
	m[12] * m[6] * m[9];
	
    inv[1] = -m[1]  * m[10] * m[15] + 
	m[1]  * m[11] * m[14] + 
	m[9]  * m[2] * m[15] - 
	m[9]  * m[3] * m[14] - 
	m[13] * m[2] * m[11] + 
	m[13] * m[3] * m[10];
	
    inv[5] = m[0]  * m[10] * m[15] - 
	m[0]  * m[11] * m[14] - 
	m[8]  * m[2] * m[15] + 
	m[8]  * m[3] * m[14] + 
	m[12] * m[2] * m[11] - 
	m[12] * m[3] * m[10];
	
    inv[9] = -m[0]  * m[9] * m[15] + 
	m[0]  * m[11] * m[13] + 
	m[8]  * m[1] * m[15] - 
	m[8]  * m[3] * m[13] - 
	m[12] * m[1] * m[11] + 
	m[12] * m[3] * m[9];
	
    inv[13] = m[0]  * m[9] * m[14] - 
	m[0]  * m[10] * m[13] - 
	m[8]  * m[1] * m[14] + 
	m[8]  * m[2] * m[13] + 
	m[12] * m[1] * m[10] - 
	m[12] * m[2] * m[9];
	
    inv[2] = m[1]  * m[6] * m[15] - 
	m[1]  * m[7] * m[14] - 
	m[5]  * m[2] * m[15] + 
	m[5]  * m[3] * m[14] + 
	m[13] * m[2] * m[7] - 
	m[13] * m[3] * m[6];
	
    inv[6] = -m[0]  * m[6] * m[15] + 
	m[0]  * m[7] * m[14] + 
	m[4]  * m[2] * m[15] - 
	m[4]  * m[3] * m[14] - 
	m[12] * m[2] * m[7] + 
	m[12] * m[3] * m[6];
	
    inv[10] = m[0]  * m[5] * m[15] - 
	m[0]  * m[7] * m[13] - 
	m[4]  * m[1] * m[15] + 
	m[4]  * m[3] * m[13] + 
	m[12] * m[1] * m[7] - 
	m[12] * m[3] * m[5];
	
    inv[14] = -m[0]  * m[5] * m[14] + 
	m[0]  * m[6] * m[13] + 
	m[4]  * m[1] * m[14] - 
	m[4]  * m[2] * m[13] - 
	m[12] * m[1] * m[6] + 
	m[12] * m[2] * m[5];
	
    inv[3] = -m[1] * m[6] * m[11] + 
	m[1] * m[7] * m[10] + 
	m[5] * m[2] * m[11] - 
	m[5] * m[3] * m[10] - 
	m[9] * m[2] * m[7] + 
	m[9] * m[3] * m[6];
	
    inv[7] = m[0] * m[6] * m[11] - 
	m[0] * m[7] * m[10] - 
	m[4] * m[2] * m[11] + 
	m[4] * m[3] * m[10] + 
	m[8] * m[2] * m[7] - 
	m[8] * m[3] * m[6];
	
    inv[11] = -m[0] * m[5] * m[11] + 
	m[0] * m[7] * m[9] + 
	m[4] * m[1] * m[11] - 
	m[4] * m[3] * m[9] - 
	m[8] * m[1] * m[7] + 
	m[8] * m[3] * m[5];
	
    inv[15] = m[0] * m[5] * m[10] - 
			  m[0] * m[6] * m[9] - 
			  m[4] * m[1] * m[10] + 
			  m[4] * m[2] * m[9] + 
			  m[8] * m[1] * m[6] - 
			  m[8] * m[2] * m[5];
	
    det = m[0] * inv[0] + m[1] * inv[4] + m[2] * inv[8] + m[3] * inv[12];
	
    if (det == 0) {
        return NO;
	}
	
    det = 1.0 / det;
	
	_m00 = inv[0] * det;
	_m01 = inv[1] * det;
	_m02 = inv[2] * det;
	_m03 = inv[3] * det;
	
	_m10 = inv[4] * det;
	_m11 = inv[5] * det;
	_m12 = inv[6] * det;
	_m13 = inv[7] * det;
	
	_m20 = inv[8] * det;
	_m21 = inv[9] * det;
	_m22 = inv[10] * det;
	_m23 = inv[11] * det;
	
	_m30 = inv[12] * det;
	_m31 = inv[13] * det;
	_m32 = inv[14] * det;
	_m33 = inv[15] * det;
	
    return YES;
}


/*
 * Returns YES if this matrix is an identity one, NO otherwise.
 */
- (BOOL) isIdentity {
	
	if (!(_m00 == 1.0f && _m11 == 1.0f && _m22 == 1.0f && _m33 == 1.0f)) {
		return NO;
	}
	
	if (!(_m01 == 0.0f && _m02 == 0.0f && _m03 == 0.0f
		  && _m10 == 0.0f && _m12 == 0.0f && _m13 == 0.0f
		  && _m20 == 0.0f && _m21 == 0.0f && _m23 == 0.0f
		  && _m30 == 0.0f && _m31 == 0.0f && _m32 == 0.0f)) {
		return NO;
	}
	
	// Passed all the tests so YES this is an identity matrix.
	return YES;
}

@end