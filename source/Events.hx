package;

import hxcodec.VideoSprite;
import lime.app.Application;
import gameObjects.userInterface.AudioVisualizer.BarVisualizer;
import gameObjects.userInterface.SquareRiser;
import flixel.effects.particles.FlxEmitter;
import gameObjects.Clock;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import gameObjects.userInterface.PhillyGlow.PhillyGlowParticle;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import meta.FlxTweenPlayState;
import flixel.util.FlxColor;
import flixel.FlxG;
import gameObjects.userInterface.PhillyGlow.PhillyGlowGradient;
import flixel.FlxSprite;
import shaders.ShaderObject;
import flixel.FlxBasic;
import meta.state.PlayState;

class Events {
    var songName:String;

	var textMaps:Map<String, FlxText> = new Map();

	var step:Int;
	var beat:Int;


	// events
	var whiteFlash:FlxSprite;
	var blackOverlay:FlxSprite;
	var whiteOverlay:FlxSprite;
    var pinkOverlay:FlxSprite;
	var phillyGlowGradient:PhillyGlowGradient;
	var phillyGlowGradient2:PhillyGlowGradient;
	var edgybar:FlxSprite;
	var edgybar2:FlxSprite;
	var phillyGlowParticles:FlxTypedSpriteGroup<PhillyGlowParticle>;
	var vignette:FlxSprite;
	var shoot:FlxSprite;
	var red:FlxSprite;
	var glitchTimer:FlxTimer = new FlxTimer();
	var adam:FlxSprite;
	var jonah:FlxSprite;
	var gradientGround:FlxSprite;
	var gradientGround2:FlxSprite;
	var pursuedBars:FlxSprite;
	var forceBump:Float = 1;
	var callText:FlxText;
	var clock:Clock;
	var fog:FlxSprite;
	var square:SquareRiser;
	var redVignette:FlxSprite;
	var suchweakminds:FlxSprite;
	var rememberedBars:FlxSprite;
	var rememberedVisualizer:BarVisualizer;
	var rememberedVisualizer2:BarVisualizer;
	var flashbacks:FlxSprite;
	var adamAndJonah:FlxSprite;
	var sarahAndAdam:FlxSprite;
	var eyes:FlxSprite;
	var scare:FlxSprite;
	var die:FlxSprite;
	var beginningIntro:VideoSprite;
	var statics:FlxSprite;
	var intruder:FlxSprite;
	var staticBg:FlxSprite;

    public function new(name:String)
    {
        songName = name;

        switch (songName) //slily popo david
        {
			case "Befriended":
				initLyrics("Can you hear me?", [0, 0], FlxColor.WHITE, 70, CENTER, true);
				textMaps["Can you hear me?"].screenCenter();
				textMaps["Can you hear me?"].alpha = 0;
				initLyrics("Hello.", [0, 0], FlxColor.WHITE, 70, CENTER, true);
				textMaps["Hello."].screenCenter();
				textMaps["Hello."].alpha = 0;
				initLyrics("Can you keep a\nsecret of mine?", [0, 0], FlxColor.WHITE, 65, CENTER, true);
				textMaps["Can you keep a\nsecret of mine?"].screenCenter();
				textMaps["Can you keep a\nsecret of mine?"].alpha = 0;

				Init.trueSettings['Reduced Movements'] = true;
				Init.trueSettings['No Camera Note Movement'] = true;

				PlayState.camGame.filters = [ShaderObject.getShader("vhs"), ShaderObject.getShader("bloom"), ShaderObject.getShader("chrom"), ShaderObject.getShader("block")];
				ShaderObject.setValue("block.intensity.value", [0]);
				ShaderObject.setValue("bloom.intensity.value", [0]);
				ShaderObject.setValue("chrom.amount.value", [0]);
				ShaderObject.setValue("block.intensity.value", [0]);

				ShaderObject.setValue("bloom.tween", true);
				ShaderObject.setValue("chrom.tween", true);

				for (hud in PlayState.instance.allUIs)
					hud.alpha = 0;

				PlayState.dadOpponent.alpha = 0;

				beginningIntro = new VideoSprite(262, 30);
				beginningIntro.bitmap.onPlaying = function(){
					if (PlayState.instance.paused)
						beginningIntro.bitmap.pause();
				}

				eyes = new FlxSprite(-427, -240);
				eyes.loadGraphic(Paths.image("county-sprites/befriended/eyes"));
				add(eyes, 0);
				eyes.alpha = 0;

				staticBg = new FlxSprite(0, 0);
				staticBg.frames = Paths.getSparrowAtlas("county-sprites/befriended/static");
				staticBg.animation.addByPrefix("static", "static", 24, true);
				staticBg.animation.play("static");
				staticBg.scale.set(2, 2);
				staticBg.visible = false;
				staticBg.scrollFactor.set();
				staticBg.screenCenter();
				staticBg.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(staticBg, 0);

				statics = new FlxSprite(260, 30);
				statics.frames = Paths.getSparrowAtlas("county-sprites/befriended/statics");
				statics.animation.addByPrefix("loop", "static", 24);
				add(statics, 0);
				statics.visible = false;
				statics.animation.play("loop");
				statics.antialiasing = !Init.trueSettings.get('Disable Antialiasing');

				intruder = new FlxSprite(484, 43);
				intruder.loadGraphic(Paths.image("county-sprites/befriended/intruder"));
				add(intruder, 1);
				intruder.alpha = 0;

				vignette = new FlxSprite();
				vignette.loadGraphic(Paths.image("county-sprites/befriended/vignette"));
				vignette.scrollFactor.set();
				add(vignette);

				blackOverlay = new FlxSprite(0, 0);
				blackOverlay.makeGraphic(3000, 3000, FlxColor.BLACK);
				blackOverlay.scrollFactor.set();
				blackOverlay.screenCenter();
				blackOverlay.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(blackOverlay);

				PlayState.lockCamPos = true;
			case "Awakened":
				Init.trueSettings['No Camera Note Movement'] = false;
				Init.trueSettings['Reduced Movements'] = false;

				PlayState.camGame.filters = [ShaderObject.getShader("vhs"), ShaderObject.getShader("bloom"), ShaderObject.getShader("block")];
				ShaderObject.setValue("block.intensity.value", [0]);
				ShaderObject.setValue("bloom.intensity.value", [0]);

				ShaderObject.setValue("bloom.tween", true);

				for (hud in PlayState.instance.allUIs)
					hud.visible = false;

				shoot = new FlxSprite();
				shoot.frames = Paths.getSparrowAtlas("county-sprites/awakened/shooteffect");
				shoot.animation.addByPrefix("shoot", "static instance 1", 24);
				shoot.scale.set(1 / 0.3, 1 / 0.3);
				shoot.alpha = 0;
				shoot.scrollFactor.set();
				shoot.animation.play("shoot");
				shoot.screenCenter();
				shoot.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(shoot);

				blackOverlay = new FlxSprite(0, -30);
				blackOverlay.makeGraphic(3000, 3000, FlxColor.BLACK);
				blackOverlay.screenCenter();
				blackOverlay.scrollFactor.set();
				blackOverlay.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(blackOverlay);

			case "Pursued":
				Init.trueSettings['No Camera Note Movement'] = false;
				Init.trueSettings['Reduced Movements'] = false;

				initLyrics("TIME'S RUNNING OUT, LIEUTENANT!", [0, 700], FlxColor.RED, 70, CENTER, true);
				textMaps["TIME'S RUNNING OUT, LIEUTENANT!"].screenCenter(X);
				textMaps["TIME'S RUNNING OUT, LIEUTENANT!"].alpha = 0;
				initLyrics("WORTHLESS.", [0, 0], FlxColor.RED, 80, CENTER, true);
				textMaps["WORTHLESS."].screenCenter();
				textMaps["WORTHLESS."].alpha = 0;
				initLyrics("PUT YOUR SERVICE WEAPON", [0, 0], FlxColor.RED, 60, CENTER, true);
				textMaps["PUT YOUR SERVICE WEAPON"].screenCenter();
				textMaps["PUT YOUR SERVICE WEAPON"].alpha = 0.3;
				initLyrics("IN YOUR MOUTH.", [0, 0], FlxColor.RED, 60, CENTER, true);
				textMaps["IN YOUR MOUTH."].screenCenter();
				textMaps["IN YOUR MOUTH."].alpha = 0.3;
				initLyrics("STOP\nOR I'LL\nSHOOT!", [0, 0], FlxColor.RED, 80, CENTER, true);
				textMaps["STOP\nOR I'LL\nSHOOT!"].screenCenter();

				PlayState.camGame.filters = [ShaderObject.getShader("vhs"), ShaderObject.getShader("block")];
				ShaderObject.setValue("block.intensity.value", [0]);

				PlayState.dadOpponent.visible = false;
				FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 0}, 0.000000000001);

				for (hud in PlayState.instance.allUIs)
					hud.visible = false;

				fog = new FlxSprite();
				fog.frames = Paths.getSparrowAtlas("county-sprites/pursued/fog");
				fog.animation.addByPrefix("fog", "fog", 10);
				fog.animation.play("fog");
				fog.scrollFactor.set();
				fog.screenCenter();
				fog.alpha = 0.45;
				fog.visible = false;
				add(fog);

				redVignette = new FlxSprite();
				redVignette.loadGraphic(Paths.image("county-sprites/pursued/redVignette"));
				redVignette.scrollFactor.set();
				redVignette.screenCenter();
				redVignette.alpha = 0;
				redVignette.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(redVignette);

				callText = new FlxText(577, 601, 0, "", 56);
				callText.font = Paths.font("tinos.ttf");
				callText.color = 0xff000000;
				add(callText);

				pursuedBars = new FlxSprite(0, 0, Paths.image("county-sprites/pursued/bars"));
				pursuedBars.scrollFactor.set(0, 0);
				pursuedBars.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				pursuedBars.screenCenter();
				add(pursuedBars);
				pursuedBars.visible = false;

				red = new FlxSprite();
				red.makeGraphic(1280, 720, FlxColor.RED); // i wonder who's the person with the red outfit in the county funkin team, and American
				red.scrollFactor.set();
				red.screenCenter();
				red.visible = false;
				add(red);

				clock = new Clock();
				clock.screenCenter();
				add(clock);
				clock.alpha = 0;

			case "Remembered":
				initLyrics("Do you remember", [320, 280], FlxColor.WHITE, 70, CENTER, true);
				initLyrics("ME?", [550, 400], FlxColor.RED, 80, CENTER, true);
				initLyrics("The flicker of\nthe TV\nilluminated\nthis bedroom...", [310, 243], FlxColor.WHITE, 70, CENTER, true);
				initLyrics("Drowning out the\ndarkness with\nhis favourite\nprograms.", [300, 255], FlxColor.WHITE, 70, CENTER, true);
				initLyrics("Do you remember\nhow we became", [320, 280], FlxColor.WHITE, 70, CENTER, true);
				initLyrics("FRIENDS?", [440, 410], FlxColor.RED, 80, CENTER, true);
				initLyrics("Do you remember\nmy face?", [440, 410], FlxColor.WHITE, 100, CENTER, true);
				textMaps["Do you remember\nmy face?"].alpha = 0.4;
				textMaps["Do you remember\nmy face?"].screenCenter();
				initLyrics("With contorted flesh\nand broken bones...", [440, 410], FlxColor.WHITE, 100, CENTER, true);
				textMaps["With contorted flesh\nand broken bones..."].alpha = 0.4;
				textMaps["With contorted flesh\nand broken bones..."].screenCenter();
				initLyrics("I MADE MYSELF KNOWN.", [440, 410], FlxColor.RED, 100, CENTER, true);
				textMaps["I MADE MYSELF KNOWN."].alpha = 0.5;
				textMaps["I MADE MYSELF KNOWN."].screenCenter();
				initLyrics("Do you remember\nmy touch?", [440, 410], FlxColor.WHITE, 100, CENTER, true);
				textMaps["Do you remember\nmy touch?"].alpha = 0.4;
				textMaps["Do you remember\nmy touch?"].screenCenter();
				initLyrics("I cradled him\nin my arms...", [440, 410], FlxColor.WHITE, 100, CENTER, true);
				textMaps["I cradled him\nin my arms..."].alpha = 0.4;
				textMaps["I cradled him\nin my arms..."].screenCenter();
				initLyrics("MY SWEET BOY.", [440, 410], FlxColor.RED, 100, CENTER, true);
				textMaps["MY SWEET BOY."].alpha = 0.5;
				textMaps["MY SWEET BOY."].screenCenter();
				initLyrics("I took him away.", [440, 410], FlxColor.WHITE, 100, CENTER, true);
				textMaps["I took him away."].alpha = 0.4;
				textMaps["I took him away."].screenCenter();
				initLyrics("Do you remember\nthat night, Murray?", [440, 410], FlxColor.WHITE, 100, CENTER, true);
				textMaps["Do you remember\nthat night, Murray?"].alpha = 0.4;
				textMaps["Do you remember\nthat night, Murray?"].screenCenter();
				initLyrics("When you stare\ninto the mirror...", [440, 410], FlxColor.WHITE, 100, CENTER, true);
				textMaps["When you stare\ninto the mirror..."].alpha = 0.4;
				textMaps["When you stare\ninto the mirror..."].screenCenter();
				initLyrics("You see the\nsame monsters from\nyour bedroom...", [440, 410], FlxColor.WHITE, 100, CENTER, true);
				textMaps["You see the\nsame monsters from\nyour bedroom..."].alpha = 0.4;
				textMaps["You see the\nsame monsters from\nyour bedroom..."].screenCenter();
				initLyrics("Don't you?", [440, 410], FlxColor.WHITE, 100, CENTER, true);
				textMaps["Don't you?"].alpha = 0.4;
				textMaps["Don't you?"].screenCenter();
				initLyrics("BUT YOUR SKIN\nIS NOT YOUR OWN.", [440, 410], FlxColor.RED, 100, CENTER, true);
				textMaps["BUT YOUR SKIN\nIS NOT YOUR OWN."].alpha = 0.5;
				textMaps["BUT YOUR SKIN\nIS NOT YOUR OWN."].screenCenter();
				initLyrics("YOU'RE NOT\nTHE REAL YOU.", [440, 410], FlxColor.RED, 100, CENTER, true);
				textMaps["YOU'RE NOT\nTHE REAL YOU."].alpha = 0.5;
				textMaps["YOU'RE NOT\nTHE REAL YOU."].screenCenter();
				Init.trueSettings['Reduced Movements'] = false;
				Init.trueSettings['No Camera Note Movement'] = true;
				PlayState.focus = BF;
				PlayState.lockFocus = true;

				PlayState.dadOpponent.visible = false;

				PlayState.camGame.filters = [ShaderObject.getShader("vhs"), ShaderObject.getShader("bloom"), ShaderObject.getShader("block")];
				ShaderObject.setValue("bloom.intensity.value", [0]);
				ShaderObject.setValue("block.intensity.value", [0]);
				ShaderObject.setValue("bloom.tween", false);

				for (hud in PlayState.instance.allUIs)
					hud.alpha = 0;

				FlxTweenPlayState.shake(textMaps["ME?"], 0.03, 12, X);

				add(textMaps["Do you remember"]);
				add(textMaps["ME?"]);
				textMaps["Do you remember"].alpha = 0;
				textMaps["ME?"].alpha = 0;

				flashbacks = new FlxSprite();
				flashbacks.frames = Paths.getSparrowAtlas("county-sprites/remembered/flashbacks");
				flashbacks.animation.addByPrefix("flash", "flashbacks", 24);
				flashbacks.scrollFactor.set();
				flashbacks.animation.play("flash");
				flashbacks.screenCenter();
				flashbacks.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				flashbacks.alpha = 0.5;
				flashbacks.visible = false;
				add(flashbacks, 5);

				sarahAndAdam = new FlxSprite();
				sarahAndAdam.loadGraphic(Paths.image("county-sprites/remembered/gals"));
				sarahAndAdam.scrollFactor.set();
				sarahAndAdam.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				sarahAndAdam.alpha = 0;
				sarahAndAdam.screenCenter();
				add(sarahAndAdam, 5);

				adamAndJonah = new FlxSprite();
				adamAndJonah.loadGraphic(Paths.image("county-sprites/remembered/guys"));
				adamAndJonah.scrollFactor.set();
				adamAndJonah.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				adamAndJonah.alpha = 0;
				adamAndJonah.screenCenter();
				add(adamAndJonah, 5);

				whiteFlash = new FlxSprite();
				whiteFlash.makeGraphic(1, 1);
				whiteFlash.scale.set(9000, 9000);
				whiteFlash.updateHitbox();
				whiteFlash.scrollFactor.set();
				whiteFlash.screenCenter();
				whiteFlash.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(whiteFlash, 5);
				whiteFlash.alpha = 0;

				eyes = new FlxSprite();
				eyes.loadGraphic(Paths.image("county-sprites/remembered/eyes"));
				eyes.scrollFactor.set();
				eyes.screenCenter();
				eyes.alpha = 0.15;
				eyes.visible = false;
				add(eyes, 5);

				rememberedVisualizer = new BarVisualizer(0, 20, 35, Std.int(20 / 0.6), 12, "assets/songs/remembered/kys.txt", {
					minHeight: 5,
					maxHeight: 420,
					startingSpectrum: 3,
					multiplier: 1
				});
				rememberedVisualizer.audio = PlayState.songMusic;
				rememberedVisualizer.active = false;
				rememberedVisualizer.visible = false;
				rememberedVisualizer.alpha = 0.7;
				add(rememberedVisualizer);

				rememberedVisualizer2 = new BarVisualizer(0, 1020, 35, Std.int(20 / 0.6), 12, "assets/songs/remembered/kys.txt", {
					minHeight: 5,
					maxHeight: 420,
					startingSpectrum: 3,
					multiplier: 1
				});
				rememberedVisualizer2.audio = PlayState.songMusic;
				rememberedVisualizer2.flipY = true;
				rememberedVisualizer2.flipX = true;
				rememberedVisualizer2.active = false;
				rememberedVisualizer2.visible = false;
				rememberedVisualizer2.alpha = 0.7;
				add(rememberedVisualizer2);

				rememberedBars = new FlxSprite();
				rememberedBars.loadGraphic(Paths.image("county-sprites/remembered/bars"));
				rememberedBars.scrollFactor.set();
				rememberedBars.screenCenter();
				rememberedBars.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				rememberedBars.visible = false;
				add(rememberedBars);

				blackOverlay = new FlxSprite();
				blackOverlay.makeGraphic(1, 1, FlxColor.BLACK);
				blackOverlay.scale.set(9000, 9000);
				blackOverlay.updateHitbox();
				blackOverlay.scrollFactor.set();
				blackOverlay.screenCenter();
				blackOverlay.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(blackOverlay);

				scare = new FlxSprite();
				scare.loadGraphic(Paths.image("county-sprites/remembered/scare"));
				scare.scrollFactor.set();
				scare.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				scare.alpha = 0;
				scare.screenCenter();
				add(scare);

				die = new FlxSprite();
				die.loadGraphic(Paths.image("county-sprites/remembered/die"));
				die.scrollFactor.set();
				die.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				die.alpha = 0;
				die.screenCenter();
				add(die);
			
			case "Deceived":
				Init.trueSettings['No Camera Note Movement'] = true;
				Init.trueSettings['Reduced Movements'] = false;
				PlayState.camGame.filters = [ShaderObject.getShader("vhs"), ShaderObject.getShader("block"), ShaderObject.getShader("bloom"), ShaderObject.getShader("chrom")];
				ShaderObject.setValue("bloom.intensity.value", [0]);
				ShaderObject.setValue("chrom.amount.value", [0]);
				ShaderObject.setValue("block.intensity.value", [0]);
				ShaderObject.setValue("bloom.tween", false);
				ShaderObject.setValue("chrom.tween", false);

				PlayState.boyfriend.setColorTransform(1, 1, 1, 1, 255, 255, 255);
				PlayState.dadOpponent.setColorTransform(1, 1, 1, 1, 255, 255, 255);
				PlayState.boyfriend.alpha = 0;
				PlayState.dadOpponent.alpha = 0;

				for (hud in PlayState.instance.allUIs)
					hud.alpha = 0;

				PlayState.instance.stageBuild.foreground.members[0].visible = false;
				PlayState.instance.stageBuild.background.members[0].visible = false;
				PlayState.instance.stageBuild.background.members[1].visible = false;

				PlayState.focus = NONE;
				PlayState.instance.camFollow.setPosition(2207.4125, 909.475);
				PlayState.lockFocus = true;
				PlayState.lockCamPos = true;

				whiteFlash = new FlxSprite();
				whiteFlash.makeGraphic(1, 1);
				whiteFlash.scale.set(9000, 9000);
				whiteFlash.updateHitbox();
				whiteFlash.scrollFactor.set();
				whiteFlash.screenCenter();
				whiteFlash.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(whiteFlash, 0);
				whiteFlash.alpha = 0;

				suchweakminds = new FlxSprite(600, 350);
				suchweakminds.frames = Paths.getSparrowAtlas("county-sprites/deceived/suchweakminds");
				suchweakminds.animation.addByPrefix("scroll", "scroll");
				suchweakminds.animation.play("scroll");
				suchweakminds.scale.set(1/0.4, 1/0.4);
				suchweakminds.visible = false;
				suchweakminds.active = false;
				suchweakminds.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(suchweakminds, 0);

