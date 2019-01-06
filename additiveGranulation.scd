
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
	\amp, 0.7,
	\rate, 1.6,
	\samp_rand_rate, 12,
	\samp_rand_range,1.01, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,0.5,
	\pan, Pn(Plprand(-0.1, 0.9)),
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
 ~sticker5 = Pbindef(\chimes0,
	\instrument,\gabor1,
	\sustain,0.018,
	\dur,1/720,
	\bufnum, Pn(Prand([~chimes[0]],inf),inf), //magnet5 experiments
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
