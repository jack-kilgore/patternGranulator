//RINGMOD

( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor01,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0,bufnum2,bufnum3|
	var siga;
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	//var enver = EnvGen.ar(Env([0,1,1,0],[sustain*0.1,sustain*0.8,sustain*0.1],'sin'),doneAction:2);
	var sigb =
	PlayBuf.ar(1, bufnum2, BufRateScale.kr(bufnum)*rate*2.1, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum)*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	);
	var sigc =
	PlayBuf.ar(1, bufnum3, BufRateScale.kr(bufnum)*rate*0.6, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum)*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	);
	siga = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum)*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	);

	siga = BPF.ar(siga,filterFreq,q);
	siga = LPF.ar(siga,15000);
	siga = BPeakEQ.ar(siga, 1200, 0.3, -12.0);
	siga = siga*(sigb);
	siga = HPF.ar(Pan2.ar(siga*env*amp2,pan),45);
	OffsetOut.ar(out, siga);
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
(
 ~two = Pbindef(\m2,
	\instrument,\gabor01,
	\type, \note,
	\sustain,Pseg([0.01,0.9],[1/12],\exp,inf),
	\dur,Pn(Pstep([1/86,1/77],[1/10,1/45]),inf),
	\bufnum, Pn(Prand([~sticker[10]],inf),inf),
	\bufnum2, ~sticker[0],
	\bufnum3, ~sticker[10],
	\trigs, 0.001,
	\amp, 9,
	\rate, Pn(Pstep([-1.0,0.24,0.3],[1/10,1/80,1/60,1/8])),
	\samp_rand_rate, 1/100,
	\samp_rand_range,Pn(Plprand(0.900,1.3)),
	\mouseXStart, Pn(Pseg([0.7,0.98,0.3],[1/120,1/125],\exp)), //+0.5 Pn(Pseg([0.1,0.9,1],[12,18]))
	\mouseXScale, 0,
	\pan, Pn(Pwhite(-0.9,0.9)),
	//\stretch, 10
	//\delta,
	\filterFreq, Pn(Pwhite(1.0))*Pn(Pstep([80,1800,260],1/17 )),
	\q,3
	//\q, 0.01
).play;
);

















//low textures

( //a gabor(approx. gaussian-shaped) grain
SynthDef(\test2,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var fBLoopOut,fBLoopIn,processing;
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
	var env = Env([0.0, amp*0.9,0.7,amp,amp*0.6,0], [sustain*0.1,sustain*0.2,sustain*0.01,sustain*0.59,sustain*0.1], \sin);
	var envg = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	//var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*envg,pan),25);
	siga = BPeakEQ.ar(siga,150.0,1, -20.0);
	siga = BPeakEQ.ar(siga,100.0,0.2, -20.0);
	siga = BPeakEQ.ar(siga, 600, 0.1, -8);
	siga = BPeakEQ.ar(siga,1900.0,1, -12.0);
	siga = BPeakEQ.ar(siga, 1500, 0.6, -24);
	siga = BPeakEQ.ar(siga, 1000, 0.1, -6);
	siga = BPeakEQ.ar(siga, 480, 0.7, -6);
	siga = BPeakEQ.ar(siga, 4500, 2, -16);
	siga = LPF.ar(siga,5000);
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
	\instrument,\test2,
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





///ADDITIVE

( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor0,{|out, amp=0.01, freq=440, sustain=0.01, pan=0, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)*
		BufFrames.kr(bufnum)*mouseXScale

		/*MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
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
	\mouseXScale,Pseg([0,1],15,'sin'),
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
	\mouseXScale,Pseg([0,1],15,'sin'),
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
	\amp, 0.9,
	\rate, 0.6,
	\samp_rand_rate, 12,
	\samp_rand_range,1.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,Pseg([0,1],25,'sin'),
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
	\mouseXScale,Pseg([0,1],15,'sin'),
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
	\mouseXScale,Pseg([0,1],45,'sin'),
	\pan, Pn(Plprand(-0.9, 0.1)),
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
	\mouseXScale,Pseg([0,1],15,'sin'),
	\pan, Pn(Pwhite(-1.0,1.0)),
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);
)