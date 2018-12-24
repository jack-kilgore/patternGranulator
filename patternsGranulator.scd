

(

( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0|
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		*MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)
	);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(sig*env,pan),25));
},\ir!5).add;
);

(//wider,quasi-gauss env, w/hold time in middle
SynthDef(\gabWide1,{|out, amp=0.01, freq=440, sustain=0.01, pan, width=0.5, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0|
	var holdT = sustain*width;
	var fadeT = width*sustain*0.5;
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		*MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)
	);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.4;
	var env = EnvGen.ar(
		Env([0,1,1,0],[fadeT,holdT,fadeT],\sin),
		levelScale:amp2,
		doneAction:2);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(sig*env,pan),25));
},\ir!5).add;
);

(//percussive envelope
SynthDef(\percSin1,{|out,amp=0.1, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0|
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		*MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)
	);
	var amp2 = amp * AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(
		Env.perc(0.1,0.9,amp2),
		timeScale: sustain,
		doneAction:2
	);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(sig*env,pan),25));
},\ir!5).add;
);

(//reverse percussive env
SynthDef(\rpercSin1,{|out, amp=0.1, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2|
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*MouseY.kr(0.9,1.1)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)*MouseX.kr(0, BufFrames.kr(bufnum)));
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(
		Env.perc(0.9, 0.1,amp2),
		timeScale:sustain,
		doneAction:2
	);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(sig*env,pan),25));
},\ir!5).add;
);

(//expo decay envelope
SynthDef(\expodec1,{|out, freq=440, amp=0.3, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2|
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)*MouseX.kr(0, BufFrames.kr(bufnum)));
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = XLine.ar(amp2,amp2*0.001,sustain,doneAction:2);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(sig*env,pan),25));
},\ir!5).add;//5 refers to num arg
);


(//reverse expo decay envelope
SynthDef(\rexpodec1,{|out, freq=440, amp=0.3, sustain=0.01, pan,
	bufnum, trigs=2000, rate= 1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0|
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		*MouseX.kr((mouseXStart)*(BufFrames.kr(bufnum)),
			(((BufFrames.kr(bufnum))-((mouseXStart)*(BufFrames.kr(bufnum))))
				*mouseXScale)+((mouseXStart)*(BufFrames.kr(bufnum))))
	);
	var snd = FSinOsc.ar(freq);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = XLine.ar(amp2*0.001,amp2,sustain,doneAction:2)
	*(AmpComp.ir(freq)*0.5);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(sig*env,pan,amp.lag(0.1)),25));

},\ir!5).add;//5 refers to num arg
);


(//expo decay envelope no samples
SynthDef(\expodec,{|out, freq=440, amp=0.3, sustain=0.01, pan|
	var snd = SinOsc.ar(freq);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = XLine.ar(amp2,amp2*0.001,sustain,doneAction:2);
	OffsetOut.ar(out,Pan2.ar(snd*env,pan));
},\ir!5).add;//5 refers to num arg
);

(//reverse expo decay envelope
SynthDef(\rexpodec,{|out, freq=440, amp=0.3, sustain=0.01, pan|
	var snd = SinOsc.ar(freq);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = XLine.ar(amp2*0.001,amp2,sustain,doneAction:2)
	*(AmpComp.ir(freq)*0.5);
	OffsetOut.ar(out,Pan2.ar(snd*env,pan));

},\ir!5).add;//5 refers to num arg
);

(//percussive envelope
SynthDef(\percSin,{|out,amp=0.1, freq=440, sustain=0.01, pan|
	var snd = SinOsc.ar(freq);
	var amp2 = amp * AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(
		Env.perc(0.1,0.9,amp2),
		timeScale: sustain,
		doneAction:2
	);
	OffsetOut.ar(out,Pan2.ar(snd*env,pan));
},\ir!5).add;
);
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gaborGen1,{|out, amp=0.01, freq=440, sustain=0.01, pan|
	var snd = SinOsc.ar(freq);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(snd*env,pan),25));
},\ir!5).add;
);
)

s.reboot;

/////////////////////////////////////////////
////GUI
(
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
	cf = obj.value.linexp(0,1,0.1,4000).postln;
	~test = cf;
});
)
Window.closeAll;


////////////////////////////////////////
///Player

(
~mag= Array.new;
~folder61 = PathName.new("C:/Users/Jackalaka/Desktop/misc samples/10_28_18-magents");
(
~folder61.entries.do({

	arg path;
	~mag = ~mag.add(Buffer.read(s,path.fullPath));
})
))

~test = 1;
(
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\sustain,Pn(Pgeom(0.1,1.2,12),inf),
	\dur,Pn(Pgeom(0.02,1.2,3),inf),
	\bufnum, Pn(Prand([~mag[1],~mag[0]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.9,
	\rate, Pn(Pfunc({~test})),
	\samp_rand_rate, 100,
	\samp_rand_range,1,
	\mouseXStart, 0.1,
	\mouseXScale, 1
).play;
)
