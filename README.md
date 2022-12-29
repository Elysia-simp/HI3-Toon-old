# Disclaimer

I am not fixing anything if you use this shader on models that were not datamined

I will also not go over how to datamine said models you're on your own there


To prevent anyone from downloading the source code and getting encoding errors I will be posting it ONLY in [Releases](https://github.com/GalacticFairy/HI3-Toon/releases)

This shouldn't be a problem seeing as you'd see the code either way

# Credits
[Manashiku](https://github.com/Manashiku) - For their Facemap code and in general helping me out!

# Usage
in PMX you'll set your Lightmap texture in sph and set that material to Sub_Texture

if there is no lightmap set this material to Disabled

if your mesh is a Face mesh set the FaceMap in toon and set it to +add or any other avaliable sph type

Shader already has flags in place to handle everything for you




Now you'll want to rip the Material files from the game and apply everything that's avaliable 

you should be good to go from there!

Please report any and all (potential) bugs to Isuees or my discord (Chi#4089)

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


Inocorrect

![324324](https://user-images.githubusercontent.com/105132829/209910346-b4e4f250-b0db-4a2f-b383-3cfd5c1f6ce5.png)


Correct

![3](https://user-images.githubusercontent.com/105132829/209910130-ae857e28-30f3-4af4-ae3f-6c268f123e3c.png)


This would also be a problem regardless of if you don't use mmd or not so any adaptations will need to completely remake custom normals either way

# Credits
[Manashiku](https://github.com/Manashiku) - For their Facemap code and in general helping me out!