				redVignette = new FlxSprite();
				redVignette.loadGraphic(Paths.image("county-sprites/deceived/redVignette"));
				redVignette.scrollFactor.set();
				redVignette.screenCenter();
				redVignette.visible = false;
				redVignette.alpha = 0.2;
				redVignette.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				FlxTween.tween(redVignette, {alpha: 0.5}, 1, {startDelay: 1, ease: FlxEase.sineInOut, type: PINGPONG});
				add(redVignette);

				blackOverlay = new FlxSprite();
				blackOverlay.makeGraphic(1, 1, FlxColor.BLACK);
				blackOverlay.scale.set(9000, 9000);
				blackOverlay.updateHitbox();
				blackOverlay.scrollFactor.set();
				blackOverlay.screenCenter();
				blackOverlay.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(blackOverlay);
				blackOverlay.alpha = 0;

				square = new SquareRiser();
				square.minX = -3000;
				square.maxX = 3000;
				square.visible = false;
				add(square, 0);
				

			case "Lured":
				initLyrics("What's the matter?", [298.25, 298.35], FlxColor.WHITE, 66, FlxTextAlign.LEFT);
				textMaps["What's the matter?"].screenCenter();
				textMaps["What's the matter?"].y -= 30;
				textMaps["What's the matter?"].alpha = 0.4;
				initLyrics("Cat got your tongue?", [245.25, 298.35], FlxColor.WHITE, 66, FlxTextAlign.LEFT);
				textMaps["Cat got your tongue?"].screenCenter();
				textMaps["Cat got your tongue?"].y -= 30;
				textMaps["Cat got your tongue?"].alpha = 0.4;
				initLyrics("DON'T.", [504.25, 298.35], FlxColor.WHITE, 86, FlxTextAlign.LEFT);
				textMaps["DON'T."].screenCenter();
				textMaps["DON'T."].y -= 30;
				initLyrics("JUST DON'T.", [369.25, 298.35], FlxColor.WHITE, 86, FlxTextAlign.LEFT);
				textMaps["JUST DON'T."].screenCenter();
				textMaps["JUST DON'T."].y -= 30;
				initLyrics("Okay?...", [442.25, 298.35], FlxColor.WHITE, 86, FlxTextAlign.LEFT);
				textMaps["Okay?..."].screenCenter();
				textMaps["Okay?..."].y -= 30;
				initLyrics("PLEASE.", [470.25, 298.35], FlxColor.WHITE, 86, FlxTextAlign.LEFT);
				textMaps["PLEASE."].screenCenter();
				textMaps["PLEASE."].y -= 30;
				initLyrics("Oh, so NOW you're \ntaking this\nseriously.", [10, 298.35], FlxColor.WHITE, 46, FlxTextAlign.LEFT);
				initLyrics("Dude, I don't know\nwhat you want\nfrom me", [10, 298.35], FlxColor.WHITE, 46, FlxTextAlign.RIGHT);
				textMaps["Dude, I don't know\nwhat you want\nfrom me"].x = FlxG.width - textMaps["Dude, I don't know\nwhat you want\nfrom me"].width - 10;
				initLyrics("I'm as serious now\nas i've ever been.", [10, 298.35], FlxColor.WHITE, 46, FlxTextAlign.RIGHT);
				textMaps["I'm as serious now\nas i've ever been."].x = FlxG.width - textMaps["I'm as serious now\nas i've ever been."].width - 10;
				initLyrics("This whole time, huh?", [10, 298.35], FlxColor.WHITE, 46, FlxTextAlign.LEFT);
				initLyrics("So you FUCKING with me\nwas you being serious.", [10, 298.35], FlxColor.WHITE, 46, FlxTextAlign.LEFT);
				initLyrics("I get that I screw around\nsometimes, okay?", [10, 298.35], FlxColor.WHITE, 46, FlxTextAlign.RIGHT);
				textMaps["I get that I screw around\nsometimes, okay?"].x = FlxG.width - textMaps["I get that I screw around\nsometimes, okay?"].width - 10;
				initLyrics("But that's just what i do!", [10, 298.35], FlxColor.WHITE, 46, FlxTextAlign.RIGHT);
				textMaps["But that's just what i do!"].x = FlxG.width - textMaps["But that's just what i do!"].width - 10;
				initLyrics("Well maybe it\nshouldn't be.", [10, 298.35], FlxColor.WHITE, 46, FlxTextAlign.LEFT);
				initLyrics("Look man, I'm just\nDEVASTATED that I'm not as\nBROKEN as you are", [10, 298.35], FlxColor.WHITE, 46, FlxTextAlign.RIGHT);
				textMaps["Look man, I'm just\nDEVASTATED that I'm not as\nBROKEN as you are"].x = FlxG.width - textMaps["Look man, I'm just\nDEVASTATED that I'm not as\nBROKEN as you are"].width - 10;
				initLyrics("With EVERYTHING\nthat's happened", [10, 298.35], FlxColor.WHITE, 46, FlxTextAlign.RIGHT);
				textMaps["With EVERYTHING\nthat's happened"].x = FlxG.width - textMaps["With EVERYTHING\nthat's happened"].width - 10;
				initLyrics("And I'm sorry that I\ncan't help you\ncarry this burden.", [10, 298.35], FlxColor.WHITE, 46, FlxTextAlign.RIGHT);
				textMaps["And I'm sorry that I\ncan't help you\ncarry this burden."].x = FlxG.width - textMaps["And I'm sorry that I\ncan't help you\ncarry this burden."].width - 10;
				initLyrics("And I'm sorry that I\ncan't helpppppppppppppppppppppppppp\nppppppppppppppppppppppppppppppppppppppppppp\npppppppppppppppppppppppppppppppppppppppppp\nppppppppppppppppppppppppppppppppppppppppppp\npppppppppppppppppppppppppppppppppppppppppp",
					[10, 298.35], FlxColor.WHITE, 46, FlxTextAlign.RIGHT);
				textMaps["And I'm sorry that I\ncan't helpppppppppppppppppppppppppp\nppppppppppppppppppppppppppppppppppppppppppp\npppppppppppppppppppppppppppppppppppppppppp\nppppppppppppppppppppppppppppppppppppppppppp\npppppppppppppppppppppppppppppppppppppppppp"].x = FlxG.width - textMaps["And I'm sorry that I\ncan't helpppppppppppppppppppppppppp\nppppppppppppppppppppppppppppppppppppppppppp\npppppppppppppppppppppppppppppppppppppppppp\nppppppppppppppppppppppppppppppppppppppppppp\npppppppppppppppppppppppppppppppppppppppppp"].width - 10;
				initLyrics("OH MY GOD", [10, 298.35], FlxColor.WHITE, 76);
				initLyrics("BEHIND YOU!", [10, 298.35], FlxColor.WHITE, 86);

				PlayState.camGame.filters = [ShaderObject.getShader("vhs"), ShaderObject.getShader("block")];
				ShaderObject.setValue("block.intensity.value", [0]);

				Init.trueSettings['No Camera Note Movement'] = true;
				Init.trueSettings['Reduced Movements'] = false;

				adam = new FlxSprite();
				adam.loadGraphic(Paths.image("county-sprites/lured/Adam"));
				adam.scrollFactor.set();
				adam.scale.set(2.2, 2.2);
				adam.screenCenter();
				adam.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(adam);
				adam.alpha = 0;
				adam.y -= 30;

				jonah = new FlxSprite();
				jonah.loadGraphic(Paths.image("county-sprites/lured/Jonah"));
				jonah.scrollFactor.set();
				jonah.scale.set(2.2, 2.2);
				jonah.screenCenter();
				jonah.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(jonah);
				jonah.alpha = 0;
				jonah.y -= 30;

				whiteFlash = new FlxSprite();
				whiteFlash.makeGraphic(3000, 3000);
				whiteFlash.scrollFactor.set();
				whiteFlash.screenCenter();
				whiteFlash.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(whiteFlash, 4);
				whiteFlash.alpha = 0;
			case "Followed":
				Init.trueSettings['No Camera Note Movement'] = false;
				Init.trueSettings['Reduced Movements'] = false;

				PlayState.camGame.filters = [ShaderObject.getShader("glitch"), ShaderObject.getShader("vhs"), ShaderObject.getShader("block")];
				ShaderObject.setValue("glitch.isDad.value", [false]);
				ShaderObject.setValue("block.intensity.value", [0]);

				PlayState.focus = BF;
				PlayState.lockFocus = true;

				PlayState.camGame.alpha = 0;
				PlayState.dadOpponent.visible = false;
				PlayState.instance.stageBuild.background.members[0].visible = false;

				initLyrics("L", [191.95, 123.85], 0xffffffff, 160);
				initLyrics("LL", [191.95, 123.85], 0xffffffff, 160);
				initLyrics("LLL", [191.95, 123.85], 0xffffffff, 160);
				initLyrics("LET", [191.95, 123.85], 0xffffffff, 160);
				initLyrics("ME", [577, 123.85], 0xffffffff, 160);
				initLyrics("IN", [888, 123.85], 0xffffffff, 160);
				initLyrics("MARK.", [464, 412.4], 0xffff0000, 160);
				initLyrics("YOU", [483.69, 30.9], 0xffff0000, 160);
				initLyrics("FUCKING", [317.25, 263.3], 0xffff0000, 160);
				initLyrics("BASTARD!", [278.2, 490.65], 0xffff0000, 160);
				initLyrics("KILL", [487.2, 131.1], 0xffff0000, 160);
				initLyrics("YOURSELF.", [288.3, 397.8], 0xffff0000, 160);

				whiteFlash = new FlxSprite();
				whiteFlash.makeGraphic(3000, 3000);
				whiteFlash.scrollFactor.set();
				whiteFlash.screenCenter();
				whiteFlash.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(whiteFlash, 4);
				whiteFlash.alpha = 0;

				shoot = new FlxSprite();
				shoot.frames = Paths.getSparrowAtlas("county-sprites/followed/shooteffect");
				shoot.animation.addByPrefix("shoot", "static instance 1", 24);
				shoot.scale.set(1/0.3, 1/0.3);
				shoot.alpha = 0;
				shoot.scrollFactor.set();
				shoot.animation.play("shoot");
				shoot.screenCenter();
				shoot.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(shoot);

				red = new FlxSprite();
				red.makeGraphic(3000, 3000, FlxColor.RED); // i wonder who's the person with the red outfit in the county funkin team, and American
				red.scrollFactor.set();
				red.screenCenter();
				red.visible = false;
				add(red);

				vignette = new FlxSprite();
				vignette.loadGraphic(Paths.image("county-sprites/followed/vignette"));
				vignette.scale.set(1 / (2559 / FlxG.width), 1 / (1399 / FlxG.height));
				vignette.updateHitbox();
				vignette.scrollFactor.set();
				vignette.antialiasing = true;
				vignette.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				vignette.screenCenter();
				add(vignette);

			case "Expedited":
				Init.trueSettings['No Camera Note Movement'] = true;
				Init.trueSettings['Reduced Movements'] = false;

				initLyrics("Could you do me a favor?", [287, 330], 0xffff0000, 52, FlxTextAlign.CENTER);
				textMaps["Could you do me a favor?"].screenCenter();
				initLyrics("Yeah, of course!", [427, 330], 0xffffffff, 52, FlxTextAlign.CENTER);
				textMaps["Yeah, of course!"].screenCenter();

				for (cam in PlayState.instance.allUIs)
					cam.visible = false;
	
				PlayState.focus = NONE;
				var stage1 = PlayState.instance.stageBuild.background.members[0].getMidpoint();
				var stage2 = PlayState.instance.stageBuild.background.members[1].getMidpoint();

				var centerX = (stage2.x + stage1.x) / 2;
				var centerY = (stage1.y + stage2.y) / 2;
				PlayState.instance.camFollow.setPosition(centerX, centerY);
				PlayState.lockCamPos = true;

				PlayState.camGame.filters = [ShaderObject.getShader("vhs"), ShaderObject.getShader("block")];
				ShaderObject.setValue("block.intensity.value", [0]);
				

				phillyGlowParticles = new FlxTypedSpriteGroup<PhillyGlowParticle>();
				phillyGlowParticles.alpha = 0;
				phillyGlowParticles.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(phillyGlowParticles, 0);

				phillyGlowGradient = new PhillyGlowGradient(-1000, 480);
				phillyGlowGradient.scrollFactor.set();
				phillyGlowGradient.intendedAlpha = 0;
				phillyGlowGradient.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(phillyGlowGradient, 0);

				whiteFlash = new FlxSprite();
				whiteFlash.makeGraphic(3000, 3000);
				whiteFlash.scrollFactor.set();
				whiteFlash.screenCenter();
				whiteFlash.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(whiteFlash, 0);
				whiteFlash.alpha = 0;

				blackOverlay = new FlxSprite();
				blackOverlay.makeGraphic(3000, 3000, FlxColor.BLACK);
				blackOverlay.scrollFactor.set();
				blackOverlay.screenCenter();
				blackOverlay.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(blackOverlay);
				blackOverlay.alpha = 1;

            case "Traumatized":
				Init.trueSettings['No Camera Note Movement'] = true;
				Init.trueSettings['Reduced Movements'] = false;

                PlayState.focus = BF;
				PlayState.camGame.filters = [ShaderObject.getShader("vhs"), ShaderObject.getShader("block")];
				ShaderObject.setValue("block.intensity.value", [0]);

				pinkOverlay = new FlxSprite(0, -30);
				pinkOverlay.makeGraphic(3000, 3000, 0xffFF83D6);
				pinkOverlay.alpha = 0;
				pinkOverlay.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(pinkOverlay);

				phillyGlowGradient = new PhillyGlowGradient(0, -150);
				phillyGlowGradient.scrollFactor.set();
				phillyGlowGradient.intendedAlpha = 0.7;
				phillyGlowGradient.flipY = true;
				phillyGlowGradient.visible = false;
				phillyGlowGradient.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(phillyGlowGradient);

				phillyGlowGradient2 = new PhillyGlowGradient(0, 0);
				phillyGlowGradient2.scrollFactor.set();
				phillyGlowGradient2.intendedAlpha = 0.7;
				phillyGlowGradient2.visible = false;
				phillyGlowGradient2.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(phillyGlowGradient2);

				blackOverlay = new FlxSprite(0, -30);
				blackOverlay.makeGraphic(3000, 3000, FlxColor.BLACK);
				blackOverlay.alpha = 0.5;
				blackOverlay.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(blackOverlay);

				whiteOverlay = new FlxSprite(0, -30);
				whiteOverlay.makeGraphic(3000, 3000, FlxColor.WHITE);
				whiteOverlay.alpha = 0;
				whiteOverlay.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(whiteOverlay);

				edgybar = new FlxSprite();
				edgybar.makeGraphic(1280, 100, FlxColor.BLACK);
				edgybar.scrollFactor.set();
				edgybar.screenCenter(X);
				edgybar.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				add(edgybar);

