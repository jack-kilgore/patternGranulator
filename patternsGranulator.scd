

(


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
~test = 1;



//x'd out BPF for now, need to do more experiments in separate file
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
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
	//var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);
)





////////////////////////////////////////
///Player

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
~chimes= Array.new;
~folder739 = PathName.new("/Users/jkilgore/Music/misc-samples/wind_chimes");
(
~folder739.entries.do({
	arg path;
	~chimes = ~chimes.add( Buffer.read(s,path.fullPath));
})
));
s.reboot;


//Pn(Pfunc({~test}))
(
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pn(Pgeom(0.2,1.2,1),inf),
	\dur,Pn(Pgeom(1/10,1.2,1),inf),
	\bufnum, Pn(Prand([~chimes[0]],inf),inf),
	\trigs, 0.001,
	\amp, 1.1,
	\rate, 1,
	\samp_rand_rate, 100,
	\samp_rand_range,1.01,
	\mouseXStart, 0.1,
	\mouseXScale, 1,
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)

(
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\sustain,0.02,
	\dur,0.03,
	\bufnum, Pn(Prand([~mag[1]],inf),inf),
	\trigs, 0.001,
	\amp, 20.1,
	\rate, 0.7,
	\samp_rand_rate, 100,
	\samp_rand_range,2.6,
	\mouseXStart, 0,
	\mouseXScale, 1,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)


//slow and big grains SOUND GOOD W wind chimes
(
 ~slow = Pbindef(\1,
	\instrument,\gabor1,
	\type, \note,
	\dur,1/0.3,
	\tempo, 1,   // tempo is the num synths running from pattern * number_inputted
	\stretch, Pn(Pwhite(0.1,1.5)),   //expands/contracts durations //scalar for durations pretty much
	\sustain,10,
	\bufnum, Pn(Prand([~chimes[0]],inf),inf),
	\trigs, 0.001,
	\amp, 1.1,
	\rate, 1,
	\samp_rand_rate, 100,
	\samp_rand_range,1.01,
	\mouseXStart, 0.0,
	\mouseXScale, 0.1,
	\group, nil
).play;
)

s.reboot;


//----------------------Language-Side Experiments
(
(type: \group,
id: 7         //create a group with nodeID 1
).play;
)


(
 ~exper = Pbindef(\1,
	\instrument,\gabor1,
	\type, \note,
	\dur,1/60,
	\tempo, 1,   // tempo is the num synths running from pattern * number_inputted
	\stretch, Pn(Pwhite(0.1,1.5)),   //expands/contracts durations //scalar for durations pretty much
	\sustain,0.08,
	\bufnum, Pn(Prand([~chimes[0]],inf),inf),
	\trigs, 0.001,
	\amp, 2.3,
	\rate, Pstep([1,1.1,1.4,0.9,0.6,1],0.001,inf),
	\samp_rand_rate, 100,
	\samp_rand_range,1.01,
	\mouseXStart, 0.0,
	\mouseXScale, 0.1,
	\group, 7 //if group is made, how to join the group
).play;
)


(
(type: \off, id: 7).play;         //release all notes in the group THIS seems broken for this use case
//(type: \kill, id: 7, lag: 3).play; //free groups 3 seconds later
)


//Pstep experiments
(
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		*MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)
	);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	//var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);
)
(
~chimes= Array.new;
~folder739 = PathName.new("/Users/jkilgore/Music/misc-samples/wind_chimes");
(
~folder739.entries.do({
	arg path;
	~chimes = ~chimes.add( Buffer.read(s,path.fullPath));
})
));
//potential for integrating FM synthesis

(
 ~exper = Pbindef(\1,
	\instrument,\gabor1,
	\type, \note,
	\dur,1/60,
	\tempo, 1,   // tempo is the num synths running from pattern * number_inputted
	\stretch, Pn(Pwhite(0.1,1.5)),   //expands/contracts durations //scalar for durations pretty much
	\sustain,0.08,
	\bufnum, Pn(Prand([~chimes[1]],inf),inf),
	\trigs, 0.001,
	\amp, 2.3,
	\rate, Pstep([1,1.1,1.4,0.9,0.6,1,1.9,2.1,10.1,12.3,-4],1/120,inf),
	\samp_rand_rate, 100,
	\samp_rand_range,1.01,
	\mouseXStart, 0.0,
	\mouseXScale, 0.1,
	\pan, Pstep([1/1, -1/1.1, 1/1.4, -1/0.9,1/0.6,-1/1,1/1.9,-1/2.1,1/10.1,-1/12.3,-1/4],1/1/120,inf)
).play;
)

























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
	cf = obj.value.linexp(0,1,60,4000).postln;
	~test = cf;
});
)
Window.closeAll;