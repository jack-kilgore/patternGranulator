( //a gabor(approx. gaussian-shaped) grain
SynthDef(\fm1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0,
	modfreq=10, carrfreq = 100, moddepth = 1.0 |
	var fBLoopOut,fBLoopIn,processing;
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var mod = SinOsc.ar(carrfreq + (moddepth*SinOsc.ar(modfreq)));
	var sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		*MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*mod
	);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = Env([0.0, amp*0.9,0.7,amp,amp*0.6,0], [sustain*0.1,sustain*0.2,sustain*0.01,sustain*0.59,sustain*0.1], \sin);
	var envg = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);

	//var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*envg*mod,pan),25);
	siga = BPF.ar(siga,Rand(100,5020),0.1);
	//siga = HPF.ar(siga, 400);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);
(
~mag= Array.new;
~folder65 = PathName.new("/Users/jkilgore/Music/misc-samples/10_28_18-magents");
(
~folder65.entries.do({

	arg path;
	~mag = ~mag.add(Buffer.read(s,path.fullPath));
})
))

(
 ~mhm = Pbindef(\1,
	\instrument,\fm1,
	\sustain,0.045,
	\dur,1/Pfunc{~depth},
	\bufnum, ~mag[3], // transition from magnet3 to improv_stereo2 is god tier
	\trigs, 0.001,
	\amp, 10.9,
	\rate, Pn(Pgeom(0.9,1.01,60)),
	\samp_rand_rate, 1.01,
	\samp_rand_range,4.1,
	\modfreq, Pfunc{~mod},
	\carrfreq, Pfunc{~carr},
	\moddepth, Pfunc{~depth},
	\pan, Pwhite(-1,1)
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
	cf = obj.value.linexp(0,1,1,10000).postln;
	~depth = cf;
});
)