				edgybar2 = new FlxSprite();
				edgybar2.makeGraphic(1280, 100, FlxColor.BLACK);
				edgybar2.scrollFactor.set();
				edgybar2.y = FlxG.height - edgybar2.height;
				edgybar2.screenCenter(X);
				edgybar2.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
                add(edgybar2);
        }
    }

    public function onStep(curStep:Int)
    {
		step = curStep;
        switch (songName)
        {
			case "Awakened":
				if (step == 1)
				{
					FlxTweenPlayState.num(1, 0.5, 17, {ease: FlxEase.sineOut}, e -> {
						PlayState.camGame.zoom = e;
						PlayState.defaultCamZoom = e;
					});
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0}, 17, {ease: FlxEase.sineOut});
				}
				if (step == 256)
					blackOverlay.alpha = 1;
				if (step == 272)
				{
					for (hud in PlayState.instance.allUIs)
						hud.visible = true;
					blackOverlay.alpha = 0;
				}
				if (step == 528)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 640)
					FlxTweenPlayState.tween(blackOverlay, {alpha: 1}, 0.6, {ease: FlxEase.sineOut});
				if (step == 656)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					blackOverlay.alpha = 0;

					PlayState.dadOpponent.setCharacter(480, -525, "awakenedGabrielAlt");
					PlayState.dadOpponent.setPosition(480, -525);
				}
				if (step == 912)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.3}, 0.4, {ease: FlxEase.sineOut});
					PlayState.defaultCamZoom = 0.6;
				}
				if (step == 976)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0}, 0.4, {ease: FlxEase.sineOut});
					PlayState.defaultCamZoom = 0.5;
				}
				if (step == 1032)
					FlxTweenPlayState.tween(blackOverlay, {alpha: 1}, 0.2, {ease: FlxEase.sineOut});
				if (step == 1040)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					blackOverlay.alpha = 0;
				}
				if (step == 1152)
					FlxTweenPlayState.tween(blackOverlay, {alpha: 1}, 0.6, {ease: FlxEase.sineOut});
				if (step == 1168)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					blackOverlay.alpha = 0;
				}
				if (step == 1424)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					blackOverlay.alpha = 1;
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0}, 10, {ease: FlxEase.sineOut});
				}
				if (step == 1670)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.4}, 0.2, {ease: FlxEase.sineOut});
					PlayState.defaultCamZoom = 0.6;
				}
				if (step == 1680)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					blackOverlay.alpha = 0;
					PlayState.defaultCamZoom = 0.5;

					FlxTweenPlayState.tween(blackOverlay, {alpha: 0}, 10, {ease: FlxEase.sineOut});
				}
				if (step == 1808)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 1936)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.3}, 0.4, {ease: FlxEase.sineOut});
					PlayState.defaultCamZoom = 0.6;
				}
				if (step == 1936 || step == 1952 || step == 1968 || step == 2000 || step == 2016 || step == 2032)
				{
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.15;
					FlxTweenPlayState.tween(shoot, {alpha: 0.9}, 0.4, {type: BACKWARD});
				}
				if (step == 2064)
				{
					blackOverlay.alpha = 0;
					PlayState.defaultCamZoom = 0.5;

					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 2192)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 2448)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.4}, 0.4, {ease: FlxEase.sineOut});
					PlayState.defaultCamZoom = 0.6;
				}
				if (step == 2464)
				{
					blackOverlay.alpha = 1;
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0}, 20, {ease: FlxEase.sineOut});

					FlxTweenPlayState.num(1.4, 0.5, 20, {ease: FlxEase.sineOut}, e ->
					{
						PlayState.camGame.zoom = e;
						PlayState.defaultCamZoom = e;
					});

					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 2736)
				{
					PlayState.dadOpponent.color = FlxColor.BLACK;
					PlayState.boyfriend.color = FlxColor.BLACK;
					PlayState.instance.stageBuild.foreground.members[0].color = FlxColor.BLACK;
					
					PlayState.boyfriend.playAnim("death", true);
					PlayState.boyfriend.debugMode = true;

					PlayState.instance.stageBuild.background.members[0].visible = false;
					PlayState.instance.stageBuild.background.members[1].visible = false;
					PlayState.instance.stageBuild.background.members[2].visible = false;
					PlayState.instance.stageBuild.background.members[3].visible = false;

					PlayState.camGame.bgColor = FlxColor.RED;
				}
			case "Befriended":
				if (step == 1)
				{
					beginningIntro.playVideo("assets/images/county-sprites/befriended/beginning.mp4");
					add(beginningIntro, 5);

					FlxTweenPlayState.tween(blackOverlay, {alpha: 0}, 2, {ease: FlxEase.sineInOut});
					
					FlxTweenPlayState.num(2.7, 1.4, 27, {ease: FlxEase.sineOut}, e -> {
						PlayState.defaultCamZoom = e;
						PlayState.camGame.zoom = e;
					});
				}
				if (step == 231)
				{
					FlxTweenPlayState.num(0, 0.01, 2.5, {ease: FlxEase.sineInOut}, e ->
						PlayState.camGame.shake(e, 0.05)
					);
				}
				if (step == 256)
					blackOverlay.alpha = 1;
				if (step == 269)
				{
					PlayState.defaultCamZoom = 1;
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0}, 1, {ease: FlxEase.sineInOut});

					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.tween(hud, {alpha: 1}, 1, {ease: FlxEase.sineInOut});
				}
				if (step == 288)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
					
					Init.trueSettings['Reduced Movements'] = false;

					beginningIntro.destroy();
					
					statics.visible = true;
				}
				if (step == 416)
				{
					PlayState.camGame.zoom += 0.3;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					FlxTweenPlayState.tween(vignette, {alpha: 0.7}, 0.4);
				}
				if (step == 534)
					FlxTweenPlayState.tween(blackOverlay, {alpha: 1}, 0.8);
				if (step == 544)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
					
					FlxTweenPlayState.cancelTweensOf(blackOverlay);
					blackOverlay.alpha = 0;
				}
				if (step == 680)
				{
					FlxTweenPlayState.tween(statics, {alpha: 0}, 0.6, {ease: FlxEase.sineIn});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.foreground.members[1], {alpha: 1}, 0.6, {ease: FlxEase.sineIn});
				}
				if (step == 688)
				{
					PlayState.dadOpponent.x = 40;
					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 0.6, x: 340}, 0.7, {ease: FlxEase.sineOut});
				}
				if (step == 704)
					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 0, x: 640}, 0.7, {ease: FlxEase.sineOut});
				if (step == 720)
					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 0.6, x: 340}, 0.7, {ease: FlxEase.sineOut});
				if (step == 768)
					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 0, x: 40}, 0.7, {ease: FlxEase.sineOut});
				if (step == 784)
				{
					PlayState.dadOpponent.x = 340;

					PlayState.defaultCamZoom = 1.4;
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.4}, 0.4);

					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.tween(hud, {alpha: 0}, 0.4);

					add(textMaps["Can you hear me?"]);
					FlxTweenPlayState.tween(textMaps["Can you hear me?"], {alpha: 1}, 0.4);
				}
				if (step == 800)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					vignette.alpha = 0.55;

					PlayState.defaultCamZoom = 1;

					blackOverlay.alpha = 0;
					textMaps["Can you hear me?"].destroy();

					for (hud in PlayState.instance.allUIs)
						hud.alpha = 1;

					PlayState.dadOpponent.alpha = 1;
				}
				if (step == 922)
				{
					PlayState.defaultCamZoom = 1.3;
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.6}, 0.4);
				}
				if (step == 928)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					vignette.alpha = 0.4;

					PlayState.defaultCamZoom = 1;
					
					blackOverlay.alpha = 0;
				}
				if (step == 1040)
				{
					PlayState.defaultCamZoom = 2;

					FlxTweenPlayState.tween(blackOverlay, {alpha: 1}, 0.4);
				}
				if (step == 1056)
				{
					PlayState.defaultCamZoom = 1.4;

					PlayState.instance.stageBuild.foreground.members[1].visible = false;
					PlayState.instance.stageBuild.foreground.members[0].visible = false;

					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.4}, 0.2);
				}
				if (step == 1060)
				{
					PlayState.instance.stageBuild.foreground.members[0].visible = true;

					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					PlayState.defaultCamZoom = 1;

					statics.alpha = 0.6;

					blackOverlay.alpha = 0;
				}
				if (step == 1184)
				{
					PlayState.defaultCamZoom = 1.4;
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.4}, 0.2);

					add(textMaps["Hello."]);
					FlxTweenPlayState.tween(textMaps["Hello."], {alpha: 1}, 0.2);
				}
				if (step == 1188)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					PlayState.defaultCamZoom = 1;
					blackOverlay.alpha = 0;

					textMaps["Hello."].destroy();
				}
				if (step == 1080 || step == 1096 || step == 1112 || step == 1128 || step == 1144 || step == 1160 || step == 1176 || step == 1208
					|| step == 1224 || step == 1240 || step == 1256 || step == 1272 || step == 1288 || step == 1304 || step == 1896
					|| step == 1912 || step == 1928 || step == 1944 || step == 1960 || step == 1976 || step == 1992 || step == 2024
					|| step == 2040 || step == 2056
					|| step == 2072 || step == 2088 || step == 2104 || step == 2152 || step == 2168 || step == 2184 || step == 2200
					|| step == 2216 || step == 2232 || step == 2248 || step == 2280 || step == 2296 || step == 2312 || step == 2360 
					|| step == 2376)
				{
					PlayState.camGame.zoom += 0.085;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;

					ShaderObject.setValue("bloom.intensity.value", [0.7]);
					ShaderObject.setValue("chrom.amount.value", [0.01]);
				}
				if (step == 1312)
				{
					blackOverlay.alpha = 1;
					for (hud in PlayState.instance.allUIs)
						hud.visible = false;
				}

				if (step == 1344)
				{
					for (hud in PlayState.instance.allUIs)
						hud.visible = true;

					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					PlayState.defaultCamZoom = 0.6;

					PlayState.dadOpponent.alpha = 0;

					FlxTweenPlayState.tween(blackOverlay, {alpha: 0}, 15, {ease: FlxEase.sineOut});
					vignette.alpha = 1;

					FlxTweenPlayState.num(1.4, 0.6, 15, {ease: FlxEase.sineOut}, e ->
					{
						PlayState.defaultCamZoom = e;
						PlayState.camGame.zoom = e;
					});

					PlayState.instance.stageBuild.background.members[0].visible = true;
					PlayState.instance.stageBuild.foreground.members[2].visible = true;
					PlayState.instance.stageBuild.foreground.members[0].visible = false;

					statics.alpha = 1;
					statics.scale.set(0.8, 1);
					statics.y += -18;
				}
				if (step == 1488)
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.foreground.members[1], {alpha: 1}, 0.6, {ease: FlxEase.sineIn});
				if (step == 1500)
				{
					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 1}, 0.6, {ease: FlxEase.sineInOut});
					FlxTweenPlayState.tween(statics, {alpha: 0.6}, 0.6, {ease: FlxEase.sineInOut});
				}
				if (step == 1600)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 1856)
				{
					PlayState.defaultCamZoom = 1.4;

					FlxTweenPlayState.tween(blackOverlay, {alpha: 1}, 0.4, {ease: FlxEase.sineOut});

					add(textMaps["Can you keep a\nsecret of mine?"]);
					FlxTweenPlayState.tween(textMaps["Can you keep a\nsecret of mine?"], {alpha: 1}, 0.4);
				}
				if (step == 1872)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					textMaps["Can you keep a\nsecret of mine?"].destroy();

					PlayState.defaultCamZoom = 1;

					blackOverlay.alpha = 0;
					vignette.alpha = 0.4;

					PlayState.instance.stageBuild.background.members[0].visible = false;
					PlayState.instance.stageBuild.foreground.members[0].visible = true;
					PlayState.instance.stageBuild.foreground.members[2].visible = false;

					statics.scale.set(1, 1);
					statics.y += 18;
				}
				if (step == 2000)
					FlxTweenPlayState.tween(blackOverlay, {alpha: 1}, 0.2, {ease: FlxEase.sineOut});
				if (step == 2004)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					blackOverlay.alpha = 0;
				}
				if (step == 2112)
				{
					FlxTweenPlayState.color(statics, 0.3, FlxColor.WHITE, FlxColor.RED);
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.4}, 0.3, {ease: FlxEase.sineOut});
					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 0}, 0.3, {ease: FlxEase.sineOut});
				}
				if (step == 2120)
				{
					PlayState.defaultCamZoom = 1.4;
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0}, 0.3, {ease: FlxEase.sineOut});
					FlxTweenPlayState.tween(intruder, {alpha: 1}, 0.3, {ease: FlxEase.sineOut});

					PlayState.camGame.shake(0.01, 0.78);

					FlxTweenPlayState.num(0, 0.02, 0.78, {ease: FlxEase.sineInOut}, e ->
						ShaderObject.setValue("chrom.amount.value", [e])
					);
				}
				if (step == 2128)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					PlayState.defaultCamZoom = 1;
					blackOverlay.alpha = 0;
					intruder.visible = false;

					PlayState.dadOpponent.alpha = 1;
				}
				if (step == 2256)
					FlxTweenPlayState.tween(blackOverlay, {alpha: 1}, 0.2, {ease: FlxEase.sineOut});
				if (step == 2260)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					blackOverlay.alpha = 0;
				}
				if (step == 2320)
				{
					PlayState.camGame.angle = 10;
					FlxTweenPlayState.tween(PlayState.camGame, {angle: 7}, 0.2, {ease: FlxEase.sineOut});

					PlayState.camGame.zoom = 1.15;
					PlayState.defaultCamZoom = 1.1;
				}
				if (step == 2328)
				{
					PlayState.camGame.angle = -10;
					FlxTweenPlayState.tween(PlayState.camGame, {angle: -7}, 0.2, {ease: FlxEase.sineOut});

					PlayState.camGame.zoom = 1.3;
					PlayState.defaultCamZoom = 1.25;

					ShaderObject.setValue("bloom.intensity.value", [0.7]);
				}
				if (step == 2336)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					PlayState.defaultCamZoom = 1;
					PlayState.camGame.angle = 0;

					ShaderObject.setValue("bloom.intensity.value", [0.7]);
				}
				if (step == 2384)
				{
					for (hud in PlayState.instance.allUIs)
						hud.visible = false;
					blackOverlay.alpha = 1;
					PlayState.defaultCamZoom = 1.4;

					PlayState.dadOpponent.setCharacter(0, 0, "intruderlured_alt");
					PlayState.dadOpponent.scale.set(1, 1);
					PlayState.dadOpponent.updateHitbox();
					PlayState.dadOpponent.setPosition(370, -10);
					PlayState.dadOpponent.color = FlxColor.BLACK;
					remove(PlayState.dadOpponent);
					add(PlayState.dadOpponent, 3);

					vignette.alpha = 1;

					PlayState.instance.stageBuild.background.members[0].visible = true;
					PlayState.instance.stageBuild.foreground.members[2].visible = true;
					PlayState.instance.stageBuild.foreground.members[0].visible = false;

					statics.color = FlxColor.WHITE;
					statics.alpha = 1;
					statics.scale.set(0.8, 1);
					statics.y += -18;

					for (hud in PlayState.instance.allUIs)
						hud.visible = false;
				}
				if (step == 2400)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.6}, 1.4, {ease:FlxEase.sineOut});
					FlxTweenPlayState.num(1.4, 0.8, 1.4, {ease: FlxEase.sineOut}, e ->
					{
						PlayState.defaultCamZoom = e;
						PlayState.camGame.zoom = e;
					});

					PlayState.camGame.shake(0.005, 1.4);
				}
				if (step == 2416)
				{
					PlayState.boyfriend.visible = true;
					remove(PlayState.boyfriend);
					add(PlayState.boyfriend, 15);
					for (hud in PlayState.instance.allUIs)
						hud.visible = true;

					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					PlayState.defaultCamZoom = 0.6;

					blackOverlay.alpha = 0;
				}
				if (step == 2912)
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.7}, 3, {ease: FlxEase.sineOut});
				if (step == 2944)
				{
					PlayState.dadOpponent.color = FlxColor.WHITE;
					PlayState.boyfriend.visible = false;
					blackOverlay.alpha = 0;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					PlayState.defaultCamZoom = 1.4;

					staticBg.visible = true;

					PlayState.camGame.shake(0.01, 6);
				}
				if (step == 2981)
					blackOverlay.alpha = 1;
	
			case "Pursued":
				if (step == 1)
					FlxTweenPlayState.tween(clock, {alpha: 1}, 15);
				if (step == 64)
				{
					add(textMaps["TIME'S RUNNING OUT, LIEUTENANT!"]);
					FlxTweenPlayState.tween(clock, {y: -70}, 7);
					FlxTweenPlayState.tween(textMaps["TIME'S RUNNING OUT, LIEUTENANT!"], {alpha: 1}, 7);
					FlxTweenPlayState.shake(textMaps["TIME'S RUNNING OUT, LIEUTENANT!"], 0.003, 7);
				}
				if (step == 128)
				{
					PlayState.defaultCamZoom = 1;
					FlxTweenPlayState.cancelTweensOf(textMaps["TIME'S RUNNING OUT, LIEUTENANT!"]);
					textMaps["TIME'S RUNNING OUT, LIEUTENANT!"].destroy();
					clock.visible = false;
				}
				if (step == 184)
				{
					PlayState.boyfriend.playAnim("idle", true);
					PlayState.boyfriend.alpha = 1;
					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 0}, 0.3);
				}
				if (step == 188)
				{
					FlxTweenPlayState.cancelTweensOf(PlayState.boyfriend);
					PlayState.boyfriend.alpha = 1;
					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 0}, 0.3);
				}
				if (step == 192)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					FlxTweenPlayState.cancelTweensOf(PlayState.boyfriend);
					PlayState.boyfriend.alpha = 1;

					PlayState.dadOpponent.visible = true;

					for (hud in PlayState.instance.allUIs)
						hud.visible = true;

					PlayState.instance.stageBuild.background.members[0].visible = true;
				}
				if (step == 304)
				{
					PlayState.defaultCamZoom = 1.4;
					PlayState.boyfriend.characterData.camOffsetX = -130;
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.6}, 0.4);

					add(textMaps["WORTHLESS."]);
					FlxTweenPlayState.tween(textMaps["WORTHLESS."], {alpha: 0.7}, 2.3);
					FlxTweenPlayState.shake(textMaps["WORTHLESS."], 0.0085, 7);
				}
				if (step == 320)
				{
					FlxTweenPlayState.cancelTweensOf(textMaps["WORTHLESS."]);
					textMaps["WORTHLESS."].destroy();

					PlayState.camGame.flash(FlxColor.WHITE, 1.2);

					PlayState.defaultCamZoom = 1;
					PlayState.boyfriend.characterData.camOffsetX = -180;
					PlayState.instance.stageBuild.background.members[0].alpha = 1;

					pursuedBars.visible = true;
				}
				if (step == 448)
				{
					PlayState.defaultCamZoom = 1.4;
					PlayState.boyfriend.characterData.camOffsetX = -130;
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.6}, 0.4);
				}
				if (step == 456)
				{
					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 0}, 0.35);
					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 0}, 0.35);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0}, 0.35);
					FlxTweenPlayState.tween(pursuedBars, {alpha: 0}, 0.35);
				}
				if (step == 464)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					PlayState.defaultCamZoom = 1;
					PlayState.boyfriend.characterData.camOffsetX = -180;

					FlxTweenPlayState.cancelTweensOf(PlayState.boyfriend);
					FlxTweenPlayState.cancelTweensOf(PlayState.dadOpponent);
					FlxTweenPlayState.cancelTweensOf(PlayState.instance.stageBuild.background.members[0]);
					FlxTweenPlayState.cancelTweensOf(pursuedBars);

					PlayState.boyfriend.alpha = 1;
					PlayState.dadOpponent.alpha = 1;
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.instance.stageBuild.foreground.members[0].visible = true;
					pursuedBars.alpha = 1;

					fog.visible = true;
				}
				if (step == 720)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 968)
				{
					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 0}, 0.35);
					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 0}, 0.35);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0}, 0.35);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.foreground.members[0], {alpha: 0}, 0.35);
					FlxTweenPlayState.tween(pursuedBars, {alpha: 0}, 0.35);
					FlxTweenPlayState.tween(fog, {alpha: 0}, 0.35);
				}
				if (step == 976)
				{
					add(textMaps["PUT YOUR SERVICE WEAPON"]);
					add(textMaps["IN YOUR MOUTH."]);
					textMaps["IN YOUR MOUTH."].visible = false;

					FlxTweenPlayState.shake(textMaps["PUT YOUR SERVICE WEAPON"], 0.002, 50);
					FlxTweenPlayState.shake(textMaps["IN YOUR MOUTH."], 0.002, 50);

					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					FlxTweenPlayState.cancelTweensOf(PlayState.boyfriend);
					FlxTweenPlayState.cancelTweensOf(PlayState.dadOpponent);
					FlxTweenPlayState.cancelTweensOf(PlayState.instance.stageBuild.background.members[0]);
					FlxTweenPlayState.cancelTweensOf(PlayState.instance.stageBuild.foreground.members[0]);
					FlxTweenPlayState.cancelTweensOf(pursuedBars);
					FlxTweenPlayState.cancelTweensOf(fog);

					PlayState.instance.camFollow.setPosition(850, 350);
					PlayState.lockCamPos = true;

					PlayState.focus = BF;
					PlayState.lockFocus = true;

					PlayState.defaultCamZoom = 1.2;

					PlayState.boyfriend.alpha = 1;
					PlayState.dadOpponent.alpha = 1;
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.instance.stageBuild.foreground.members[0].alpha = 0.3;
					pursuedBars.visible = false;
					pursuedBars.alpha = 1;
					fog.alpha = 0.45;
				}
				if (step == 1000 || step == 1032 || step == 1064 || step == 1096 || step == 1128 || step == 1160 || step == 1192 || step == 1224)
				{
					textMaps["PUT YOUR SERVICE WEAPON"].visible = false;
					textMaps["IN YOUR MOUTH."].visible = true;
				}
				if (step == 1104)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 1008 || step == 1040 || step == 1072 || step == 1104 || step == 1136 || step == 1168 || step == 1200)
				{
					textMaps["PUT YOUR SERVICE WEAPON"].visible = true;
					textMaps["IN YOUR MOUTH."].visible = false;
				}
				if (step == 1232)
				{
					PlayState.camGame.angle = 0;
					FlxTweenPlayState.cancelTweensOf(textMaps["PUT YOUR SERVICE WEAPON"]);
					FlxTweenPlayState.cancelTweensOf(textMaps["IN YOUR MOUTH."]);

					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					PlayState.lockCamPos = false;
					PlayState.lockFocus = false;

					textMaps["PUT YOUR SERVICE WEAPON"].visible = false;
					textMaps["IN YOUR MOUTH."].visible = false;

					PlayState.defaultCamZoom = 1;

					pursuedBars.visible = true;
				}
				if (step == 1360)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 1488)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					PlayState.defaultCamZoom = 1.3;
					PlayState.boyfriend.characterData.camOffsetX = -130;
					PlayState.dadOpponent.characterData.camOffsetX = 150;
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.6}, 0.4);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.foreground.members[0], {alpha: 0.6}, 0.4);
				}
				if (step == 1616)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					PlayState.defaultCamZoom = 1;
					PlayState.boyfriend.characterData.camOffsetX = -180;
					PlayState.dadOpponent.characterData.camOffsetX = 100;
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.instance.stageBuild.foreground.members[0].alpha = 0.3;
				}
				if (step == 1872)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;

					PlayState.defaultCamZoom = 0.55;
					PlayState.forceZoom[0] = 0;

					PlayState.instance.stageBuild.background.members[0].visible = false;
					PlayState.instance.stageBuild.foreground.members[0].visible = false;

					PlayState.instance.stageBuild.background.members[1].visible = true;
					PlayState.instance.stageBuild.foreground.members[1].visible = true;
					pursuedBars.visible = false;
					fog.visible = false;

					PlayState.instance.camFollow.setPosition(800, 570);
					PlayState.lockCamPos = true;
					
					PlayState.boyfriend.setCharacter(10, 680, "thatcherCall");
					PlayState.dadOpponent.setCharacter(10, 1300, "ruth");
				}
				if (step == 1872)
					callText.text = "(T): aaaaaaiiiiiiiiiii";
				if (step == 1890)
					callText.text = "(T): e e e e e eeeeeeeeeee";
				if (step == 1904)
					callText.text = "(T): ehhhhh";
				if (step == 1908)
					callText.text = "(T): ehhhhh\n\n(R): uhhhh iii uhh";
				if (step == 1916)
					callText.text = "(T): ehhhhh ehhhhhh\n\n(R): uhhhh iii uhh";
				if (step == 1920)
					callText.text = "(T): ehhhhh\n\n(R): iiiiiii";
				if (step == 1928)
					callText.text = "(T): ehhhhh oiiiiiii\n\n(R): iiiiiii";
				if (step == 1936)
					callText.text = "(T): ehhhhhhhhhhh\n\n(R): iiiiiiiiiiiiiiii";
				if (step == 1954)
					callText.text = "(R): uhhh i uh uh ii iiiiii";
				if (step == 1968)
					callText.text = "(R): iiii";
				if (step == 1980)
					callText.text = "(R): iiii uhhhhh";
				if (step == 1984)
					callText.text = "(R): iiiiiiii";
				if (step == 1992)
					callText.text = "(R): iiiiiiii";
				if (step == 2000)
				{
					callText.text = "(R): uhhhhhhhhhhhhh";
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 2004)
					callText.text = "(T): iiiiiii i i i\n\n(R): uhhhhhhhhhhhhh";
				if (step == 2018)
					callText.text = "(T): o aiii ehhh ehhhh";
				if (step == 2036)
					callText.text = "(T): ehhh ehhhh eh eh";
				if (step == 2048)
					callText.text = "(T): oo e o o ehh ehh ehhhh";
				if (step == 2064)
					callText.text = "(T): ehhhhhhhhhh";
				if (step == 2068)
					callText.text = "(T): ehhhhhhhhhh\n\n(R): iii iii uh uh";
				if (step == 2082)
					callText.text = "(R): ahh iii iii uhhhh";
				if (step == 2100)
					callText.text = "(R): uhh i ii ii";
				if (step == 2112)
					callText.text = "(R): ii ii i i i uhhh iiiiii";
				if (step == 2128)
				{
					callText.text = "(R): uh i i u iiiiiiii i ah uh i i i uh o o i ah";
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 2160)
					callText.text = "(T): eh eh eh ehhhhhhh eh of eh eh eh\neh eh o o i oh";
				if (step == 2192)
					callText.text = "(T): ehhhhhhh\n\n(R): o o i o i o i i";
				if (step == 2208)
					callText.text = "(R): uh uh i ah i a o i";
				if (step == 2224)
					callText.text = "(T): eh eh i eh i eh i eh\n\n(R): oooooooooo";
				if (step == 2240)
					callText.text = "(T): eh eh i oh eye oh i eh";
				if (step == 2256)
				{
					callText.text = "(T): ehhhhhhhhhhhhhhhhh\n\n(R): i uh i i ahuiehuiuhhh";
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 2274)
					callText.text = "(R): uh i ah i uh i oh i";
				if (step == 2288)
					callText.text = "(T): uh eh eh eh uh ehoh\n\n(R): iuuu iiiiiiiiiii";
				if (step == 2306)
					callText.text = "(T): uh i oh oh oh i";
				if (step == 2320)
					callText.text = "(T): iuuu iiiiiiiii\n\n(R): uh i ah i i i oh";
				if (step == 2338)
					callText.text = "(R): uh i  uh uhuhuhiiiuhhiiuhiiii";
				if (step == 2352)
					callText.text = "(T): eh eh oh eh eh eh eh\n\n(R): uhhhhhhhhhhhh";
				if (step == 2370)
					callText.text = "(T): eh ehhoehohoehehohehhoOOO";
				if (step == 2384)
				{
					callText.text = "(T): ehhhhhhhhhhh\n\n(R): ohhhh ewhwhhhhh";
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 2400)
					callText.text = "(R): i i ehhhh i ehhh ohhhhh";
				if (step == 2416)
					callText.text = "(R): ohhh ohhhh oh";
				if (step == 2432)
					callText.text = "(R): i ehh ohh oh i ehhh ohh";
				if (step == 2464)
					callText.text = "(T): euuuu oiiiii iii ooo iiiii";
				if (step == 2480)
					callText.text = "(T): iiii iiiiiii";
				if (step == 2488)
					callText.text = "(T): euuhhhh oiiiii\n\n(R): ohhhh arghhhh";
				if (step == 2496)
					callText.text = "(T): i i ohhh i o aaaaaa";
				if (step == 2512)
				{
					callText.text = "(T): ohhh a oiiiii\n\n(R): ohhh a eeee ahh ohh ahhhh";
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 2528)
					callText.text = "(T): ohhhh oh i oh\n\n(R): eheh ahh ohhh ohhh ohj i oh";
				if (step == 2544)
					callText.text = "(T): ohhhh\n\n(R): ah i ah i ah oh ahhh";
				if (step == 2560)
					callText.text = "(T): ehhhhhhh\n\n(R): ii a oh i oh i oooo";
				if (step == 2576)
					callText.text = "(T): ehh u u ooooooo u eh u\n\n(R): aaaaaaaaaaaa";
				if (step == 2592)
					callText.text = "(T): o i i i ahh i eh ohhh\noh i oh ee i ohhh\n\n(R): iiiii ahh i u ahhhhhhhhhhhhhhhh";
				if (step == 2624)
					callText.text = "(T): oh ii oh a e i eeeeee\n\n(R): uuuuuuuuuuuuuuuuu";
				if (step == 2635)
				{
					FlxTweenPlayState.color(PlayState.dadOpponent, 0.3, 0xffffffff, 0xff000000);
					callText.text = "(T): oh ii oh a e i eeeeee\n\n(?): eee ahhh";
				}
				if (step == 2640)
				{
					callText.visible = false;
					FlxTweenPlayState.cancelTweensOf(PlayState.dadOpponent);
					PlayState.dadOpponent.color = 0xffffffff;

					FlxTweenPlayState.shake(textMaps["PUT YOUR SERVICE WEAPON"], 0.002, 50);
					FlxTweenPlayState.shake(textMaps["IN YOUR MOUTH."], 0.002, 50);

					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
					
					PlayState.lockCamPos = false;
					PlayState.instance.camFollow.setPosition(850, 350);
					PlayState.lockCamPos = true;

					textMaps["PUT YOUR SERVICE WEAPON"].visible = true;
					textMaps["IN YOUR MOUTH."].visible = false;

					PlayState.focus = BF;
					PlayState.lockFocus = true;

					PlayState.defaultCamZoom = 1.2;

					PlayState.instance.stageBuild.background.members[0].visible = true;
					PlayState.instance.stageBuild.foreground.members[0].visible = true;
					PlayState.instance.stageBuild.background.members[1].visible = false;
					PlayState.instance.stageBuild.foreground.members[1].visible = false;
					fog.visible = true;

					PlayState.boyfriend.setCharacter(10, 670, "thatcher");
					PlayState.dadOpponent.setCharacter(10, 1305, "pursuedAlt");

					PlayState.boyfriend.setPosition(32, 20);
					PlayState.dadOpponent.setPosition(695, 30);
				}
				if (step == 2664 || step == 2696 || step == 2728 || step == 2760 || step == 2792 || step == 2824 || step == 2856 || step == 2888)
				{
					textMaps["PUT YOUR SERVICE WEAPON"].visible = false;
					textMaps["IN YOUR MOUTH."].visible = true;
				}
				if (step == 2764)
				{
					PlayState.instance.stageBuild.background.members[0].visible = false;
					PlayState.instance.stageBuild.foreground.members[0].visible = false;
					textMaps["PUT YOUR SERVICE WEAPON"].visible = false;
					textMaps["IN YOUR MOUTH."].visible = false;

					PlayState.boyfriend.visible = false;
					PlayState.dadOpponent.visible = false;
					fog.visible = false;
				}
				if (step == 2768)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
					
					PlayState.instance.stageBuild.background.members[0].visible = true;
					PlayState.instance.stageBuild.foreground.members[0].visible = true;

					PlayState.boyfriend.visible = true;
					PlayState.dadOpponent.visible = true;
					fog.visible = true;
				}
				if (step == 2672 || step == 2704 || step == 2736 || step == 2768 || step == 2800 || step == 2832 || step == 2864)
				{
					textMaps["PUT YOUR SERVICE WEAPON"].visible = true;
					textMaps["IN YOUR MOUTH."].visible = false;
				}
				if (step == 2872)
				{
					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 0}, 0.35);
					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 0}, 0.35);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0}, 0.35);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.foreground.members[0], {alpha: 0}, 0.35);
					FlxTweenPlayState.tween(fog, {alpha: 0}, 0.35);
				}
				if (step == 2880)
					add(textMaps["STOP\nOR I'LL\nSHOOT!"]);
				if (step == 2896)
				{
					FlxTweenPlayState.cancelTweensOf(textMaps["PUT YOUR SERVICE WEAPON"]);
					FlxTweenPlayState.cancelTweensOf(textMaps["IN YOUR MOUTH."]);
					
					textMaps["IN YOUR MOUTH."].destroy();
					textMaps["STOP\nOR I'LL\nSHOOT!"].destroy();

					PlayState.camGame.angle = 0;
					red.visible = true;
					FlxG.cameras.shake();
				}
			case "Remembered":
				if (step == 1)
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.4}, 5);
				if (step == 48)
				{
					FlxTweenPlayState.tween(textMaps["Do you remember"], {alpha: 0.7}, 8);
					FlxTweenPlayState.tween(textMaps["ME?"], {alpha: 0.7}, 8);
				}
				if (step == 128)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					blackOverlay.alpha = 0;
					FlxTweenPlayState.cancelTweensOf(textMaps["Do you remember"]);
					FlxTweenPlayState.cancelTweensOf(textMaps["ME?"]);

					PlayState.camGame.zoom += 0.2;

					textMaps["Do you remember"].destroy();
					textMaps["ME?"].destroy();

					PlayState.defaultCamZoom = 0.6;
				}
				if (step == 139)
					add(textMaps["The flicker of\nthe TV\nilluminated\nthis bedroom..."]);
				if (step == 160)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;
				}
				if (step == 174)
				{
					textMaps["The flicker of\nthe TV\nilluminated\nthis bedroom..."].destroy();
					add(textMaps["Drowning out the\ndarkness with\nhis favourite\nprograms."]);
				}
				if (step == 192)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;
				}
				if (step == 215)
				{
					textMaps["Drowning out the\ndarkness with\nhis favourite\nprograms."].destroy();
					add(textMaps["Do you remember\nhow we became"]);
					add(textMaps["FRIENDS?"]);
				}
				if (step == 224)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;
				}
				if (step == 240)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 1}, 1);
					FlxTweenPlayState.tween(textMaps["Do you remember\nhow we became"], {alpha: 0}, 1);
					FlxTweenPlayState.tween(textMaps["FRIENDS?"], {alpha: 0}, 1);
					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.tween(hud, {alpha: 1}, 1);
				}
				if (step == 256)
				{
					textMaps["Do you remember\nhow we became"].destroy();
					textMaps["FRIENDS?"].destroy();
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;

					FlxTweenPlayState.cancelTweensOf(blackOverlay);
					blackOverlay.alpha = 0;
					
					PlayState.dadOpponent.visible = true;

					rememberedBars.visible = true;
				}
				if (step == 384 || step == 512 || step == 640 || step == 896 || step == 1024 || step == 1152 || step == 1920 || step == 2052 || step == 2176)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.5;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.2;
				}
				if (step == 752)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.5}, 0.4);
					PlayState.defaultCamZoom = 0.9;
				}
				if (step == 768)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;

					blackOverlay.alpha = 0;
					PlayState.defaultCamZoom = 0.6;

					rememberedVisualizer.active = true;
					rememberedVisualizer.visible = true;

					rememberedVisualizer2.active = true;
					rememberedVisualizer2.visible = true;
				}
				if (step == 1272)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.4}, 0.4);
					PlayState.defaultCamZoom = 0.9;
				}
				if (step == 1280)
				{
					PlayState.dadOpponent.setCharacter(0, 0, "altIntruderRemembered");
					PlayState.dadOpponent.setPosition(770, 135);
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;

					blackOverlay.alpha = 0;

					PlayState.defaultCamZoom = 0.7;

					rememberedVisualizer.active = false;
					rememberedVisualizer.visible = false;

					rememberedVisualizer2.active = false;
					rememberedVisualizer2.visible = false;
				}
				if (step == 1408)
				{
					PlayState.camGame.zoom += 0.2;

					PlayState.defaultCamZoom = 0.6;
				}
				if (step == 1536)
				{
					PlayState.camGame.zoom += 0.2;

					PlayState.defaultCamZoom = 0.7;

					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.3}, 0.4);
				}
				if (step == 1600)
				{
					PlayState.camGame.zoom += 0.2;

					PlayState.defaultCamZoom = 0.6;

					FlxTweenPlayState.tween(blackOverlay, {alpha: 0}, 0.4);
				}
				if (step == 1664)
				{
					PlayState.defaultCamZoom = 0.8;

					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.4}, 0.4);
				}
				if (step == 1792)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;

					PlayState.defaultCamZoom = 0.6;
					blackOverlay.alpha = 0;

					rememberedVisualizer.active = true;
					rememberedVisualizer.visible = true;

					rememberedVisualizer2.active = true;
					rememberedVisualizer2.visible = true;
				}
				if (step == 2288)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.4}, 0.4);
					PlayState.defaultCamZoom = 0.9;
				}
				if (step == 2304)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					blackOverlay.alpha = 1;
					PlayState.defaultCamZoom = 0.7;

					rememberedBars.visible = false;

					rememberedVisualizer.active = false;
					rememberedVisualizer.visible = false;

					rememberedVisualizer2.active = false;
					rememberedVisualizer2.visible = false;

					for (hud in PlayState.instance.allUIs)
						hud.alpha = 0;

					PlayState.dadOpponent.setCharacter(886, -65, "intruderSketch");
					PlayState.dadOpponent.visible = false;
					PlayState.instance.stageBuild.background.members[0].visible = false;

					PlayState.boyfriend.setCharacter(886, 265, "adam");
					PlayState.boyfriend.visible = true;
				}
				if (step == 2304)
					add(textMaps["Do you remember\nmy face?"]);
				if (step == 2323)
				{
					textMaps["Do you remember\nmy face?"].destroy();
					add(textMaps["With contorted flesh\nand broken bones..."]);
				}
				if (step == 2350)
				{
					textMaps["With contorted flesh\nand broken bones..."].destroy();
					add(textMaps["I MADE MYSELF KNOWN."]);
				}
				if (step == 2376)
				{
					textMaps["I MADE MYSELF KNOWN."].destroy();
					add(textMaps["Do you remember\nmy touch?"]);
				}
				if (step == 2404)
				{
					textMaps["Do you remember\nmy touch?"].destroy();
					add(textMaps["I cradled him\nin my arms..."]);
				}
				if (step == 2423)
				{
					textMaps["I cradled him\nin my arms..."].destroy();
					add(textMaps["MY SWEET BOY."]);

					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.6}, 0.5);
				}
				if (step == 2416)
				{
					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.tween(hud, {alpha: 1}, 1);
				}
				if (step == 2432)
				{
					textMaps["MY SWEET BOY."].destroy();
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					blackOverlay.alpha = 0.3;
				}
				if (step == 2440)
				{
					add(textMaps["I took him away."]);
				}
				if (step == 2460)
				{
					textMaps["I took him away."].destroy();
					add(textMaps["Do you remember\nthat night, Murray?"]);
				}
				if (step == 2488)
				{
					textMaps["Do you remember\nthat night, Murray?"].destroy();
					add(textMaps["When you stare\ninto the mirror..."]);
				}
				if (step == 2509)
				{
					textMaps["When you stare\ninto the mirror..."].destroy();
					add(textMaps["You see the\nsame monsters from\nyour bedroom..."]);
				}
				if (step == 2530)
				{
					textMaps["You see the\nsame monsters from\nyour bedroom..."].destroy();
					add(textMaps["Don't you?"]);
				}
				if (step == 2546)
				{
					textMaps["Don't you?"].destroy();
					add(textMaps["BUT YOUR SKIN\nIS NOT YOUR OWN."]);
				}
				if (step == 2560)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.6}, 0.2);
					PlayState.defaultCamZoom = 0.9;
				}
				if (step == 2564)
				{
					textMaps["BUT YOUR SKIN\nIS NOT YOUR OWN."].destroy();

					ShaderObject.setValue("bloom.intensity.value", [0.2]);

					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.defaultCamZoom = 0.7;

					flashbacks.visible = true;

					blackOverlay.alpha = 0.3;
				}
				if (step == 2816)
				{
					flashbacks.visible = false;
					blackOverlay.alpha = 1;
					for (hud in PlayState.instance.allUIs)
						hud.alpha = 0;
				}
				if (step == 2864)
				{
					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.tween(hud, {alpha: 1}, 1);
				}
				if (step == 2880)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.3}, 7);

					ShaderObject.setValue("bloom.intensity.value", [0]);

					PlayState.boyfriend.setCharacter(886, 265, "scaredAdam");
				}
				if (step == 3000)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.6}, 0.2);
					PlayState.defaultCamZoom = 0.9;
				}
				if (step == 3008)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.defaultCamZoom = 0.7;

					blackOverlay.alpha = 0.3;
				}
				if (step == 3015)
					FlxTweenPlayState.tween(adamAndJonah, {alpha: 0.1}, 3);
				if (step == 3104)
					FlxTweenPlayState.tween(adamAndJonah, {alpha: 0}, 3);
				if (step == 3136)
					FlxTweenPlayState.tween(sarahAndAdam, {alpha: 0.1}, 3);
				if (step == 3232)
					FlxTweenPlayState.tween(sarahAndAdam, {alpha: 0}, 3);
				if (step == 3264)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.boyfriend.setCharacter(886, 265, "alternateAdam");
					blackOverlay.alpha = 1;
					for (hud in PlayState.instance.allUIs)
						hud.alpha = 0;
				}
				if (step == 3312)
				{
					add(textMaps["YOU'RE NOT\nTHE REAL YOU."]);
					FlxTweenPlayState.tween(scare, {alpha: 0.2}, 0.3);
					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.tween(hud, {alpha: 1}, 1);
				}
				if (step == 3328)
				{
					textMaps["YOU'RE NOT\nTHE REAL YOU."].destroy();
					scare.visible = false;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					blackOverlay.alpha = 0;
					PlayState.defaultCamZoom = 0.5;
					PlayState.dadOpponent.visible = true;
					rememberedBars.visible = true;
				}
				if (step == 3584)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.6}, 0.1);
					PlayState.defaultCamZoom = 0.8;
				}
				if (step == 3588)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					eyes.visible = true;
					ShaderObject.setValue("bloom.intensity.value", [0.25]);
					blackOverlay.alpha = 0;
					PlayState.defaultCamZoom = 0.5;
				}
				if (step == 3872)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.6}, 0.2);
					PlayState.defaultCamZoom = 0.65;
				}
				if (step == 3904)
				{
					ShaderObject.setValue("bloom.intensity.value", [0]);

					PlayState.defaultCamZoom = 0.7;

					FlxTweenPlayState.tween(die, {alpha: 0.2}, 2);

					for (hud in PlayState.instance.allUIs)
						hud.visible = false;

					PlayState.dadOpponent.visible = false;

					blackOverlay.alpha = 0;

					rememberedBars.visible = false;

					rememberedVisualizer.active = false;
					rememberedVisualizer.visible = false;

					rememberedVisualizer2.active = false;
					rememberedVisualizer2.visible = false;
					PlayState.boyfriend.visible = false;
					eyes.visible = false;

					ShaderObject.setValue("bloom.intensity.value", [0]);
				}
				if (step == 3939)
				{
					die.alpha = 0.5;
					ShaderObject.setValue("bloom.intensity.value", [0.1]);
				}
			case "Deceived":
				if (step == 1)
					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 1}, 7);
				if (step == 128)
					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 1}, 7);
				if (step == 256)
				{
					PlayState.defaultCamZoom = 0.27;
					PlayState.camGame.flash(FlxColor.WHITE, 1.6);
					square.visible = true;

					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.1;

					ShaderObject.setValue("bloom.intensity.value", [0.40]);
				}
				if (step == 320)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.6);

					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.1;
				}
				if (step == 384)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.6);

					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.1;
				}
				if (step == 448)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.6);

					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.1;
				}
				if (step == 512)
				{
					FlxTweenPlayState.num(0.45, 0, 1.2, null, function(e:Float)
					{
						ShaderObject.setValue("bloom.intensity.value", [e]);
					});

					FlxTweenPlayState.tween(blackOverlay, {alpha: 1}, 1.2, {onComplete: function(e:FlxTween)
					{
						square.active = false;
						square.visible = false;
						PlayState.dadOpponent.setColorTransform();
						PlayState.boyfriend.setColorTransform();
						PlayState.defaultCamZoom = 0.4;
						PlayState.forceZoom[0] = 1;
						PlayState.lockCamPos = false;
						PlayState.focus = NONE;
						PlayState.instance.camFollow.setPosition(PlayState.dadOpponent.getGraphicMidpoint().x + 50,
							PlayState.dadOpponent.getGraphicMidpoint().y - 490);
						PlayState.lockCamPos = true;
						PlayState.boyfriend.scale.set(2, 2);
						PlayState.boyfriend.updateHitbox();
						PlayState.boyfriend.setPosition(1600, 2000);
					}});
					
				}
				if (step == 544)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.4;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					PlayState.camGame.zoom += 0.2;

					FlxTween.num(1, 0.2, 2, null, function(e:Float)
					{
						PlayState.forceZoom[0] = e;
					});
					FlxTween.tween(blackOverlay, {alpha: 0.3}, 3);

					for (hud in PlayState.instance.allUIs)
						FlxTween.tween(hud, {alpha: 1}, 3);
				}
				if (step == 576 || step == 596 || step == 600 || step == 604 || step == 640 || step == 646 || step == 652 || step == 654 || step == 656
					|| step == 672 || step == 704 || step == 724 || step == 728 || step == 732 || step == 768 || step == 774 || step == 780 || step == 782
					|| step == 784)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.4;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					PlayState.camGame.zoom += 0.2;
				}
				if (step == 608 || step == 736)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;
				}
				if (step == 672)
				{
					FlxTweenPlayState.tween(PlayState.dadOpponent, {x: PlayState.dadOpponent.x - 550}, 0.6, {ease: FlxEase.sineOut});
					FlxTweenPlayState.tween(PlayState.boyfriend, {y: 700}, 0.6, {ease: FlxEase.sineOut});
				}
				if (step == 790)
				{
					FlxTweenPlayState.tween(PlayState.camGame, {angle: 360}, 1, {
						ease: FlxEase.sineInOut,
						onComplete: function(e:FlxTween)
						{
							PlayState.camGame.angle = 0;
						}
					});
					FlxTweenPlayState.num(0.4, 4, 0.6, null, function(e:Float)
					{
						PlayState.forceZoom[0] = e;
					});
				}
				if (step == 800)
				{
					Init.trueSettings['No Camera Note Movement'] = false;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);

					PlayState.boyfriend.scale.set(1.45, 1.45);
					PlayState.boyfriend.updateHitbox();
					PlayState.boyfriend.setPosition(1150, 2000);
					blackOverlay.alpha = 0;

					PlayState.forceZoom[0] = 0;

					PlayState.instance.stageBuild.foreground.members[0].visible = true;
					PlayState.instance.stageBuild.background.members[0].visible = true;
					PlayState.instance.stageBuild.background.members[1].visible = true;

					PlayState.lockCamPos = false;
					PlayState.lockFocus = false;

					PlayState.boyfriend.setPosition(2900, 1170);
					PlayState.dadOpponent.setPosition(1000, 600);
				}
				if (step == 1040)
				{
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.5}, 0.4, {ease: FlxEase.sineOut});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[1], {alpha: 0.5}, 0.4, {ease: FlxEase.sineOut});
					PlayState.focus = DAD;
					PlayState.lockFocus = true;
					PlayState.defaultCamZoom = 0.7;
					PlayState.dadOpponent.characterData.camOffsetX -= 100;
				}
				if (step == 1056)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.instance.stageBuild.background.members[1].alpha = 1;
					PlayState.dadOpponent.setCharacter(1000, 600, "altGabriel");
					PlayState.dadOpponent.setPosition(1000, 500);
					PlayState.boyfriend.setCharacter(2900, 1170, "noahScared");
					PlayState.boyfriend.setPosition(2900, 1170);

					PlayState.lockFocus = false;
					PlayState.defaultCamZoom = 0.4;

					redVignette.visible = true;

					ShaderObject.setValue("bloom.intensity.value", [0.25]);
					ShaderObject.setValue("chrom.tween", true);
				}
				if (step == 1568)
					FlxTweenPlayState.tween(blackOverlay, {alpha: 1});
				if (step == 1584)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					blackOverlay.alpha = 0;
					ShaderObject.setValue("bloom.intensity.value", [0]);
					ShaderObject.setValue("chrom.amount.value", [0]);
					redVignette.visible = false;
				}
				if (step == 2080)
				{
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.5}, 0.4, {ease: FlxEase.sineOut});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[1], {alpha: 0.5}, 0.4, {ease: FlxEase.sineOut});

					PlayState.defaultCamZoom = 0.6;

					PlayState.boyfriend.characterData.camOffsetX -= 50;
				}
				if (step == 2096)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					ShaderObject.setValue("bloom.intensity.value", [0.25]);

					square.active = true;
					square.visible = true;

					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.instance.stageBuild.background.members[1].alpha = 1;

					PlayState.defaultCamZoom = 0.4;

					PlayState.boyfriend.characterData.camOffsetX += 50;
				}
				if (step == 2608)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					ShaderObject.setValue("bloom.intensity.value", [0]);
					ShaderObject.setValue("chrom.amount.value", [0]);
					ShaderObject.setValue("chrom.tween", false);

					PlayState.instance.stageBuild.background.members[0].visible = false;
					PlayState.instance.stageBuild.background.members[1].visible = false;

					square.active = false;
					square.visible = false;

					PlayState.camGame.zoom += 0.2;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.05;

					PlayState.dadOpponent.setCharacter(1005, 600, "gab_front");
					PlayState.dadOpponent.setPosition(1005, 600);

					PlayState.focus = DAD;
					PlayState.lockFocus = true;
					PlayState.forceZoom[0] = 0;

					PlayState.defaultCamZoom = 0.5;
				}
				if (step == 2660 || step == 2664 || step == 2668 || step == 2704 || step == 2710 || step == 2716 || step == 2718 || step == 2720
					|| step == 2768 || step == 2788 || step == 2792 || step == 2704 || step == 2796 || step == 2832 || step == 2838 || step == 2844
					|| step == 2846 || step == 2848)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.3;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					PlayState.camGame.zoom += 0.07;
				}
				if (step == 2672 || step == 2736 || step == 2800)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);

					PlayState.camGame.zoom += 0.1;
				}
				if (step == 2864)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.05;

					square.active = true;
					square.visible = true;

					ShaderObject.setValue("bloom.intensity.value", [0.35]);

					PlayState.dadOpponent.setCharacter(1002, 600, "satan_front");
					PlayState.dadOpponent.setPosition(1002, 600);
				}
				if (step == 3376)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.05;
					square.active = false;
					square.visible = false;

					suchweakminds.visible = true;
					suchweakminds.active = true;

					ShaderObject.setValue("bloom.intensity.value", [0.70]);
					ShaderObject.setValue("chrom.amount.value", [0.0040]);
				}
				if (step == 3888)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.05;

					suchweakminds.visible = false;
					suchweakminds.active = false;

					PlayState.instance.stageBuild.background.members[0].visible = true;
					PlayState.instance.stageBuild.background.members[1].visible = true;

					ShaderObject.setValue("bloom.intensity.value", [0]);
					ShaderObject.setValue("chrom.amount.value", [0]);

					PlayState.boyfriend.visible = true;
					PlayState.lockFocus = false;

					PlayState.dadOpponent.setCharacter(1000, 600, "altGabriel");
					PlayState.dadOpponent.setPosition(1000, 600);
					PlayState.defaultCamZoom = 0.4;
				}
				if (step == 4144)
					blackOverlay.alpha = 1;
			
			case "Lured":
				if (step == 1)
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.foreground.members[1], {alpha: 0.5}, 6);
				if (step == 120)
					PlayState.camGame.visible = false;
				if (step == 128 || step == 144 || step == 160 || step == 176 || step == 192 || step == 208 || step == 224)
				{
					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.02;

					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.4;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (step == 128)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.visible = true;
					PlayState.instance.stageBuild.foreground.members[1].alpha = 0.4;
				}
				if (step == 240)
				{
					PlayState.defaultCamZoom = 0.92;
					FlxTweenPlayState.color(PlayState.dadOpponent, 0.2, FlxColor.WHITE, FlxColor.BLACK);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[1], {alpha: 1}, 0.5);
					PlayState.camGame.shake(0.0031, 1);
				}
				if (step == 256)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.5);
					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.02;
					PlayState.dadOpponent.color = FlxColor.WHITE;
					PlayState.instance.stageBuild.foreground.members[1].alpha = 0.2;
					PlayState.instance.stageBuild.background.members[1].alpha = 0;
				}
				if (step == 512)
				{
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.4}, 0.2);
					PlayState.forceZoom[0] = 0.1;
				}
				if (step == 528)
				{
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.02;
					PlayState.forceZoom[0] = 0;
				}
				if (step == 752)
				{
					PlayState.focus = DAD;
					PlayState.lockFocus = true;
					PlayState.forceZoom[0] = 0.1;
					FlxTweenPlayState.color(PlayState.dadOpponent, 0.2, FlxColor.WHITE, FlxColor.BLACK);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[1], {alpha: 1}, 0.5);
					PlayState.camGame.shake(0.0031, 1);
				}
				if (step == 768)
				{
					PlayState.lockFocus = false;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.02;
					PlayState.forceZoom[0] = 0;
					PlayState.dadOpponent.color = FlxColor.WHITE;
					PlayState.instance.stageBuild.background.members[1].alpha = 0;
				}
				if (step == 1024)
				{
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.6}, 0.2);
					PlayState.forceZoom[0] = 0.05;
				}
				if (step == 1142)
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.foreground.members[1], {alpha: 1}, 0.4);
				if (step == 1152 || step == 1158 || step == 1164 || step == 1168 || step == 1174 || step == 1180 || step == 1184 || step == 1190
					|| step == 1196 || step == 1200 || step == 1206 || step == 1212 || step == 1216 || step == 1222 || step == 1228 || step == 1232
					|| step == 1238 || step == 1244 || step == 1248 || step == 1254 || step == 1260)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.4;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					FlxTweenPlayState.cancelTweensOf(PlayState.camGame);
					PlayState.camGame.angle = FlxG.random.getObject([-3, 3]);
					FlxTweenPlayState.tween(PlayState.camGame, {angle: 0}, 0.3);
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.04;
					PlayState.camGame.zoom += 0.2;
				}
				if (step == 1152)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.instance.stageBuild.foreground.members[1].alpha = 0;
					PlayState.forceZoom[0] = 0;
				}
				if (step == 1264)
				{
					PlayState.focus = DAD;
					PlayState.lockFocus = true;
					PlayState.forceZoom[0] = 0.1;
					FlxTweenPlayState.color(PlayState.dadOpponent, 0.2, FlxColor.WHITE, FlxColor.BLACK);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[1], {alpha: 1}, 0.5);
					PlayState.camGame.shake(0.0031, 1);
				}
				if (step == 1280)
				{
					PlayState.lockFocus = false;
					PlayState.instance.stageBuild.background.members[1].alpha = 0;
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.dadOpponent.color = FlxColor.WHITE;
					PlayState.forceZoom[0] = 0;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
				}
				if (step == 1536)
				{
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.4}, 0.2);
					PlayState.forceZoom[0] = 0.1;
				}
				if (step == 1552)
				{
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.02;
					PlayState.forceZoom[0] = 0;
				}
				if (step == 1776)
				{
					PlayState.focus = DAD;
					PlayState.lockFocus = true;
					PlayState.forceZoom[0] = 0.1;
					FlxTweenPlayState.color(PlayState.dadOpponent, 0.2, FlxColor.WHITE, FlxColor.BLACK);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[1], {alpha: 1}, 0.5);
					PlayState.camGame.shake(0.0031, 1);
				}
				if (step == 1792)
				{
					PlayState.lockFocus = false;
					PlayState.instance.stageBuild.background.members[1].alpha = 0;
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.dadOpponent.color = FlxColor.WHITE;
					PlayState.forceZoom[0] = 0;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
				}
				if (step == 1920 || step == 1936 || step == 1952 || step == 1968 || step == 1984 || step == 2000 || step == 2016 || step == 2032)
				{
					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.02;

					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.4;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (step == 1920)
				{
					Init.trueSettings['No Camera Note Movement'] = true;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.defaultCamZoom = 0.62;
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.foreground.members[1], {alpha: 0.2}, 0.2);
				}
				if (step == 2048)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.defaultCamZoom = 0.82;
				}
				if (step == 2064 || step == 2066 || step == 2068 || step == 2070 || step == 2072 || step == 2073 || step == 2074 || step == 2075
					|| step == 2076 || step == 2077 || step == 2078 || step == 2079)
				{
					PlayState.camGame.zoom += 0.1;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.01;
				}
				if (step == 2080)
				{
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-2"));
					PlayState.instance.stageBuild.background.members[0].setPosition(-470, -500);
					PlayState.instance.stageBuild.background.members[0].visible = false;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.defaultCamZoom = 0.72;

					PlayState.instance.stageBuild.foreground.members[1].alpha = 1;

					PlayState.dadOpponent.color = FlxColor.BLACK;
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.foreground.members[1], {alpha: 0}, 12);
				}
				if (step == 2200)
				{
					PlayState.defaultCamZoom = 0.82;
					PlayState.camGame.zoom = 0.82;

					PlayState.camGame.angle = 10;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.2;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (step == 2204)
				{
					PlayState.defaultCamZoom = 0.92;
					PlayState.camGame.zoom = 0.92;

					PlayState.camGame.angle = -10;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.2;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (step == 2208)
				{
					PlayState.instance.stageBuild.background.members[1].alpha = 1;
					PlayState.camGame.flash(FlxColor.WHITE, 1.7);
					PlayState.defaultCamZoom = 0.92;
					PlayState.camGame.zoom += 0.5;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.05;

					PlayState.camGame.angle = 0;

					PlayState.dadOpponent.color = FlxColor.WHITE;
					PlayState.dadOpponent.setCharacter(504, 382, "intruderlured_alt");
					PlayState.dadOpponent.setPosition(504, 382);
				}
				if (step == 2368)
				{

					PlayState.defaultCamZoom = 0.62;
					PlayState.instance.stageBuild.background.members[1].alpha = 0;
					PlayState.instance.stageBuild.background.members[2].alpha = 0;
					PlayState.instance.stageBuild.background.members[3].alpha = 0;
					PlayState.instance.stageBuild.foreground.members[0].visible = false;
					PlayState.dadOpponent.alpha = 0;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camHUD.alpha = 0;
					for (hud in PlayState.strumHUD)
						hud.alpha = 0;
				}
				if (step == 2371)
				{
					for (text in textMaps)
						FlxTweenPlayState.tween(text, {y: text.y + 50}, 2, {type: PINGPONG, ease: FlxEase.sineInOut});
					add(textMaps["What's the matter?"]);
				}
				if (step == 2384)
				{
					textMaps["What's the matter?"].destroy();
					add(textMaps["Cat got your tongue?"]);
				}
				if (step == 2407)
				{
					textMaps["Cat got your tongue?"].destroy();
					add(textMaps["DON'T."]);
				}
				if (step == 2429)
				{
					textMaps["DON'T."].destroy();
					add(textMaps["JUST DON'T."]);
				}
				if (step == 2438)
				{
					textMaps["JUST DON'T."].destroy();
					add(textMaps["Okay?..."]);
				}
				if (step == 2449)
				{
					textMaps["Okay?..."].destroy();
					add(textMaps["PLEASE."]);
				}
				if (step == 2464)
				{
					FlxTweenPlayState.tween(adam, {alpha: 0.4}, 0.7);
					FlxTweenPlayState.tween(adam, {x: -100}, 0.5, {ease: FlxEase.sineOut});

					FlxTweenPlayState.tween(jonah, {alpha: 0.4}, 0.7);
					FlxTweenPlayState.tween(jonah, {x: FlxG.width - jonah.width + 100}, 0.5, {ease: FlxEase.sineOut});

					FlxTweenPlayState.tween(adam, {y: adam.y + 50}, 2, {startDelay: 0.5, type: PINGPONG, ease: FlxEase.sineInOut});

					FlxTweenPlayState.tween(jonah, {y: jonah.y + 50}, 2, {startDelay: 0.5, type: PINGPONG, ease: FlxEase.sineInOut});
				}
				if (step == 2624 || step == 2630 || step == 2636 || step == 2640 || step == 2646 || step == 2652 || step == 2656 || step == 2662
					|| step == 2668 || step == 2672 || step == 2678 || step == 2684 || step == 2688 || step == 2694 || step == 2700 || step == 2704
					|| step == 2710 || step == 2716 || step == 2720 || step == 2726 || step == 2732 || step == 2736 || step == 2742 || step == 2748
					|| step == 2752 || step == 2758 || step == 2764 || step == 2768 || step == 2774 || step == 2780 || step == 2784 || step == 2790
					|| step == 2796 || step == 2800 || step == 2806 || step == 2812 || step == 2816 || step == 2822 || step == 2828 || step == 2832
					|| step == 2838 || step == 2844 || step == 2848 || step == 2854 || step == 2860)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.2;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);

					PlayState.camGame.zoom += 0.02;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.02;
				}
				if (step == 2465)
				{
					textMaps["PLEASE."].destroy();
					add(textMaps["Oh, so NOW you're \ntaking this\nseriously."]);
				}
				if (step == 2516)
				{
					textMaps["Oh, so NOW you're \ntaking this\nseriously."].destroy();
					add(textMaps["Dude, I don't know\nwhat you want\nfrom me"]);
				}
				if (step == 2549)
				{
					textMaps["Dude, I don't know\nwhat you want\nfrom me"].destroy();
					add(textMaps["I'm as serious now\nas i've ever been."]);
				}
				if (step == 2605)
				{
					textMaps["I'm as serious now\nas i've ever been."].destroy();
					add(textMaps["This whole time, huh?"]);
				}
				if (step == 2627)
				{
					textMaps["This whole time, huh?"].destroy();
					add(textMaps["So you FUCKING with me\nwas you being serious."]);
				}
				if (step == 2672)
				{
					textMaps["So you FUCKING with me\nwas you being serious."].destroy();
					add(textMaps["I get that I screw around\nsometimes, okay?"]);
				}
				if (step == 2717)
				{
					textMaps["I get that I screw around\nsometimes, okay?"].destroy();
					add(textMaps["But that's just what i do!"]);
				}
				if (step == 2730)
				{
					textMaps["But that's just what i do!"].destroy();
					add(textMaps["Well maybe it\nshouldn't be."]);
				}
				if (step == 2750)
				{
					textMaps["Well maybe it\nshouldn't be."].destroy();
					add(textMaps["Look man, I'm just\nDEVASTATED that I'm not as\nBROKEN as you are"]);
				}
				if (step == 2822)
				{
					textMaps["Look man, I'm just\nDEVASTATED that I'm not as\nBROKEN as you are"].destroy();
					add(textMaps["With EVERYTHING\nthat's happened"]);
				}
				if (step == 2841)
				{
					textMaps["With EVERYTHING\nthat's happened"].destroy();
					add(textMaps["And I'm sorry that I\ncan't help you\ncarry this burden."]);
				}
				if (step == 2861)
				{
					textMaps["And I'm sorry that I\ncan't help you\ncarry this burden."].destroy();
					add(textMaps[
						"And I'm sorry that I\ncan't helpppppppppppppppppppppppppp\nppppppppppppppppppppppppppppppppppppppppppp\npppppppppppppppppppppppppppppppppppppppppp\nppppppppppppppppppppppppppppppppppppppppppp\npppppppppppppppppppppppppppppppppppppppppp"]);
				}
				if (step == 2864)
				{
					adam.visible = false;
					jonah.visible = false;
					for (text in textMaps)
					    FlxTweenPlayState.cancelTweensOf(text);
					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 0.1});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[2], {alpha: 0.1});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[3], {alpha: 0.1});
					for (hud in PlayState.strumHUD)
						FlxTweenPlayState.tween(hud, {alpha: 0.4}, 0.5);
					FlxTweenPlayState.tween(PlayState.camHUD, {alpha: 0.4}, 0.5);
					textMaps[
						"And I'm sorry that I\ncan't helpppppppppppppppppppppppppp\nppppppppppppppppppppppppppppppppppppppppppp\npppppppppppppppppppppppppppppppppppppppppp\nppppppppppppppppppppppppppppppppppppppppppp\npppppppppppppppppppppppppppppppppppppppppp"
					].destroy();
					add(textMaps["OH MY GOD"]);
					textMaps["OH MY GOD"].screenCenter();
				}
				if (step == 2870)
				{
					textMaps["OH MY GOD"].destroy();
					add(textMaps["BEHIND YOU!"]);
					textMaps["BEHIND YOU!"].screenCenter();
				}
				if (step == 2880)
				{
					textMaps["BEHIND YOU!"].destroy();
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.dadOpponent.alpha = 1;
					PlayState.instance.stageBuild.background.members[0].visible = true;
					PlayState.instance.stageBuild.background.members[2].alpha = 1;
					PlayState.instance.stageBuild.background.members[3].alpha = 1;
					PlayState.instance.stageBuild.foreground.members[0].visible = true;
					for (hud in PlayState.instance.allUIs)
						hud.alpha = 1;
				}
				if (step == 3000)
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-cat"));
				if (step == 3008)
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-2"));
				if (step == 3128)
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-cat"));
				if (step == 3136)
				{
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-2"));
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.4}, 0.2);
					PlayState.forceZoom[0] = 0.1;
				}
				if (step == 3152)
				{
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.02;
					PlayState.forceZoom[0] = 0;
				}
				if (step == 3256)
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-cat"));
				if (step == 3264)
				{
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-2"));
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
				}
				if (step == 3288)
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-cat"));
				if (step == 3296)
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-2"));
				if (step == 3317)
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-cat"));
				if (step == 3328)
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-2"));
				if (step == 3352)
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-cat"));
				if (step == 3360)
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-2"));
				if (step == 3264 || step == 3270 || step == 3276 || step == 3280 || step == 3286 || step == 3292 || step == 3296 || step == 3302
					|| step == 3308 || step == 3312 || step == 3318 || step == 3324 || step == 3328 || step == 3334 || step == 3340 || step == 3344
					|| step == 3350 || step == 3356 || step == 3360 || step == 3366 || step == 3372)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.4;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					FlxTweenPlayState.cancelTweensOf(PlayState.camGame);
					PlayState.camGame.angle = FlxG.random.getObject([-3, 3]);
					FlxTweenPlayState.tween(PlayState.camGame, {angle: 0}, 0.3);
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.04;
					PlayState.camGame.zoom += 0.2;
				}
				if (step == 3376)
				{
					Init.trueSettings['No Camera Note Movement'] = true;
					PlayState.defaultCamZoom = 0.92;
					FlxTweenPlayState.color(PlayState.dadOpponent, 0.2, FlxColor.WHITE, FlxColor.BLACK);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[1], {alpha: 1}, 0.5);
					PlayState.camGame.shake(0.0031, 1);
				}
				if (step == 3381)
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-cat"));
				if (step == 3392)
				{
					PlayState.instance.stageBuild.background.members[0].loadGraphic(Paths.image("backgrounds/lured/basement-2"));
					PlayState.camGame.flash(FlxColor.WHITE, 1.5);
					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.02;
					PlayState.dadOpponent.color = FlxColor.WHITE;
					PlayState.instance.stageBuild.foreground.members[1].alpha = 0.2;
					PlayState.instance.stageBuild.background.members[1].alpha = 0;
				}
				if (step == 3520 || step == 3536 || step == 3552 || step == 3568 || step == 3584 || step == 3600 || step == 3616 || step == 3632)
				{
					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.02;

					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.4;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (step == 3520)
				{
					Init.trueSettings['No Camera Note Movement'] = true;
					PlayState.camGame.flash(FlxColor.WHITE, 1.5);
					PlayState.defaultCamZoom = 0.62;
					PlayState.dadOpponent.color = FlxColor.WHITE;
				}
				if (step == 3648)
				{
					PlayState.defaultCamZoom = 0.92;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
				}
				if (step == 3664 || step == 3666 || step == 3668 || step == 3670 || step == 3672 || step == 3673 || step == 3674 || step == 3675
					|| step == 3676 || step == 3677 || step == 3678 || step == 3679)
				{
					PlayState.camGame.zoom += 0.2;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.02;
				}
				if (step == 3679)
					PlayState.camGame.visible = false;
			case "Followed":
				if (step == 1)
					FlxTweenPlayState.tween(PlayState.camGame, {alpha: 1}, 10);
				if (step == 124)
					FlxTweenPlayState.tween(PlayState.camGame, {alpha: 0}, 0.4);
				if (step == 128)
				{
					PlayState.camGame.alpha = 1;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
				}
				if (step == 16 || step == 20 || step == 24 || step == 48 || step == 52 || step == 56 || step == 80 || step == 84
					|| step == 88 || step == 112 || step == 116 || step == 120 || step == 128 || step == 136 || step == 144
					|| step == 148 || step == 152 || step == 156 || step == 160 || step == 168 || step == 176 || step == 180
					|| step == 184 || step == 188 || step == 192 || step == 200 || step == 208 || step == 212 || step == 216
					|| step == 220 || step == 224 || step == 232 || step == 240 || step == 244 || step == 248 || step == 252)
				{
					PlayState.camGame.zoom += 0.1;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.02;
				}
				if (step == 240)
				{
					PlayState.defaultCamZoom = 1.3;
					FlxTweenPlayState.tween(PlayState.camGame, {alpha: 0.6}, 0.3);
					PlayState.instance.stageBuild.background.members[1].visible = true;
					FlxTweenPlayState.tween(PlayState.camHUD, {alpha: 0}, 0.1);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[2], {alpha: 0}, 0.5);
					PlayState.boyfriend.characterData.camOffsetX = 1450;
					PlayState.boyfriend.characterData.camOffsetY = -700;
					add(textMaps["L"]);
				}
				if (step == 242)
				{
					textMaps["L"].destroy();
					add(textMaps["LL"]);
				}
				if (step == 243)
				{
					textMaps["LL"].destroy();
					add(textMaps["LLL"]);
				}
				if (step == 244)
				{
					textMaps["LLL"].destroy();
					add(textMaps["LET"]);
				}
				if (step == 246)
					add(textMaps["ME"]);
				if (step == 248)
					add(textMaps["IN"]);
				if (step == 252)
					add(textMaps["MARK."]);
				if (step == 256)
				{
					PlayState.defaultCamZoom = 0.83;
					textMaps["LET"].destroy();
					textMaps["ME"].destroy();
					textMaps["IN"].destroy();
					textMaps["MARK."].destroy();

					PlayState.lockFocus = false;
					PlayState.camGame.alpha = 1;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camHUD.alpha = 1;
					PlayState.instance.stageBuild.background.members[1].destroy();
					PlayState.instance.stageBuild.background.members[2].destroy();
					PlayState.dadOpponent.visible = true;
					PlayState.boyfriend.setCharacter(0, 0, "mark");
					PlayState.boyfriend.setPosition(1650, 600);
					PlayState.instance.stageBuild.background.members[0].visible = true;

				}
				if (step == 384)
				{
					PlayState.defaultCamZoom += 0.45;
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.4}, 0.2);
					PlayState.dadOpponent.characterData.camOffsetX -= 100;
				}
				if (step == 416)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.defaultCamZoom -= 0.45;
					PlayState.dadOpponent.characterData.camOffsetX += 100;
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
				}

				//////////single section lol
				if (step == 512 || step == 544 || step == 576 || step == 608 || step == 640)
				{
					PlayState.lockFocus = false;
					if (step == 512)
					{
						PlayState.defaultCamZoom += 0.45;
						FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.4}, 0.2);
						PlayState.dadOpponent.characterData.camOffsetX -= 100;
					}
					else
						PlayState.defaultCamZoom += 0.75;
				}
				if (step == 535 || step == 569 || step == 599 || step == 633)
				{
					PlayState.focus = BF;
					PlayState.lockFocus = true;
					PlayState.defaultCamZoom -= 0.75;
				}
				if (step == 536 || step == 540 || step == 570 || step == 572 || step == 600 || step == 604 || step == 634
					|| step == 636 || step == 638)
				{
					FlxTweenPlayState.cancelTweensOf(shoot);
					shoot.alpha = 0.7;
					FlxTweenPlayState.tween(shoot, {alpha: 0}, 0.5);

					PlayState.camGame.zoom += 0.09;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.05;
					PlayState.boyfriend.playAnim("shoot");
				}
				//////////

				if (step == 640)
					PlayState.boyfriend.characterData.camOffsetX -= 100;
				if (step == 752)
				{
					FlxTweenPlayState.tween(PlayState.camGame, {alpha: 0}, 0.2);
					FlxTweenPlayState.tween(PlayState.camHUD, {alpha: 0}, 0.2);
					add(textMaps["YOU"]);
				}
				if (step == 756)
					add(textMaps["FUCKING"]);
				if (step == 760)
					add(textMaps["BASTARD!"]);
				if (step == 768)
				{
					remove(textMaps["YOU"]);
					remove(textMaps["FUCKING"]);
					remove(textMaps["BASTARD!"]);

					FlxTweenPlayState.cancelTweensOf(shoot);
					shoot.alpha = 0.7;
					FlxTweenPlayState.tween(shoot, {alpha: 0}, 0.5);

					PlayState.camGame.zoom += 0.09;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.05;
					PlayState.boyfriend.playAnim("shoot");

					PlayState.camGame.alpha = 1;
					PlayState.camHUD.alpha = 1;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);

					PlayState.dadOpponent.angle = -2;
					PlayState.boyfriend.angle = -2;
					for (hud in PlayState.instance.allUIs)
						hud.angle = -2;
					PlayState.instance.stageBuild.background.members[0].angle = -2;

					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.tween(hud, {angle: 2}, 2.5, {ease: FlxEase.sineInOut, type: PINGPONG});
					FlxTweenPlayState.tween(PlayState.dadOpponent, {angle: 2}, 2.5, {ease: FlxEase.sineInOut, type: PINGPONG});
					FlxTweenPlayState.tween(PlayState.boyfriend, {angle: 2}, 2.5, {ease: FlxEase.sineInOut, type: PINGPONG});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {angle: 2}, 2.5, {ease: FlxEase.sineInOut, type: PINGPONG});
					PlayState.dadOpponent.characterData.camOffsetX += 100;
					PlayState.boyfriend.characterData.camOffsetX += 100;
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.defaultCamZoom -= 0.45;
				}
				if (step == 800 || step == 832 || step == 864 || step == 896 || step == 904 || step == 912 || step == 916
					|| step == 920 || step == 928)
				{
					FlxTweenPlayState.cancelTweensOf(shoot);
					shoot.alpha = 0.7;
					FlxTweenPlayState.tween(shoot, {alpha: 0}, 0.5);

					PlayState.camGame.zoom += 0.09;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.05;
					PlayState.boyfriend.playAnim("shoot");
				}
				if (step == 896)
				{
					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.cancelTweensOf(hud);
					FlxTweenPlayState.cancelTweensOf(PlayState.dadOpponent);
					FlxTweenPlayState.cancelTweensOf(PlayState.instance.stageBuild.background.members[0]);
					FlxTweenPlayState.cancelTweensOf(PlayState.boyfriend);

					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.tween(hud, {angle: 0}, 0.5, {ease: FlxEase.sineInOut});
					FlxTweenPlayState.tween(PlayState.dadOpponent, {angle: 0}, 0.5, {ease: FlxEase.sineInOut});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {angle: 0}, 0.5, {ease: FlxEase.sineInOut});
					FlxTweenPlayState.tween(PlayState.boyfriend, {angle: 0}, 0.5, {ease: FlxEase.sineInOut});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.4}, 0.2);
					PlayState.dadOpponent.characterData.camOffsetX -= 100;
					PlayState.defaultCamZoom += 0.45;
				}
				if (step == 928)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);

					PlayState.dadOpponent.angle = -2;
					PlayState.boyfriend.angle = -2;
					for (hud in PlayState.instance.allUIs)
						hud.angle = -2;
					PlayState.instance.stageBuild.background.members[0].angle = -2;

					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.tween(hud, {angle: 2}, 2.5, {ease: FlxEase.sineInOut, type: PINGPONG});
					FlxTweenPlayState.tween(PlayState.dadOpponent, {angle: 2}, 2.5, {ease: FlxEase.sineInOut, type: PINGPONG});
					FlxTweenPlayState.tween(PlayState.boyfriend, {angle: 2}, 2.5, {ease: FlxEase.sineInOut, type: PINGPONG});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {angle: 2}, 2.5, {ease: FlxEase.sineInOut, type: PINGPONG});
					PlayState.dadOpponent.characterData.camOffsetX += 100;
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.defaultCamZoom -= 0.45;
				}
				if (step == 960 || step == 992 || step == 1024 || step == 1080 || step == 1084 || step == 1088 || step == 1120
					|| step == 1152 || step == 1180 || step == 1184 || step == 1208 || step == 1216 || step == 1248)
				{
					FlxTweenPlayState.cancelTweensOf(shoot);
					shoot.alpha = 0.7;
					FlxTweenPlayState.tween(shoot, {alpha: 0}, 0.5);

					PlayState.camGame.zoom += 0.09;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.05;
					PlayState.boyfriend.playAnim("shoot");
				}
				if (step == 1024)
				{
					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.cancelTweensOf(hud);
					FlxTweenPlayState.cancelTweensOf(PlayState.dadOpponent);
					FlxTweenPlayState.cancelTweensOf(PlayState.instance.stageBuild.background.members[0]);
					FlxTweenPlayState.cancelTweensOf(PlayState.boyfriend);

					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.tween(hud, {angle: 0}, 0.5, {ease: FlxEase.sineInOut});
					FlxTweenPlayState.tween(PlayState.dadOpponent, {angle: 0}, 0.5, {ease: FlxEase.sineInOut});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {angle: 0}, 0.5, {ease: FlxEase.sineInOut});
					FlxTweenPlayState.tween(PlayState.boyfriend, {angle: 0}, 0.5, {ease: FlxEase.sineInOut});
				}
				if (step == 1152)
				{
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.4}, 0.2);
					PlayState.dadOpponent.characterData.camOffsetX -= 100;
					PlayState.boyfriend.characterData.camOffsetX -= 100;
					PlayState.defaultCamZoom += 0.45;
				}
				if (step == 1264)
				{
					FlxTweenPlayState.tween(PlayState.camGame, {alpha: 0.6}, 0.3);
					add(textMaps["KILL"]);
				}
				if (step == 1268)
					add(textMaps["YOURSELF."]);
				if (step == 1280 || step == 1288 || step == 1296 || step == 1300 || step == 1304 || step == 1312 || step == 1320
					|| step == 1328 || step == 1330 || step == 1332 || step == 1336 || step == 1338 || step == 1340 || step == 1344
					|| step == 1350 || step == 1352 || step == 1356 || step == 1360 || step == 1366 || step == 1368 || step == 1372
					|| step == 1376 || step == 1380 || step == 1384 || step == 1390 || step == 1392 || step == 1396 || step == 1400
					|| step == 1408 || step == 1416 || step == 1418 || step == 1420 || step == 1424 || step == 1428 || step == 1432
					|| step == 1440 || step == 1448 || step == 1456 || step == 1458 || step == 1460 || step == 1464 || step == 1466
					|| step == 1468 || step == 1472 || step == 1478 || step == 1480 || step == 1484 || step == 1488 || step == 1494
					|| step == 1496 || step == 1500 || step == 1504 || step == 1508 || step == 1512 || step == 1518 || step == 1520
					|| step == 1524 || step == 1528 || step == 1536)
				{
					FlxTweenPlayState.cancelTweensOf(shoot);
					shoot.alpha = 0.7;
					FlxTweenPlayState.tween(shoot, {alpha: 0}, 0.5);

					PlayState.camGame.zoom += 0.09;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.05;
					PlayState.boyfriend.playAnim("shoot");
				}
				if (step == 1280)
				{
					textMaps["KILL"].destroy();
					textMaps["YOURSELF."].destroy();

					PlayState.camGame.alpha = 1;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);

					PlayState.dadOpponent.angle = -2;
					PlayState.boyfriend.angle = -2;
					for (hud in PlayState.instance.allUIs)
						hud.angle = -2;
					PlayState.instance.stageBuild.background.members[0].angle = -2;

					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.tween(hud, {angle: 2}, 2.5, {ease: FlxEase.sineInOut, type: PINGPONG});
					FlxTweenPlayState.tween(PlayState.dadOpponent, {angle: 2}, 2.5, {ease: FlxEase.sineInOut, type: PINGPONG});
					FlxTweenPlayState.tween(PlayState.boyfriend, {angle: 2}, 2.5, {ease: FlxEase.sineInOut, type: PINGPONG});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {angle: 2}, 2.5, {ease: FlxEase.sineInOut, type: PINGPONG});
					PlayState.dadOpponent.characterData.camOffsetX += 100;
					PlayState.boyfriend.characterData.camOffsetX += 100;
					PlayState.instance.stageBuild.background.members[0].alpha = 1;
					PlayState.defaultCamZoom -= 0.45;
				}
				if (step == 1416)
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
				if (step == 1536)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);

					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.cancelTweensOf(hud);
					FlxTweenPlayState.cancelTweensOf(PlayState.dadOpponent);
					FlxTweenPlayState.cancelTweensOf(PlayState.instance.stageBuild.background.members[0]);
					FlxTweenPlayState.cancelTweensOf(PlayState.boyfriend);

					for (hud in PlayState.instance.allUIs)
						FlxTweenPlayState.tween(hud, {angle: 0}, 0.5, {ease: FlxEase.sineInOut});
					FlxTweenPlayState.tween(PlayState.dadOpponent, {angle: 0}, 0.5, {ease: FlxEase.sineInOut});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {angle: 0}, 0.5, {ease: FlxEase.sineInOut});
					FlxTweenPlayState.tween(PlayState.boyfriend, {angle: 0}, 0.5, {ease: FlxEase.sineInOut});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.4}, 0.2);
					PlayState.dadOpponent.characterData.camOffsetX -= 100;
					PlayState.boyfriend.characterData.camOffsetX -= 100;
					PlayState.defaultCamZoom += 0.45;
				}
				if (step == 1662)
				{
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0.2}, 0.2);
					PlayState.dadOpponent.characterData.camOffsetX -= 90;
					PlayState.boyfriend.characterData.camOffsetX -= 90;
					PlayState.defaultCamZoom += 0.2;
				}
				if (step == 1774)
				{
					FlxTweenPlayState.tween(PlayState.camGame, {alpha: 0}, 0.2);
					FlxTweenPlayState.tween(PlayState.camHUD, {alpha: 0}, 0.2);
					add(textMaps["YOU"]);
				}
				if (step == 1778)
					add(textMaps["FUCKING"]);
				if (step == 1782)
					add(textMaps["BASTARD!"]);
				if (step == 1790)
				{
					textMaps["YOU"].destroy();
					textMaps["FUCKING"].destroy();
					textMaps["BASTARD!"].destroy();

					PlayState.camGame.alpha = 1;
					PlayState.camHUD.alpha = 1;
					for (hud in PlayState.strumHUD)
						hud.visible = false;
					red.visible = true;
					FlxG.cameras.shake();
					PlayState.health = 0.0000000000001;
				}

			case "Expedited":
				if (step == 1)
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.5}, 10);
				if (step == 128)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					FlxTweenPlayState.cancelTweensOf(blackOverlay);
					blackOverlay.alpha = 0.3;
					phillyGlowGradient.intendedAlpha = 0.5;
					phillyGlowParticles.alpha = 1;
				}
				if (step == 240)
					blackOverlay.alpha = 1;
				if (step == 256)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					blackOverlay.alpha = 0.3;
					for (cam in PlayState.instance.allUIs)
						cam.visible = true;
				}
				if (step == 384)
				{
					PlayState.defaultCamZoom += 0.05;
					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 0}, 1.3);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0}, 1.3);
					FlxTweenPlayState.tween(PlayState, {defaultCamZoom: PlayState.defaultCamZoom + 0.4}, 13);
					PlayState.instance.camFollow.x += 500;
				}
				if (step == 448)
				{
					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 1}, 0.3);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 1}, 0.3);
					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 0}, 1.3);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[1], {alpha: 0}, 1.3);
					PlayState.instance.camFollow.x -= 1000;
				}
				if (step == 496)
				{
					FlxTweenPlayState.cancelTweensOf(PlayState);
					PlayState.defaultCamZoom += 0.2;
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.5}, 0.3);
					PlayState.instance.camFollow.x -= 100;
				}
				if (step == 512)
				{
					PlayState.dadOpponent.alpha = 1;
					PlayState.instance.stageBuild.background.members[1].alpha = 1;
					PlayState.instance.camFollow.x += 1200;
				}
				if (step == 516)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.defaultCamZoom = 0.52;
					PlayState.instance.camFollow.x -= 600;
					blackOverlay.alpha = 0.3;
				}
				if (step == 640)
				{
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.camGame.zoom += 0.1;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.2;
				}
				if (step == 696)
				{
					phillyGlowGradient.intendedAlpha = 0;
					phillyGlowParticles.alpha = 0;
					PlayState.camGame.flash(FlxColor.BLACK, 0.5);
					PlayState.dadOpponent.setCharacter(0, 0, "alt_cesar");
					PlayState.dadOpponent.setPosition(PlayState.instance.stageBuild.background.members[1].x - 130, PlayState.instance.stageBuild.background.members[1].y - 100);
				}
				if (step == 696 || step == 698 || step == 700 || step == 701 || step == 702 || step == 703 || step == 704)
				{
					PlayState.camGame.zoom += 0.04;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.03;
				}
				if (step == 708)
				{
					PlayState.camGame.zoom += 0.1;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.2;
					phillyGlowGradient.intendedAlpha = 0.5;
					phillyGlowParticles.alpha = 1;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2, null, true);
					PlayState.dadOpponent.setCharacter(PlayState.dadOpponent.x, PlayState.dadOpponent.y, "cesarphone");
					PlayState.dadOpponent.setPosition(PlayState.instance.stageBuild.background.members[1].x - 130, PlayState.instance.stageBuild.background.members[1].y - 100);
				}
				if (step == 768)
					blackOverlay.alpha = 1;
				if (step == 771)
					add(textMaps["Could you do me a favor?"]);
				if (step == 784)
				{
					textMaps["Could you do me a favor?"].destroy();
					phillyGlowGradient.intendedAlpha = 0;
					phillyGlowParticles.alpha = 0;
					PlayState.camGame.zoom += 0.1;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.2;
					blackOverlay.alpha = 0.3;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2, null, true);

					PlayState.boyfriend.alpha = 0;
					PlayState.instance.stageBuild.background.members[0].alpha = 0;
				}
				if (step == 832)
				{
					PlayState.camGame.zoom += 0.05;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.1;
					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 1}, 0.3);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 1}, 0.3);
				}
				if (step == 848)
				{
					PlayState.camGame.zoom += 0.05;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.1;
				}
				if (step == 896)
				{
					PlayState.instance.camFollow.x -= 600;
					PlayState.defaultCamZoom += 0.7;
				}
				if (step == 904)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.6}, 0.3);
					add(textMaps["Yeah, of course!"]);
				}
				if (step == 912)
				{
					textMaps["Yeah, of course!"].destroy();
					blackOverlay.alpha = 0.3;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.defaultCamZoom = 1.05;
					PlayState.boyfriend.alpha = 0;
					PlayState.instance.stageBuild.background.members[0].alpha = 0;

					PlayState.instance.stageBuild.background.members[0].x = PlayState.instance.stageBuild.background.members[1].x;
					PlayState.boyfriend.x = PlayState.instance.stageBuild.background.members[0].x - 50;
					PlayState.instance.camFollow.x += 1200;

					phillyGlowGradient.intendedAlpha = 0.5;
					phillyGlowParticles.alpha = 1;
				}
				if (step == 976)
				{
					PlayState.defaultCamZoom = 0.52;

					PlayState.instance.camFollow.x -= 600;

					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 1}, 0.7);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 1}, 0.7);
					FlxTweenPlayState.tween(PlayState.boyfriend, {x: -50}, 0.5, {ease: FlxEase.sineOut});
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {x: 0}, 0.5, {ease: FlxEase.sineOut});	
				}
				if (step == 1024)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.5}, 0.3);
					PlayState.defaultCamZoom = 0.72;
					FlxTweenPlayState.color(PlayState.dadOpponent, 0.3, FlxColor.WHITE, FlxColor.BLACK);
				}
				if (step == 1040)
				{
					blackOverlay.alpha = 0.3;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.defaultCamZoom = 0.52;

					PlayState.dadOpponent.color = FlxColor.WHITE;
					PlayState.dadOpponent.setCharacter(0, 0, "alt_cesar");
					PlayState.dadOpponent.setPosition(PlayState.instance.stageBuild.background.members[1].x - 130,
						PlayState.instance.stageBuild.background.members[1].y - 100);
				}
				if (step == 1160)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.5}, 0.3);
					PlayState.defaultCamZoom = 0.72;
				}
				if (step == 1168)
				{
					PlayState.boyfriend.alpha = 0;
					PlayState.instance.stageBuild.background.members[0].alpha = 0;

					blackOverlay.alpha = 0.3;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);

					PlayState.instance.camFollow.x += 600;
				}
				if (step == 1232)
				{
					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 1}, 0.3);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 1}, 0.3);

					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 0}, 0.3);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[1], {alpha: 0}, 0.3);

					PlayState.instance.camFollow.x -= 1200;
				}
				if (step == 1260)
					ShaderObject.setValue("block.intensity.value", [0.1]);
				if (step == 1264)
					ShaderObject.setValue("block.intensity.value", [0]);
				if (step == 1292)
					ShaderObject.setValue("block.intensity.value", [0.1]);
				if (step == 1296)
				{
					ShaderObject.setValue("block.intensity.value", [0]);
					PlayState.instance.camFollow.x += 1200;

					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 0}, 0.3);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 0}, 0.3);

					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 1}, 0.3);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[1], {alpha: 1}, 0.3);
				}
				if (step == 1360)
				{
					PlayState.instance.camFollow.x -= 1200;

					FlxTweenPlayState.tween(PlayState.dadOpponent, {alpha: 0}, 0.3);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[1], {alpha: 0}, 0.3);

					FlxTweenPlayState.tween(PlayState.boyfriend, {alpha: 1}, 0.3);
					FlxTweenPlayState.tween(PlayState.instance.stageBuild.background.members[0], {alpha: 1}, 0.3);
				}
				if (step == 1388)
					ShaderObject.setValue("block.intensity.value", [0.1]);
				if (step == 1392)
					ShaderObject.setValue("block.intensity.value", [0]);
				if (step == 1408)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.5}, 0.3);
					PlayState.defaultCamZoom = 0.92;
				}
				if (step == 1420)
				{
					blackOverlay.alpha = 0.3;
					ShaderObject.setValue("block.intensity.value", [0.1]);
				}
				if (step == 1434)
					FlxTweenPlayState.num(0.1, 0.3, 0.4, {ease: FlxEase.sineIn}, function(num:Float) ShaderObject.setValue("block.intensity.value", [num]));
				if (step == 1440)
				{
					blackOverlay.alpha = 1;
					ShaderObject.setValue("block.intensity.value", [0]);
					PlayState.instance.camFollow.x += 600;
					PlayState.defaultCamZoom = 0.52;
				}
				if (step == 1448)
				{
					blackOverlay.alpha = 0.3;
					PlayState.camGame.flash(FlxColor.WHITE, 1.2);
					PlayState.dadOpponent.alpha = 1;
					PlayState.instance.stageBuild.background.members[1].alpha = 1;
				}
				if (step == 1576)
					blackOverlay.alpha = 1;
            case "Traumatized":
                if (step == 128)
                {
                    blackOverlay.alpha = 0.3;
                    whiteOverlay.alpha = 0.6;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
                }
				if (step == 252)
				{
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.6}, 0.2);
					PlayState.defaultCamZoom = 2.5;
				}
                if (step == 256)
                {
					blackOverlay.alpha = 0.3;
					whiteOverlay.alpha = 0.6;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
					phillyGlowGradient.visible = true;
					phillyGlowGradient2.visible = true;
                }
                if (step == 504)
                {
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.6}, 0.2);
					PlayState.defaultCamZoom = 1.5;
                }
				if (step == 512)
				{
					blackOverlay.alpha = 0;
					whiteOverlay.alpha = 0.6;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
					phillyGlowGradient.visible = false;
					phillyGlowGradient2.visible = false;
					PlayState.defaultCamZoom = 0.95;
					PlayState.lockCamPos = true;

					PlayState.instance.camFollow.y -= 100;
				}
				if (step == 640)
				{
					PlayState.lockCamPos = false;
					PlayState.dadOpponent.color = FlxColor.WHITE;
					PlayState.boyfriend.color = FlxColor.WHITE;
					PlayState.instance.stageBuild.background.members[0].color = FlxColor.WHITE;

					blackOverlay.alpha = 0.3;
					whiteOverlay.alpha = 0.6;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
					phillyGlowGradient.visible = true;
					phillyGlowGradient2.visible = true;
				}
                if (step == 768)
                {
					whiteOverlay.alpha = 0.6;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
                }
				if (step == 896)
				{
					whiteOverlay.alpha = 0.6;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
				}
                if (step == 1020)
                {
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.6}, 0.2);
					PlayState.defaultCamZoom = 1.5;
                }
                if (step == 1024)
                {
					whiteOverlay.alpha = 0.6;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
					blackOverlay.alpha = 0.5;
					phillyGlowGradient.visible = false;
					phillyGlowGradient2.visible = false;
                }
                if (step == 1136)
                {
					FlxTweenPlayState.cancelTweensOf(whiteOverlay);
					whiteOverlay.alpha = 0.2;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
					PlayState.camGame.zoom += 0.13;
                }
                if (step == 1140)
                {
					FlxTweenPlayState.cancelTweensOf(whiteOverlay);
					whiteOverlay.alpha = 0.2;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
					PlayState.camGame.zoom += 0.13;
                }
				if (step == 1144)
				{
					FlxTweenPlayState.cancelTweensOf(whiteOverlay);
					whiteOverlay.alpha = 0.2;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
					PlayState.camGame.zoom += 0.13;
				}
				if (step == 1148)
				{
					FlxTweenPlayState.cancelTweensOf(whiteOverlay);
					whiteOverlay.alpha = 0.2;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
					PlayState.camGame.zoom += 0.13;
				}
                if (step == 1152)
                {
					blackOverlay.alpha = 0.3;
					FlxTweenPlayState.cancelTweensOf(whiteOverlay);
					whiteOverlay.alpha = 0.6;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
					phillyGlowGradient.visible = true;
					phillyGlowGradient2.visible = true;
                }
                if (step == 1408)
                {
					whiteOverlay.alpha = 0.6;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);
                }
                if (step == 1656)
                {
					FlxTweenPlayState.tween(blackOverlay, {alpha: 0.6}, 0.2);
					PlayState.defaultCamZoom = 1.5;
                }
                if (step == 1664)
                {
					whiteOverlay.alpha = 0.6;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);

					blackOverlay.alpha = 0.5;
                }
                if (step == 1792)
                {
					whiteOverlay.alpha = 0.6;
					FlxTweenPlayState.tween(whiteOverlay, {alpha: 0}, 0.7);

					FlxTweenPlayState.tween(PlayState.camGame, {alpha: 0}, 5);
                }

				if ((step >= 0 && step <= 251) || (step >= 256 && step <= 503) || (step >= 640 && step <= 1019)
					|| (step >= 1024 && step <= 1655) || step >= 1664)
                {
					if (PlayState.focus == BF)
						PlayState.defaultCamZoom = 1.1;
					else if (PlayState.focus == DAD)
						PlayState.defaultCamZoom = 1.7;
                }
        }
    }

    public function onBeat(curBeat:Int)
    {
		beat = curBeat;
        switch (songName)
        {
			case "Awakened":
				if (beat % 2 == 0 && beat >= 132 && beat < 164)
				{
					PlayState.camGame.zoom += 0.05;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.03;
				}
				if (beat % 2 == 0 && beat >= 164 && beat < 288)
				{
					PlayState.camGame.zoom += 0.07;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;

					ShaderObject.setValue("bloom.intensity.value", [0.3]);
				}
				if (beat % 2 == 0 && beat >= 292 && beat < 418)
				{
					PlayState.camGame.zoom += 0.07;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;

					ShaderObject.setValue("bloom.intensity.value", [0.3]);
				}
				if (beat % 2 == 0 && beat >= 420 && beat < 484)
				{
					PlayState.camGame.zoom += 0.07;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;

					ShaderObject.setValue("bloom.intensity.value", [0.3]);
				}
				if (beat % 2 == 0 && beat >= 516 && beat < 548)
				{
					PlayState.camGame.zoom += 0.07;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;

					ShaderObject.setValue("bloom.intensity.value", [0.3]);
				}
				if (beat >= 548 && beat < 612)
				{
					PlayState.camGame.zoom += 0.05;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.03;

					ShaderObject.setValue("bloom.intensity.value", [0.3]);
				}
			case "Befriended":
				if (beat % 2 == 0 && beat >= 104 && beat < 196)
				{
					PlayState.camGame.zoom += 0.05;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.02;
				}
				if (beat >= 200 && beat < 230)
				{
					PlayState.camGame.zoom += 0.07;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;

					ShaderObject.setValue("chrom.amount.value", [0.007]);
				}
				if (beat >= 232 && beat < 260)
				{
					PlayState.camGame.zoom += 0.07;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;

					ShaderObject.setValue("chrom.amount.value", [0.007]);
				}
				if (beat >= 265 && beat < 328)
				{
					PlayState.camGame.zoom += 0.08;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.045;

					ShaderObject.setValue("chrom.amount.value", [0.007]);
				}
				if (beat % 4 == 0 && beat >= 433 && beat < 441)
				{
					PlayState.camGame.zoom += 0.05;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.02;

					FlxTweenPlayState.cancelTweensOf(eyes);
					eyes.alpha = 0.3;
					FlxTweenPlayState.tween(eyes, {alpha: 0}, 0.2);
				}
				if (beat % 2 == 0 && beat >= 441 && beat < 448)
				{
					PlayState.camGame.zoom += 0.05;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.02;

					FlxTweenPlayState.cancelTweensOf(eyes);
					eyes.alpha = 0.6;
					FlxTweenPlayState.tween(eyes, {alpha: 0}, 0.2);
				}
				if (beat >= 448 && beat < 464)
				{
					PlayState.camGame.zoom += 0.05;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.02;

					FlxTweenPlayState.cancelTweensOf(eyes);
					eyes.alpha = 0.9;
					FlxTweenPlayState.tween(eyes, {alpha: 0}, 0.2);
				}
				if (beat >= 468 && beat < 500)
				{
					PlayState.camGame.zoom += 0.08;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.045;

					ShaderObject.setValue("chrom.amount.value", [0.007]);
				}
				if (beat >= 501 && beat < 528)
				{
					PlayState.camGame.zoom += 0.08;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.045;

					ShaderObject.setValue("chrom.amount.value", [0.007]);
				}
				if (beat >= 532 && beat < 564)
				{
					PlayState.camGame.zoom += 0.08;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.045;

					ShaderObject.setValue("chrom.amount.value", [0.007]);
				}
				if (beat >= 565 && beat < 580)
				{
					PlayState.camGame.zoom += 0.08;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.045;

					ShaderObject.setValue("chrom.amount.value", [0.007]);
				}
				if (beat >= 584 && beat < 596)
				{
					PlayState.camGame.zoom += 0.08;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.045;

					ShaderObject.setValue("chrom.amount.value", [0.007]);
				}
				if (beat >= 604 && beat <= 732 && beat % 2 == 0)
				{
					PlayState.camGame.zoom += 0.05;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.02;

					FlxTweenPlayState.cancelTweensOf(eyes);
					eyes.alpha = 1;
					FlxTweenPlayState.tween(eyes, {alpha: 0}, 0.2);
				}
			case "Pursued":
				if (beat % 2 == 0 && beat < 32)
					clock.click();
				if (beat >= 48 && beat < 76 && beat % 4 == 0)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.05;
				}
				if (beat >= 80 && beat < 112 && beat % 2 == 0)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.05;
					forceBump += 0.1;
				}
				if (beat >= 116 && beat < 242)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.035;
					forceBump += 0.1;
				}
				if (beat >= 244 && beat < 276)
				{
					PlayState.camGame.zoom += 0.12;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.035;
					forceBump += 0.1;

					FlxTweenPlayState.cancelTweensOf(redVignette);
					redVignette.alpha = 0.5;
					FlxTweenPlayState.tween(redVignette, {alpha: 0}, 0.2);
				}
				if (beat >= 276 && beat < 308)
				{
					PlayState.camGame.zoom += 0.15;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.035;
					forceBump += 0.1;

					if (beat % 2 == 0)
						PlayState.camGame.angle = -2.5;
					else
						PlayState.camGame.angle = 2.5;

					FlxTweenPlayState.cancelTweensOf(redVignette);
					redVignette.alpha = 0.5;
					FlxTweenPlayState.tween(redVignette, {alpha: 0}, 0.2);
				}
				if (beat >= 308 && beat < 340 && beat % 2 == 0)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.05;
					forceBump += 0.1;
				}
				if (beat >= 340 && beat < 468)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.035;
					forceBump += 0.1;
				}
				if (beat >= 468 && beat < 532 && beat % 4 == 0)
				{
					PlayState.camGame.zoom += 0.06;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.03;
				}
				if (beat >= 532 && beat < 596)
				{
					PlayState.camGame.zoom += 0.035;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.03;
				}
				if (beat >= 596 && beat < 656 && beat % 4 == 0)
				{
					PlayState.camGame.zoom += 0.06;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.03;
				}
				if (beat >= 660 && beat < 691)
				{
					PlayState.camGame.zoom += 0.12;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.035;
					forceBump += 0.1;

					FlxTweenPlayState.cancelTweensOf(redVignette);
					redVignette.alpha = 0.5;
					FlxTweenPlayState.tween(redVignette, {alpha: 0}, 0.2);
				}
				if (beat >= 692 && beat < 724)
				{
					PlayState.camGame.zoom += 0.15;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.035;
					forceBump += 0.1;

					if (beat % 2 == 0)
						PlayState.camGame.angle = -2.5;
					else
						PlayState.camGame.angle = 2.5;

					FlxTweenPlayState.cancelTweensOf(redVignette);
					redVignette.alpha = 0.5;
					FlxTweenPlayState.tween(redVignette, {alpha: 0}, 0.2);
				}
			case "Remembered":
				if (beat >= 64 && beat < 188)
				{
					PlayState.camGame.zoom += 0.07;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.03;
					forceBump += 0.07;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.1;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (beat >= 192 && beat < 318)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;
					forceBump += 0.1;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.2;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (beat >= 320 && beat < 352 && beat % 2 == 0)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;
					forceBump += 0.1;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (beat >= 352 && beat < 416)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;
					forceBump += 0.1;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (beat >= 448 && beat < 572)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;
					forceBump += 0.1;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.2;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (beat >= 608 && beat < 640 && beat % 2 == 0)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;
					forceBump += 0.1;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (beat >= 641 && beat < 704)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;
					forceBump += 0.1;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (beat >= 752 && beat < 816 && beat % 2 == 0)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;
					forceBump += 0.1;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (beat >= 832 && beat < 896)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;
					forceBump += 0.1;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.2;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (beat >= 897 && beat < 928 && beat % 2 == 0)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;
					forceBump += 0.150;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.1;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (beat >= 928 && beat < 968)
				{
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;
					forceBump += 0.1;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.1;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
			case "Deceived":
				if (beat > 64 && beat < 128 && beat % 4 == 0)
				{
					PlayState.camGame.zoom += 0.05;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.03;
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.1;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
				}
				if (beat >= 200 && beat < 263 && curBeat % 4 == 0)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.3;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2, {ease: FlxEase.sineOut});
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.03;
				}
				if (beat >= 263 && beat < 519 && curBeat % 2 == 0)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2, {ease: FlxEase.sineOut});
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;
				}
				if (beat >= 523 && beat < 652 && curBeat % 2 == 0)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2, {ease: FlxEase.sineOut});
					PlayState.camGame.zoom += 0.1;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;
				}
				if (beat >= 716 && beat < 972 && beat % 2 == 0)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2, {ease: FlxEase.sineOut});
					PlayState.camGame.zoom += 0.06;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.03;
				}
				if (beat >= 972 && beat < 1004 && beat % 4 == 0)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2, {ease: FlxEase.sineOut});
					PlayState.camGame.zoom += 0.06;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.03;
				}
			case "Lured":
				if (beat >= 64 && beat <= 127)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.2;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);

					if (PlayState.camGame.zoom > PlayState.defaultCamZoom - 0.35)
						PlayState.camGame.zoom += 0.06;
					else
						PlayState.camGame.zoom += 0.01;

					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.03;
				}
				if (beat >= 132 && beat <= 187)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.2;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);

					if (PlayState.camGame.zoom > PlayState.defaultCamZoom - 0.35)
						PlayState.camGame.zoom += 0.06;
					else
						PlayState.camGame.zoom += 0.01;

					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.03;
				}
				if (beat >= 192 && beat <= 287)
				{
					if (beat % 2 == 0)
					{
						FlxTweenPlayState.cancelTweensOf(whiteFlash);
						whiteFlash.alpha = 0.2;
						FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);

						if (PlayState.camGame.zoom > PlayState.defaultCamZoom - 0.35)
							PlayState.camGame.zoom += 0.06;
						else
							PlayState.camGame.zoom += 0.01;

						for (hud in PlayState.instance.allUIs)
							hud.zoom += 0.03;
					}
				}
				if (beat >= 320 && beat <= 383)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.2;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);

					if (PlayState.camGame.zoom > PlayState.defaultCamZoom - 0.35)
						PlayState.camGame.zoom += 0.08;
					else
						PlayState.camGame.zoom += 0.01;

					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.06;
				}
				if (beat >= 388 && beat <= 443)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.2;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);

					if (PlayState.camGame.zoom > PlayState.defaultCamZoom - 0.35)
						PlayState.camGame.zoom += 0.08;
					else
						PlayState.camGame.zoom += 0.01;

					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.06;
				}
				if (beat >= 448 && beat <= 479)
				{
					if (beat % 2 == 0)
					{
						FlxTweenPlayState.cancelTweensOf(whiteFlash);
						whiteFlash.alpha = 0.2;
						FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);

						if (PlayState.camGame.zoom > PlayState.defaultCamZoom - 0.35)
							PlayState.camGame.zoom += 0.06;
						else
							PlayState.camGame.zoom += 0.01;

						for (hud in PlayState.instance.allUIs)
							hud.zoom += 0.03;
					}
				}
				if (beat >= 552 && beat <= 592)
				{
					if (beat % 2 == 0)
					{
						FlxTweenPlayState.cancelTweensOf(whiteFlash);
						whiteFlash.alpha = 0.2;
						FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);

						if (PlayState.camGame.zoom > PlayState.defaultCamZoom - 0.35)
							PlayState.camGame.zoom += 0.06;
						else
							PlayState.camGame.zoom += 0.01;

						for (hud in PlayState.instance.allUIs)
							hud.zoom += 0.03;
					}
				}
				if (beat >= 720 && beat <= 784)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.2;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);

					if (PlayState.camGame.zoom > PlayState.defaultCamZoom - 0.35)
						PlayState.camGame.zoom += 0.08;
					else
						PlayState.camGame.zoom += 0.01;

					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.06;
				}
				if (beat >= 788 && beat <= 816)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.2;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);

					if (PlayState.camGame.zoom > PlayState.defaultCamZoom - 0.35)
						PlayState.camGame.zoom += 0.08;
					else
						PlayState.camGame.zoom += 0.01;

					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.06;
				}
				if (beat >= 848 && beat <= 880)
				{
					if (beat % 2 == 0)
					{
						FlxTweenPlayState.cancelTweensOf(whiteFlash);
						whiteFlash.alpha = 0.2;
						FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);

						if (PlayState.camGame.zoom > PlayState.defaultCamZoom - 0.35)
							PlayState.camGame.zoom += 0.06;
						else
							PlayState.camGame.zoom += 0.01;

						for (hud in PlayState.instance.allUIs)
							hud.zoom += 0.03;
					}
				}
			case "Followed":
				if (beat >= 32 && beat <= 63)
				{
					PlayState.camGame.zoom += 0.01;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.02;
				}
				if (beat >= 64 && beat <= 96)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.3;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					PlayState.camGame.zoom += 0.09;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.06;
				}
				if (beat >= 104 && beat <= 191)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.3;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					PlayState.camGame.zoom += 0.09;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.06;
				}
				if (beat >= 192 && beat <= 224)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.4;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					PlayState.camGame.zoom += 0.15;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.07;
				}
				if (beat >= 232 && beat <= 287)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.4;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					PlayState.camGame.zoom += 0.15;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.07;
				}
				if (beat >= 320 && beat <= 383)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.4;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					PlayState.camGame.zoom += 0.15;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.07;
				}

			case "Expedited":
				phillyGlowGradient.bop();
				var particlesNum:Int = FlxG.random.int(5, 9);
				var width:Float = (5000 / particlesNum);
				for (j in 0...3)
				{
					for (i in 0...particlesNum)
					{
						if (phillyGlowParticles.alpha > 0)
						{
							var particle:PhillyGlowParticle = new PhillyGlowParticle(-380
								+ width * i
								+ FlxG.random.float(-width / 5, width / 5),
								phillyGlowGradient.originalY
								+ 200
								+ (FlxG.random.float(0, 125) + j * 40), FlxColor.WHITE);
							particle.ID = 1;
							phillyGlowParticles.add(particle);
						}
					}
				}

				if (beat >= 32 && beat < 96)
				{
					if (beat % 2 == 0)
					{
						PlayState.camGame.zoom += 0.03;
						for (hud in PlayState.instance.allUIs)
							hud.zoom += 0.035;
					}
				}
				if (beat >= 129 && beat < 174)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					PlayState.camGame.zoom += 0.03;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.035;
				}
				if (beat >= 177 && beat < 192)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					PlayState.camGame.zoom += 0.03;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.035;
				}
				if (beat >= 196 && beat < 256)
				{
					if (beat % 2 == 0)
					{
						PlayState.camGame.zoom += 0.03;
						for (hud in PlayState.instance.allUIs)
							hud.zoom += 0.035;
					}
				}
				if (beat >= 260 && beat < 290)
				{
					PlayState.camGame.zoom += 0.03;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.035;
				}
				if (beat >= 292 && beat < 355)
				{
					if (beat % 2 == 0)
					{
						PlayState.camGame.zoom += 0.03;
						for (hud in PlayState.instance.allUIs)
							hud.zoom += 0.035;
					}
				}
				if (beat >= 362 && beat < 394)
				{
					if (beat % 2 == 0)
					{
						PlayState.camGame.zoom += 0.03;
						for (hud in PlayState.instance.allUIs)
							hud.zoom += 0.035;
					}
				}
				/*
				if (beat >= 96 && beat <= 159)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					PlayState.camGame.zoom += 0.03;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.035;
				}
				if (beat >= 164 && beat <= 188)
				{
					if (beat % 2 == 0)
					{
						PlayState.camGame.zoom += 0.03;
						for (hud in PlayState.instance.allUIs)
							hud.zoom += 0.035;
					}
				}
				if (beat >= 192 && beat <= 221)
				{
					if (beat % 2 == 0)
					{
						PlayState.camGame.zoom += 0.03;
						for (hud in PlayState.instance.allUIs)
							hud.zoom += 0.035;
					}
				}
				if (beat >= 224 && beat <= 287)
				{
					FlxTweenPlayState.cancelTweensOf(whiteFlash);
					whiteFlash.alpha = 0.15;
					FlxTweenPlayState.tween(whiteFlash, {alpha: 0}, 0.2);
					PlayState.camGame.zoom += 0.055;
					for (hud in PlayState.instance.allUIs)
					{
						hud.angle = -hud.angle;
						hud.zoom += 0.05;
					}
					PlayState.camGame.angle = -PlayState.camGame.angle;
				}
				if (beat >= 288 && beat <= 315)
				{
					if (beat % 2 == 0)
					{
						PlayState.camGame.zoom += 0.03;
						for (hud in PlayState.instance.allUIs)
							hud.zoom += 0.035;
					}
				}
				*/
            case "Traumatized":
				phillyGlowGradient.bop();
                phillyGlowGradient2.bop();
                if (beat >= 32 && beat <= 63)
                {
					if (beat % 2 == 0)
					{
						PlayState.camGame.zoom += 0.05;
						for (hud in PlayState.instance.allUIs)
							hud.zoom += 0.035;
                    }
                }
				if (beat >= 64 && beat <= 127)
				{
					FlxTweenPlayState.cancelTweensOf(pinkOverlay);
					pinkOverlay.alpha = 0.2;
					FlxTweenPlayState.tween(pinkOverlay, {alpha: 0.05}, 0.3);

					PlayState.camGame.zoom += 0.13;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.04;
				}
				if (beat >= 128 && beat <= 159)
				{
					traumatizedColorSwitch();
					PlayState.camGame.zoom += 0.13;
				}
				if (beat >= 160 && beat <= 255)
				{
					FlxTweenPlayState.cancelTweensOf(pinkOverlay);
					pinkOverlay.alpha = 0.2;
					FlxTweenPlayState.tween(pinkOverlay, {alpha: 0.05}, 0.3);

					PlayState.camGame.zoom += 0.13;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.04;
				}
				if (beat >= 288 && beat <= 415)
				{
					FlxTweenPlayState.cancelTweensOf(pinkOverlay);
					pinkOverlay.alpha = 0.2;
					FlxTweenPlayState.tween(pinkOverlay, {alpha: 0.05}, 0.3);

					PlayState.camGame.zoom += 0.13;
					for (hud in PlayState.instance.allUIs)
						hud.zoom += 0.04;
				}
        }
    }

	public function onNoteHit(isOpponent:Bool)
	{
		switch (songName)
		{
			case "Remembered":
				if (step >= 1280 && step < 2304)
				{
					if (isOpponent)
					{
						for (hud in PlayState.instance.allUIs)
							hud.shake(0.0012, 0.2);
						PlayState.camGame.shake(0.0018, 0.2);
					}
				}
			case "Deceived":
				if (step > 1056 && step < 2608)
				{
					if (isOpponent)
					{
						for (hud in PlayState.instance.allUIs)
							hud.shake(0.0021, 0.2);
						PlayState.camGame.shake(0.0035, 0.2);
						if (step > 1055 && step < 1568)
							ShaderObject.setValue("chrom.amount.value", [FlxG.random.float(0.0020, 0.0060)]);
						if (step > 2095)
							ShaderObject.setValue("chrom.amount.value", [FlxG.random.float(0.0020, 0.0060)]);
					}
				}
				if (step >= 2864)
				{
					if (isOpponent)
					{
						for (hud in PlayState.instance.allUIs)
							hud.shake(0.0021, 0.2);
						PlayState.camGame.shake(0.0035, 0.2);
					}
				}
			case "Lured":
				if (isOpponent)
					FlxG.cameras.shake(0.0021, 0.2);
			case "Followed":
				if (isOpponent)
				{
					if (step >= 768 && step <= 896)
					{
						glitchTimer.cancel();
						ShaderObject.setValue("glitch.isDad.value", [true]);
						glitchTimer.start(0.2, function(e:FlxTimer)
						{
							ShaderObject.setValue("glitch.isDad.value", [false]);
						});
						FlxG.cameras.shake(0.001, 0.2);
					}
					if (step >= 928 && step <= 1024)
					{
						glitchTimer.cancel();
						ShaderObject.setValue("glitch.isDad.value", [true]);
						glitchTimer.start(0.2, function(e:FlxTimer)
						{
							ShaderObject.setValue("glitch.isDad.value", [false]);
						});
						FlxG.cameras.shake(0.001, 0.2);
					}
					if (step >= 1280)
					{
						glitchTimer.cancel();
						ShaderObject.setValue("glitch.isDad.value", [true]);
						glitchTimer.start(0.2, function(e:FlxTimer)
						{
							ShaderObject.setValue("glitch.isDad.value", [false]);
						});
						FlxG.cameras.shake(0.001, 0.2);
					}
				}
		}
	}

    public function onUpdate(elapsed:Float)
    {
        switch (songName)
        {
			case "Awakened":
				if (PlayState.focus == DAD)
					PlayState.forceZoom[0] = 0.3;
				else if (PlayState.focus == BF)
					PlayState.forceZoom[0] = 0;
			case "Befriended":
				vignette.scale.set(1 / PlayState.camGame.zoom, 1 / PlayState.camGame.zoom);
				vignette.screenCenter();

				if (step >= 2416 && step < 2928)
				{
					if (PlayState.focus == DAD)
					{
						PlayState.defaultCamZoom = 1;
						PlayState.boyfriend.alpha = FlxMath.lerp(PlayState.boyfriend.alpha, 0, elapsed / (1 / 60) * 0.1);
					}
					else if (PlayState.focus == BF)
					{
						PlayState.defaultCamZoom = 0.8;
						PlayState.boyfriend.alpha = FlxMath.lerp(PlayState.boyfriend.alpha, 1, elapsed / (1 / 60) * 0.1);
					}
				}
			case "Remembered":
				forceBump = FlxMath.lerp(forceBump, 1, elapsed / (1 / 60) * 0.05);
				rememberedBars.scale.set(1 / PlayState.camGame.zoom * forceBump, 1 / PlayState.camGame.zoom * forceBump);

				flashbacks.scale.set(1 / PlayState.camGame.zoom, 1 / PlayState.camGame.zoom);
			case "Deceived":
				redVignette.scale.set(1 / PlayState.camGame.zoom, 1 / PlayState.camGame.zoom);
				if (step >= 800 && step < 2608)
				{
					if (PlayState.focus == DAD)
						PlayState.forceZoom[0] = 0.1;
					else if (PlayState.focus == BF)
						PlayState.forceZoom[0] = 0.28;
				}
				if (step >= 3888 && step < 4144)
				{
					if (PlayState.focus == DAD)
						PlayState.forceZoom[0] = 0.1;
					else if (PlayState.focus == BF)
						PlayState.forceZoom[0] = 0.28;
				}
			case "Pursued":
				forceBump = FlxMath.lerp(forceBump, 1, elapsed / (1 / 60) * 0.05);
				pursuedBars.scale.set(1 / PlayState.camGame.zoom, 1 / PlayState.camGame.zoom * forceBump);

				redVignette.scale.set(1 / PlayState.camGame.zoom, 1 / PlayState.camGame.zoom);

				if (step < 1872)
				{
					if (PlayState.focus == DAD)
					{
						PlayState.instance.camDisplaceExtend = 6;
						PlayState.forceZoom[0] = 1;
					}
					else if (PlayState.focus == BF)
					{
						PlayState.instance.camDisplaceExtend = 12;
						PlayState.forceZoom[0] = 0;
					}
				}
				
			case "Lured":
				if (step >= 256 && step <= 1919)
				{
					if (PlayState.focus == BF)
					{
						Init.trueSettings['No Camera Note Movement'] = false;
						PlayState.defaultCamZoom = 0.52;
					}
					else if (PlayState.focus == DAD)
					{
						Init.trueSettings['No Camera Note Movement'] = true;
						PlayState.defaultCamZoom = 0.82;
					}
				}
				if (step >= 2880 && step <= 3375)
				{
					if (PlayState.focus == BF)
					{
						Init.trueSettings['No Camera Note Movement'] = false;
						PlayState.defaultCamZoom = 0.52;
					}
					else if (PlayState.focus == DAD)
					{
						Init.trueSettings['No Camera Note Movement'] = true;
						PlayState.defaultCamZoom = 0.82;
					}
				}
				if (step >= 3392 && step < 3520)
				{
					if (PlayState.focus == BF)
					{
						Init.trueSettings['No Camera Note Movement'] = false;
						PlayState.defaultCamZoom = 0.52;
					}
					else if (PlayState.focus == DAD)
					{
						Init.trueSettings['No Camera Note Movement'] = true;
						PlayState.defaultCamZoom = 0.82;
					}
				}
			case "Followed":
				vignette.scale.set(1 / (2559 / FlxG.width * PlayState.camGame.zoom),
						1 / (1399 / FlxG.height * PlayState.camGame.zoom));
				vignette.updateHitbox();
				vignette.screenCenter();

			case "Expedited":
				if (phillyGlowParticles != null)
				{
					var i:Int = phillyGlowParticles.members.length - 1;
					while (i > 0)
					{
						var particle = phillyGlowParticles.members[i];
						if (particle.alpha < 0 || particle.scale.x <= 0 || particle.scale.y <= 0)
						{
							particle.kill();
							phillyGlowParticles.remove(particle, true);
							particle.destroy();
						}
						--i;
					}
				}
				

			case "Traumatized":
				edgybar.scale.set(1 / PlayState.camGame.zoom + 2, 1 / PlayState.camGame.zoom);
				edgybar2.scale.set(1 / PlayState.camGame.zoom + 2, 1 / PlayState.camGame.zoom);
				edgybar.updateHitbox();
				edgybar2.updateHitbox();

				edgybar.setPosition(PlayState.camGame.viewMarginRight - edgybar.width + 10, 720 - PlayState.camGame.viewMarginBottom);
				edgybar2.setPosition(PlayState.camGame.viewMarginRight - edgybar2.width + 10, PlayState.camGame.viewMarginBottom - edgybar2.height);

				phillyGlowGradient.x = PlayState.camGame.viewMarginRight - phillyGlowGradient.width;
				phillyGlowGradient2.x = PlayState.camGame.viewMarginRight - phillyGlowGradient2.width;

				phillyGlowGradient.originalY = 720 - PlayState.camGame.viewMarginBottom - 350;
				phillyGlowGradient2.originalY = PlayState.camGame.viewMarginBottom - phillyGlowGradient2.originalHeight + 350;
        }
    }

	public function onSection(section:Int)
	{
		switch (songName)
		{
			case "Befriended":
				if (section >= 34 && section < 49)
				{
					PlayState.camGame.zoom += 0.085;
					for (i in PlayState.instance.allUIs)
						i.zoom += 0.04;

					ShaderObject.setValue("bloom.intensity.value", [0.7]);
					ShaderObject.setValue("chrom.amount.value", [0.01]);
				}
		}
	}

	public function onPause()
	{
		switch (songName)
		{
			case "Befriended":
				if (beginningIntro != null)
					beginningIntro.bitmap.pause();
		}
	}

	public function onResume()
	{
		switch (songName)
		{
			case "Befriended":
				if (beginningIntro != null)
					beginningIntro.bitmap.resume();
		}
	}

	function initLyrics(?word:String, ?axis:Array<Float>, ?color:Int, ?size:Int, ?alignment:FlxTextAlign, ?worldSpace:Bool = false)
	{
		var text = new FlxText(axis[0], axis[1], 0, word, size);
		text.color = Std.int(color);
		if (worldSpace)
			text.camera = PlayState.camGame;
		else
			text.camera = PlayState.camText;
		text.font = Paths.font("vcr.ttf");
		text.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xff000000, 2);
		text.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
		text.scrollFactor.set();
		text.alignment = alignment;
		textMaps.set(word, text);
	}

	function traumatizedColorSwitch()
	{
		var colors = [0xff1542B7, 0xff0A4447, 0xff651038, 0xff391C54];
		if ((!colors.contains(PlayState.dadOpponent.color)
			&& !colors.contains(PlayState.boyfriend.color)
			&& !colors.contains(PlayState.instance.stageBuild.background.members[0].color))
			|| (PlayState.dadOpponent.color == 0xff391C54
				&& PlayState.boyfriend.color == 0xff391C54
				&& PlayState.instance.stageBuild.background.members[0].color == 0xff391C54))
		{
			PlayState.instance.stageBuild.background.members[0].color = colors[0];
			PlayState.dadOpponent.color = colors[0];
			PlayState.boyfriend.color = colors[0];
		}
		else
		{
			PlayState.instance.stageBuild.background.members[0].color = colors[colors.indexOf(PlayState.instance.stageBuild.background.members[0].color) + 1];
			PlayState.dadOpponent.color = colors[colors.indexOf(PlayState.dadOpponent.color) + 1];
			PlayState.boyfriend.color = colors[colors.indexOf(PlayState.boyfriend.color) + 1];
		}
	}

    function add(Object:FlxBasic, ?layer:Null<Int>)
    {
        var layerID:Int;
        if (layer != null)
            layerID = layer;
        else
            layerID = PlayState.instance.members.length;

        PlayState.instance.insert(layerID, Object);
    }

	function remove(Obj:FlxBasic)
	{
		var index = PlayState.instance.members.indexOf(Obj);
		PlayState.instance.members[index] = null;
	}
}

