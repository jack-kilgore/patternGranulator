(
w = Window.new("I catch keystrokes");
w.view.keyDownAction = { arg view, char, modifiers, unicode, keycode;  [char, keycode].postln; };
w.front;
)
~key = 18;
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\fm1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0,
	modfreq=10, carrfreq = 100, moddepth = 1.0 |
	var f, snd, trig, mod, sig, amp2, env, envg, siga;
	f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	snd = FSinOsc.ar(freq);
	trig =  Blip.kr(trigs,1,80);
	mod = SinOsc.ar(carrfreq + (moddepth*SinOsc.ar(modfreq)));
	/*sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range));*/

	/*w = Window.new("I catch keystrokes");
	w.view.keyDownAction = { arg view, char, modifiers, unicode, keycode;
		 ~key = keycode;};
	~key.postln;
	if(,{sig=PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)*MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value));"working".postln;},{"here".postln;~key.postln;});
	w.front;
	w.alwaysOnTop;*/
	sig=PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)*MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value));

	amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	env = Env([0.0, amp*0.9,0.7,amp,amp*0.6,0], [sustain*0.1,sustain*0.2,sustain*0.01,sustain*0.59,sustain*0.1], \sin);
	envg = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);

	//var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	siga = HPF.ar(Pan2.ar(sig*envg,pan),25);
	//siga = HPF.ar(siga, 400);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);

(
~modest= Array.new;
~folder6 = PathName.new("/Users/jkilgore/Music/misc-samples/modest/");
(
~folder6.entries.do({
	arg path;
	~modest = ~modest.add(Buffer.read(s,path.fullPath));
})
));

(
 ~mhm = Pbindef(\1,
	\instrument,\fm1,
	\sustain,Pn(Pgeom(0.5,1.3,6),inf),
	\dur,Pn(Pgeom(0.025,1.2,2),inf),
	\bufnum, ~modest[6], // transition from magnet3 to improv_stereo2 is god tier
	\trigs, 0.001,
	\amp, 4.9,
	\rate, Pn(Pgeom(0.218,1.17,16),inf),
	\samp_rand_rate, 100.1,
	\samp_rand_range,1.86,
).play;
)
(
~carr = 20;
~mod = 100;
~depth = 1;
w = Window("Audio Microscope", Rect(
	Window.screenBounds.width/1.38,
	Window.screenBounds.height/1.9,
	500,
	400
))
.front
.alwaysOnTop_(true);

~s0 = Slider(w,Rect(20,20,150,30))
.background_(Color(88/255,127/255,188/255))
.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,60,4000).postln;
	~carr = cf;
});
~s1 = Slider(w,Rect(20,50,150,30))
.background_(Color(88/255,127/255,188/255))
.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,1,20000).postln;
	~mod = cf;
});
~s2 = Slider(w,Rect(20,80,150,30))
.background_(Color(88/255,127/255,188/255))
.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.01,3000).postln;
	~depth = cf;
});
)