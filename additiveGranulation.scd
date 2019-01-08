
///Users/jkilgore/Music/sample-morph/Proxy_gran/additiveGranular/stickers
   ///using stickerpeel0mono

( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor0,{|out, amp=0.01, freq=440, sustain=0.01, pan=0, bufnum, trigs=2000, rate =1,
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
	var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	siga = BPeakEQ.ar(siga, 1200, 0.3, -12.0);
	OffsetOut.ar(out, Pan2.ar(siga,pan));
},\ir!5).add;
);

(
~sticker= Array.new;
~folder73 = PathName.new("/Users/jkilgore/Music/misc-samples/sticker");
(
~folder73.entries.do({
	arg path;
	~sticker = ~sticker.add(Buffer.read(s,path.fullPath));
})
));
///should i use a mono or stereo signal?
// mono would be best but how do you make it sound like they are moving dynamically

(
(
 ~sticker0 = Pbindef(\sticker0,
	\instrument,\gabor0,
	\sustain,0.038,
	\dur,1/520,
	\bufnum, Pn(Prand([~sticker[10]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.5,
	\rate, 1,
	\samp_rand_rate, 12,
	\samp_rand_range,1.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,0.5,
	\pan, Pn(Pwhite(0.1, 0.8))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~sticker1 = Pbindef(\sticker1,
	\instrument,\gabor0,
	\sustain,0.038,
	\dur,1/520,
	\bufnum, Pn(Prand([~sticker[10]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.5,
	\rate, 1.2,
	\samp_rand_rate, 12,
	\samp_rand_range,1.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,0.5,
	\pan, Pn(Phprand(-0.1,0.9)),
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~sticker2 = Pbindef(\sticker2,
	\instrument,\gabor0,
	\sustain,0.038,
	\dur,1/520,
	\bufnum, Pn(Prand([~sticker[10]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.7,
	\rate, 0.6,
	\samp_rand_rate, 12,
	\samp_rand_range,1.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,0.5,
	\pan, Pn(Plprand(-0.4, 0.1)),
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~sticker3 = Pbindef(\sticker3,
	\instrument,\gabor0,
	\sustain,0.042,
	\dur,1/520,
	\bufnum, Pn(Prand([~sticker[10]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.75,
	\rate, 1.6,
	\samp_rand_rate, 12,
	\samp_rand_range,1.01, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,0.5,
	\pan, Pn(Phprand(0.6, 0.99)),
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~sticker4 = Pbindef(\sticker4,
	\instrument,\gabor0,
	\sustain,0.045,
	\dur,1/520,
	\bufnum, Pn(Prand([~sticker[10]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.7,
	\rate, 1.6,
	\samp_rand_rate, 12,
	\samp_rand_range,1.01, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,0.5,
	\pan, Pn(Plprand(-0.9, -0.1)),
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~sticker5 = Pbindef(\sticker5,
	\instrument,\gabor0,
	\sustain,0.018,
	\dur,1/720,
	\bufnum, Pn(Prand([~sticker[10]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.4,
	\rate, 0.4,
	\samp_rand_rate, 12,
	\samp_rand_range,2.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,0.5,
	\pan, Pn(Pwhite(-1.0,1.0)),
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);
)



///Users/jkilgore/Music/sample-morph/Proxy_gran/additiveGranular/wind_chimes


( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan=0, bufnum, trigs=2000, rate =1,
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
	var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	siga = BPeakEQ.ar(siga, 1200, 0.3, -12.0);
	OffsetOut.ar(out, Pan2.ar(siga,pan));
},\ir!5).add;
);
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1_1,{|out, amp=0.01, freq=440, sustain=0.01, pan=0, bufnum, trigs=2000, rate =1,
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
	var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	siga = BPeakEQ.ar(siga, 1200, 0.3, -12.0);
	siga = BPeakEQ.ar(siga, 1700, 0.3, -12.0);
	siga = BPeakEQ.ar(siga, 3500, 0.3, -8.0);
	siga = Compander.ar(siga, sig, 0.7, 1.0, 4.4, 0.002);
	OffsetOut.ar(out, Pan2.ar(siga,pan));
},\ir!5).add;
);



(
~chimes= Array.new;
~folder739 = PathName.new("/Users/jkilgore/Music/misc-samples/wind_chimes");
(
~folder739.entries.do({
	arg path;
	~chimes = ~chimes.add(Buffer.read(s,path.fullPath));
})
));

(
 ~chimes0 = Pbindef(\chimes0,
	\instrument,\gabor1,
	\sustain,0.018,
	\dur,1/720,
	\bufnum, Pn(Prand([~chimes[0]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.01,
	\rate, 0.4,
	\samp_rand_rate, 12,
	\samp_rand_range,2.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,0.5,
	\pan, Pn(Pwhite(-1.0,1.0)),
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~chimes1 = Pbindef(\chimes1,
	\instrument,\gabor1,
	\sustain,0.038,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[0]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.1,
	\rate, 1,
	\samp_rand_rate, 12,
	\samp_rand_range,1.001, //1.000000 - 1000  1.00001
	\mouseXStart, 0.6,
	\mouseXScale,0.01,
	\pan, Pn(Pwhite(0.1, 0.8))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~chimes2 = Pbindef(\chimes2,
	\instrument,\gabor1,
	\sustain,0.038,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[0]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.01,
	\rate, 0.2,
	\samp_rand_rate, 12,
	\samp_rand_range,1.001, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,0.4,
	\pan, Pn(Pwhite(0.1, 0.8))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~chimes3 = Pbindef(\chimes3,
	\instrument,\gabor1_1,
	\sustain,0.05,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[0]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.8,
	\rate, 1.2,
	\samp_rand_rate, 12,
	\samp_rand_range,1.001, //1.000000 - 1000  1.00001
	\mouseXStart, 0.1,
	\mouseXScale,0.01,
	\pan, Pn(Pwhite(0.1, 0.8))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~chimes4 = Pbindef(\chimes4,
	\instrument,\gabor1_1,
	\sustain,0.05,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[0]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.4,
	\rate, Pn(Pgeom(1.2,1.00000001,1),inf),
	\samp_rand_rate, 12,
	\samp_rand_range,1.002, //1.000000 - 1000  1.00001
	\mouseXStart, 0.1102,
	\mouseXScale,0.0006,
	\pan, Pn(Pwhite(0.1, 0.8))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~chimes5 = Pbindef(\chimes5,
	\instrument,\gabor1,
	\sustain,0.01,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[0]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.1,
	\rate, 1.4,
	\samp_rand_rate, 12,
	\samp_rand_range,1.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0.6,
	\mouseXScale,0.001,
	\pan, Pn(Pwhite(0.1, 0.8))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);


///Next up try with the same chimes file, but mono (aka chimes[1])
// continue to remove harsh harmonics in vocal range!!!!
  // make it sound goood on the ears

( //a gabor(approx. gaussian-shaped) grain
SynthDef(\mgabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan=0, bufnum, trigs=2000, rate =1,
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
	var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	siga = BPeakEQ.ar(siga, 1200, 0.3, -12.0);
	OffsetOut.ar(out, Pan2.ar(siga,pan));
},\ir!5).add;
);
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\mgabor1_1,{|out, amp=0.01, freq=440, sustain=0.01, pan=0, bufnum, trigs=2000, rate =1,
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
	var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	siga = BPeakEQ.ar(siga, 1200, 0.3, -12.0);
	siga = BPeakEQ.ar(siga, 1700, 0.3, -12.0);
	siga = BPeakEQ.ar(siga, 3500, 2, -12.0);
	siga = BPeakEQ.ar(siga, 2400, 0.2, -24);
	siga = Compander.ar(siga, sig, 0.7, 1.0, 4.4, 0.002);
	OffsetOut.ar(out, Pan2.ar(siga,pan));
},\ir!5).add;
)
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\mgabor1_2,{|out, amp=0.01, freq=440, sustain=0.01, pan=0, bufnum, trigs=2000, rate =1,
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
	var amp2 = amp*AmpComp.ir(freq.max(ÂÂÂ50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	siga = BPeakEQ.ar(siga, 1200, 0.5, -12.0);
	siga = BPeakEQ.ar(siga, 1700, 0.3, -12.0);
	siga = BPeakEQ.ar(siga, 3500, 0.3, -8.0);
	siga = BPeakEQ.ar(siga, 2400, 0.2, -24);
	siga = Compander.ar(siga, sig, 0.7, 1.0, 4.4, 0.002);
	OffsetOut.ar(out, Pan2.ar(siga,pan));
},\ir!5).add;
)
(
~chimes= Array.new;
~folder739 = PathName.new("/Users/jkilgore/Music/misc-samples/wind_chimes");
(
~folder739.entries.do({
	arg path;
	~chimes = ~chimes.add(Buffer.read(s,path.fullPath));
})
));


(
 ~mchimes0 = Pbindef(\mchimes0,
	\instrument,\mgabor1,
	\sustain,0.018,
	\dur,1/720,
	\bufnum, Pn(Prand([~chimes[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.01,
	\rate, 0.4,
	\samp_rand_rate, 12,
	\samp_rand_range,2.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,0.5,
	\pan, Pn(Pwhite(-1.0,1.0)),
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~mchimes1 = Pbindef(\mchimes1,
	\instrument,\mgabor1,
	\sustain,0.038,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.3,
	\rate, 1,
	\samp_rand_rate, 12,
	\samp_rand_range,1.001, //1.000000 - 1000  1.00001
	\mouseXStart, 0.6,
	\mouseXScale,0.01,
	\pan, Pn(Pwhite(0.1, 0.8))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~mchimes2 = Pbindef(\mchimes2,
	\instrument,\mgabor1,
	\sustain,0.038,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.04,
	\rate, 0.2,
	\samp_rand_rate, 12,
	\samp_rand_range,1.001, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,0.4,
	\pan, Pn(Pwhite(-0.8, -0.1))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~mchimes3 = Pbindef(\mchimes3,
	\instrument,\mgabor1_1,
	\sustain,0.05,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 1.8,
	\rate, 1.2,
	\samp_rand_rate, 12,
	\samp_rand_range,1.001, //1.000000 - 1000  1.00001
	\mouseXStart, 0.1,
	\mouseXScale,0.01,
	\pan, Pn(Pwhite(-0.5, 0.2))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~mchimes4 = Pbindef(\mchimes4,
	\instrument,\mgabor1_1,
	\sustain,0.05,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 1.8,
	\rate, 1.2,
	\samp_rand_rate, 12,
	\samp_rand_range,1.001, //1.000000 - 1000  1.00001
	\mouseXStart, 0.1001,
	\mouseXScale,0.01,
	\pan, Pn(Pwhite(-0.9, -0.5))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~mchimes5 = Pbindef(\mchimes5,
	\instrument,\mgabor1_1,
	\sustain,0.05,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.4,
	\rate, Pn(Pgeom(1.2,1.00000001,1),inf),
	\samp_rand_rate, 12,
	\samp_rand_range,1.002, //1.000000 - 1000  1.00001
	\mouseXStart, 0.1102,
	\mouseXScale,0.0006,
	\pan, Pn(Pwhite(-1, 1))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~mchimes6 = Pbindef(\mchimes6,
	\instrument,\mgabor1,
	\sustain,0.01,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.1,
	\rate, 1.4,
	\samp_rand_rate, 12,
	\samp_rand_range,1.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0.6,
	\mouseXScale,0.001,
	\pan, Pn(Pwhite(0.1, 0.8))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~mchimes7 = Pbindef(\mchimes7,
	\instrument,\mgabor1,
	\sustain,0.01,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.1,
	\rate, 3.6,
	\samp_rand_rate, 12,
	\samp_rand_range,1.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0.6,
	\mouseXScale,0.001,
	\pan, Pn(Pwhite(-0.1,0.1))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);
(
 ~mchimes3 = Pbindef(\mchimes8,
	\instrument,\mgabor1_2,
	\sustain,0.05,
	\dur,1/520,
	\bufnum, Pn(Prand([~chimes[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 1.8,
	\rate, 1.42,
	\samp_rand_rate, 12,
	\samp_rand_range,1.001, //1.000000 - 1000  1.00001
	\mouseXStart, 0.0996,
	\mouseXScale,0.01,
	\pan, Pn(Pwhite(0.1, 0.9))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);