/*
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&&&&&&@@@@@@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&@@@@@@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&@@@@@&&&@@@@@@@@@@@&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@@&&&@@@@@@@@@@&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&@@@@@@@&&&&&&&&&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&&&&@@@@@@@@@@&&&&&&&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&&@@@@&&&&&&&&&&&&&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&&@@@&&&&&&&&&&&&@&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&&@&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&########&&&&&&&&&&&&&&&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&###########################&&&&&&&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&#BBBBBBBBBBBBBBBBBBBB###########&&&&&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&BBBGGGGGGGGGGGBBBBBBBBBBBBBB#######&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&BGGGGGGGBGGGGGGGBBBBBBBBBBBBB#######
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#BBGGGBB#BGGBBBGGGGGGGGGGGGBBBBB####
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@####B#BBBBBBBBBBBBBGGGGGGGBBGGBBBBB
	@@&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&BBB#BBBBBBBBBBBBBBBBBBBBBBBGGGBBBB
	&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&BB#BBBBBBGGGGGBBBBBBBBBBBBBBBBBBBB
	&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&@@@@@@@@@@@@@@@@@#BBGPGGGPPGGGGGGGGGGGGGBBBBBBBBBBB
	&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&#GY5B#&&@@@@@@@@@@@@@@@@#PPPPPPPPPPPPPPPPPPPGGGGGGGBBBBBBB
	&&@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&#PJJGB&&@@@@@@@@@@@@@@@@@&#BGPPP55PPPPPPPPPPPPGGGGGGGBBBBB
	&&&@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@@@@@@@&##&@&&@@@@@@@@@@@@@@@@@@@@@&BG55PPPPPPPPPPPPPPPPGGGGBBBB
	&&&&@@@@@@@@@@@@@@@@&&#GPB#&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&B55555555555PPPPPPPPGGGGGB
	&&&&&&&&@@@@@@@@@@@@&#BYJYG#&&@@@@@@@@@@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@BPPP5PPPPPPPPPPPPPPPPGGGG
	&&&&&&&@@@@@@@@@@@@@@@&#B#&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#PPPPPPPPPPPPPPPPPPPPPPGG
	@@@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@@@@@@@@#PPPPPPPPPPPPPPPPPPPPPPGG
	@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@&###&@@@@@@@@@@@@@@@@@@@&&&@@@@@@@@@@&BGPPPPPPPPPPPPPPPPPPPPPPP
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&@@@@@@@@@@@@@@@@@@@&@@@@@@&&@@@@@#BBGBP555PP5PPPPPPPPPPPPPP
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@&#@@@@@@#GPGP555555PPPPPGGGPPPPPP
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@&#&@@&@@&PPPPPPPPPPPPPPGBGGGPPGGG
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@@&&&&&&&&@@#PPPPPPPPPPPPPPPGGGGGGGGG
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@&&&&@@@&&&&#&#&@@#GGGGGGGGPPPPPPPGGGGGGGGG
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&@@@@@@@&@@@@@&&@@@@&&&@&##@@@BGGGGGGGGGGGGGGGGGGGGGGGG
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@@@&&&&&@@@@@@&&&&@@@@@@@&&&&&@&##&@@#GGGGGGGGGGGGGGGGGGGGGGGG
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&@@@&&&&##&@&@&&&&@@&&@@&@@@&&@@&##@@@#BGGGGGGGGGGGGGGGGGGGGGG
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&@@&&#&&##&&&@@&&&&##&@&@@@&&&&&###@@@&#BBBBBBBBBBBBGGGGGGGBB
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&##B#@&&&&&&@&&&&&&@&#&@&B#&@@@&@@&&@###B&@@@&##BB####BBBBBBBBBBBB
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&##&&&&&&@&&&&&@##@&&#@@&B&@&&&@@&&&&&&B#@@@@&&##################
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@@&&&&&&&&&&&@&#&&&&&&@&&@@&@@@@&&@@&&#&&@@@@@&&&&&&&&&########
	@@@@@@@@@@@@@@&&@@@@@@@@@@@&&@@@@@@&&&@@&&&&&&&&@@@&&&&&&&&@&&&&&@@@@@@@@&&##&@@@@@@@@@@@@@&&&&&&&&&
	@@@@@@@@@@@@@@@&@@@@@@@@@@@@#&@&#&@@&#&@&#&@@&&#&@@&&&&@@@@@@&#&&@@@@@@&@&#B#&&@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@&@@&&@&&@@@@@@@&&@@##@@&#&@&#&&@&&&&&&@&&&@@@&&@&#&&@@&@@@@@#B##&@&@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@&&&&&@@@&&@@@@@&&@@&#&@&##&&&&&&@@@&&@@@@&&@@&&@&&&&@@@@@&&&@BB#&@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@&&&&@@@&@@@@@@&@&@&&@@&&&&&@@@@@@&&@@@@&&@@@&@&&@@@@&@@@&B&&B#&&@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@&&@@@@@@@@@@@&&@@@&&@@@&&&@@&&@@@@&&@@@@&@@@@&&&@@@@&@##@BB@##&@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@&&&@@@@@@@@@@@@&&&@&&@@@&&@@&&@@@@@@@@@@@@@@&G##&@@@#&&B#&B###&@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@&&&@@@@@@@@@@@@&#&&&&&&@@&&@@@@@@&&@@@@@@&&&BGP#&@@@&B&&#&##&&@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@&&@&@@@@@@@@@@&B###&&&@@@@@@@@&&@&&@@@&&&&&G5B##@@@&#B&##&&&@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@&&&@@@@@@@@@@@@@###B#@&@@@@@&&&&&&&@@@&&&GG#PG&#&@@&&#&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@&&@&@@@@@@@@@@@&#&G#B&@@@&&&&@&&&&&&@B#@#5B&###B&&###&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@&&&@&&@@@@@@@@@&&&#P###@&#&&&&&&&B&@B5#@BB&&#&&@@&##&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@&&&&&#@@&&@@&&&&&&&B#GP&#P#@&P#@@PG@@GG&&##&###&@@##&&&@&&@&#&@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@&&&#&@&#@@#&@#&&&&&#P#&5G&&5G&@BP#@&#####&@@&B&@&#&@&&&@@&#&@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@&&&#&@#&@&#@&#&#&&&#&&BB&@#B&@&##&#BB#&#B@@@##@@&&@@@@@@@@@@@@@@@&@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@&#&@&#&@&&&&&&&##B&&##&&&##&#BBGG###&&B#@@&#&@&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@&&&@&&@@&@&&&&#&#&&#BB##BP#&#BBB#@@@@#B&@@&&&&&@@@@@@@@@@@@@@@@@&&@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@&&&&&#&&&&B@&&BB&&&&&B&@@@@#&@@@&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&#&@@@#&@@@B#@@@@##&@@@&&@&&&@@@@@@@@@@@@@&&&&@@@@@@@&&@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&@@#&@@@##&@@@&#&@@&@&@@@@@@@@@@@@@&&@@@&##&&&&&&&&&&@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@&&&@@@&&@@@@&&@@@@@@@@@@@@@@@@@@&@@@&####&#BB#&@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@&&&@@@@@@@@@@@@@@@@@@&@@&@@&@@@@&@@&&&&@@@@@@@@@@@@@@@@@@&&@##&&#B&@@@&&@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&##&@&#&&&&@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&@@&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@&&@@&#&&&&@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@&&&##&@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&#&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&##&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@@&&@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#&@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@@@&&
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
*/
