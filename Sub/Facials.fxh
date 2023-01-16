//facial controls
//save in shift-jis
//otherwise japanese names dont work
float blink : CONTROLOBJECT < string name = "(self)"; string item = "blink"; >;
float mouth_open : CONTROLOBJECT < string name = "(self)"; string item = "mouth open"; >;


float2 FacialUV(float2 uv)
{
    uv.y += (face_eyes == 1 ? 1 : (face_eyes == 2 ? 2 : 0)) + (face_mouth == 1 ? 3 : 0);
    //this is the default i think? but feel free to change if the model is wrong
    
    if(face_eyes >= 1 ){
    if(blink >= 0.25 && blink <= 0.5){
        uv.x += (face_eyes == 1.0)? 3.0 : 2.0;
        uv.y += (face_eyes == 1.0)? 1.0f : 0.0;
    } else if(blink >= 0.5 && blink <= 0.75){
        uv.x += 1.0f;
        uv.y -= 1.0f;
    } else if (blink >= 0.75){
        uv.x += (face_eyes == 1.0)? 3.0 : 2.0;
        uv.y += (face_eyes == 1.0)? 0.0f : -1.0;
    }
    }// do note the ? expressions here are so you can offset the two manually if needed
    //alternatively you could do uv += (face_# == 1) float2(value,value) : float2(value,value);
    //if you're confident that is
    
    //example of using float2's rather than separately
    if(face_mouth == 1){
        if(mouth_open >= 0.25 && mouth_open <= 0.5){
        uv += float2(0.0, -2.0);
        } else if(mouth_open >= 0.5 && mouth_open <= 0.75){
            uv += float2(0.0, -3.00);
        } else if(mouth_open >= 0.75){
            uv += float2(1.0f, -1.0f);
        }
    }
    //no pressure though! choose whichever you like for how to offset these
    //i tried my best to make sure it's comfort over anything else

    uv /= 4;//needs to be done otherwise you wont get it scaled right
    return uv;
}


//to explain this better
//instead of 0.25/0.5/0.75/1.0

//this would offset everything by full values
//so it'd be 1.0/2.0/3.0/4.0

//unironically i think this would make it more easier for you guys to understand anyways