# OUTDATED AND WILL EVENETUALLY BE REPLACED WITH [ELYSIAN SHADER](https://github.com/Elysia-simp/Elysian-Shader)

# USE AT YOUR OWN CAUTION





# PLEASE DOWNLOAD FROM [RELEASES](https://github.com/GalacticFairy/HI3-Toon/releases) AND NOT CLONE THE SOURCE CODE IF YOU'RE NOT EDITING THE SHADER

also read the readme on here... I'd rather not have bug reports just me telling you the shader usage is wrong

# Regarding bug reports

Now I can't say I understand why you'd want to use this shader with genshin models

and I'm not saying you can't, But I will say unless the errors partain to Fischl or Keqing (those who actually appeared in honkai)

Any and all bug reports related to genshin models will be disregarded as it's technically not the intended use for this shader

I apologize for any inconveniences

# Disclaimer

I am not fixing anything if you use this shader on models that were not datamined

I will also not go over how to datamine said models you're on your own there

# Credits
[Manashiku](https://github.com/Manashiku) - For their Facemap code and in general helping me out!

# Usage in [Ray-MMD](https://github.com/ray-cast/ray-mmd)
Putting this here incase you already know how to use the shader (see below if you don't)

It's rather simple just load ray.x and then in ray's materials tab set the model to skybox

The model won't interact with directional lights anymore so keep this in mind


# Usage
in PMX you'll set your Lightmap texture in sph and set that material to Sub_Texture

if there is no lightmap set this material to Disabled

if your mesh is a Face mesh set the lightmap in sph like usual and FaceMap in toon and set it to +add or any other avaliable sph type

Shader already has flags in place to handle everything for you

then move colormask and/or eye star into sub/textures and input them into the proper meshes you need them on (optional)


Now you'll want to rip the Material files from the game and apply everything that's avaliable (or guess if you want I guess)

you should be good to go from there!

Please report any and all (potential) bugs to Isuees or my discord (cbtdwg) or if you want to help out with the shader's accuracy

# Rules
1) Please credit me (Chi, Chips, Chizukimo) for the shader or call it by name

2) Do not produce r-18 content with this shader (I'm not having a debate on ages)

3) You are allowed to modify this shader to your hearts content

4) You may distribute the edited Material.fx file for convenience but if you didn't edit the main shader (shader.fxh/sub folder) Please link to here instead

# Word of advice 
Honkai Impact much like Genshin (and other affiliated games) uses custom normals for their outlines HOWEVER honkai is a bit messy with their normals so you'll most likely have to fix it manually

and since mmd can't dedicate the tangent slot like most other programs (typical mmd L)

Fortunately not ALL models are like this just a handful

Examples of incorrect provided

Incorrect

![image](https://user-images.githubusercontent.com/105132829/209909457-d6141e8b-cf94-4cb0-af40-344783dc7c78.png)

Correct

![image](https://user-images.githubusercontent.com/105132829/209909868-8adfa670-fa4e-4e87-891e-e1ab00b4fe54.png)


PMXE visualization


Incorrect

<img width="384" alt="incorrect" src="https://user-images.githubusercontent.com/105132829/211109327-df1a7672-1795-4ac9-bdcb-ef23e1bd7a01.PNG">



Correct

<img width="371" alt="correct" src="https://user-images.githubusercontent.com/105132829/211109342-50373ba9-b847-4337-9c94-8eb99079c6fe.PNG">



This would also be a problem regardless of if you don't use mmd or not so any adaptations will need to completely remake custom normals either way

but in short make sure the INSIDE of the hair normals is reversed rather than facing the same direction as the outer layer
