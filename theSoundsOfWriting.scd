( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var siga;
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum)*mouseXStart
		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	//var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	siga = LPF.ar(siga,100);
	siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);



(
~misc= Array.new;
~folder65 = PathName.new("/Users/jkilgore/Music/misc-samples/bookReads/");
(
~folder65.entries.do({

	arg path;
	~misc = ~misc.add(Buffer.read(s,path.fullPath));
})
));

( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var siga;
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	siga = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum)*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	);

	//siga = BPF.ar(siga,filterFreq,0.2);
	//siga = LPF.ar(siga,15000);
	siga = Compander.ar(siga,siga,0.3,1.0,0.6);
	siga = BPeakEQ.ar(siga, 1200, 0.33, -12.0);
	siga = HPF.ar(Pan2.ar(siga*env,pan),45);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);

(
 ~two = Pbindef(\misc,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.3,0.07,0.05,0.01,0.4,0.4,0.1,0.3,0.001],[17,7,3.5,7,7,14,20],\exp,inf),
	\dur,Pbrown(1/101,1/124.4,1/10.1),
	\bufnum, Pn(Prand([~misc[0]],inf),inf),
	\trigs, 0.001,
	\amp, 0.46,
	\rate, Pn(Pstep([-1.0,1.0,-0.6,0.6,-1.7,1.7],[1/10,1/15,1/40])),
	\samp_rand_rate, 100,
	\samp_rand_range,Pkey(\sustain)+0.79,
	\mouseXStart, 1.2*Pkey(\sustain)+0.27, //+0.5
	\mouseXScale, 0,
	\pan, 0,
	//\stretch, 10
	//\delta,
	\filterFreq, Pn(Pstep([440,870,320,10000],[1/12,1/12.2])),
	//\q, 0.01
).play;
);
~two.stop;
//1.2*Pkey(\sustain)+0.3
//Pkey(\sustain)+0.5



(
 ~one = Pbindef(\miscer,
	\instrument,\gabor1,
	\type, \note,
	\sustain, Pseg([0.3,0.07,0.05,0.01,0.4,0.4,0.1,0.3,0.001],[17,7,3.5,7,7,14,20],\exp,inf),
	\dur,Pn(Pbrown(Pseg([1/100,1/200,1/400,1/103],[0.1,0.7,0.2],\exp,inf),1/6,0.1)),
	\bufnum, Pn(Prand([~misc[0]],inf),inf),
	\trigs, 0.001,
	\amp, 4.8,
	\rate, Pn(Pstep([1.0,1.2,0.9,2,0.6],[0.1,0.6,0.8,1])),
	\samp_rand_rate, 100,
	\samp_rand_range,Pkey(\sustain)+1.015,
	\mouseXStart, 1.2*Pkey(\sustain)+0.31, //+0.5
	\mouseXScale, 0,
	\pan, 0
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);










////filtertes



///MELODY STUFF
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gaborfreq,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var siga;
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	var enver = EnvGen.ar(Env([0,1,1,0],[sustain*0.1,sustain*0.8,sustain*0.1],'sin'),doneAction:2);
	siga = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum)*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	);
	siga = BPF.ar(siga,filterFreq,0.008);
	//siga = LPF.ar(siga,15000);
	siga = BPeakEQ.ar(siga, 1200, 0.3, -12.0);
	siga = HPF.ar(Pan2.ar(siga*enver,pan),45);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);
//Env([0,1,1,0],[1,2,1],'sin').plot;
(
 ~two = Pbindef(\misc11,
	\instrument,\gaborfreq,
	\type, \note,
	\sustain,Pseg([0.3,0.7],[17,7,3.5,7,7,14,20],\exp,inf),
	\dur,Pn(Pstep([1/221,1/124.4,1/100.1],[1/12,1/30]),inf),
	\bufnum, Pn(Prand([~misc[0]],inf),inf),
	\trigs, 0.001,
	\amp, 10,
	\rate, Pn(Pstep([1.0,1.2,0.9,2,0.6,1.8,0.4],[0.1,0.6,0.8,1])),
	\samp_rand_rate, 100,
	\samp_rand_range,Pn(Pbrown(1.001,1.9,1.001)),
	\mouseXStart, 0.8, //+0.5
	\mouseXScale, 0,
	\pan, 0,
	//\stretch, 10
	//\delta,
	\filterFreq, Pn(Pstep([260,870,520,12000,18000],Pn(Pseg([1/68,1/48],10)))),
	//\q, 0.01
).play;
);









///SUBBASS TONESSSS
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gaborfreq1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var siga;
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	var enver = EnvGen.ar(Env([0,1,0],[sustain*0.001,sustain*0.999],'lin'),doneAction:2);
	siga = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum)*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	);

	siga = BPF.ar(siga,filterFreq,0.003);
	//siga = LPF.ar(siga,15000);
	//siga = BPeakEQ.ar(siga, 1200, 0.3, -12.0);
	siga = HPF.ar(Pan2.ar(siga*env,pan),15);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);

(
 ~three = Pbindef(\misc1,
	\instrument,\gaborfreq1,
	\type, \note,
	\sustain,Pseg([0.4,0.6],[17,7,3.5,7,7,14,20],\exp,inf),
	\dur,Pn(Pstep([1/21,1/44.4,1/50.1],[1/12,1/30]),inf),
	\bufnum, Pn(Prand([~misc[0]],inf),inf),
	\trigs, 0.001,
	\amp, 125,
	\rate, Pn(Pstep([1.0,0.52,1.9,2,1.1],[0.1,0.6,0.8,1])),
	\samp_rand_rate, 100,
	\samp_rand_range,Pkey(\sustain)+1.001,
	\mouseXStart, Pn(Pbrown(0.4,0.7)), //+0.5
	\mouseXScale, 0,
	\pan, Pn(Pbrown(-0.8,0.8,0.3)),
	//\stretch, 10
	//\delta,
	\filterFreq, Pn(Pstep([42],1/10)),
	//\q, 0.01
).play;
);
~t hree.stop;





/////more experiments
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gaborfreqclick,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var siga;
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	//var enver = EnvGen.ar(Env([0,1,1,0],[sustain*0.1,sustain*0.8,sustain*0.1],'sin'),doneAction:2);
	siga = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum)*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	);
	siga = BPF.ar(siga,filterFreq,0.008);
	//siga = LPF.ar(siga,15000);
	siga = BPeakEQ.ar(siga, 1200, 0.3, -12.0);
	siga = HPF.ar(Pan2.ar(siga*env*amp2,pan),45);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);
//Env([0,1,1,0],[1,2,1],'sin').plot;
(
 ~two = Pbindef(\m1,
	\instrument,\gaborfreqclick,
	\type, \note,
	\sustain,Pseg([0.001,0.9,0.3,0.001],[1/196,1/70,1/200],\exp,inf),
	\dur,Pn(Pstep([1/221,1/124.4,1/100.1],[1/12,1/30]),inf),
	\bufnum, Pn(Prand([~misc[0]],inf),inf),
	\trigs, 0.001,
	\amp, 11,
	\rate, Pn(Pstep([1.0,1.2,0.9,2,0.6,1.8,0.4],[0.1,0.6,0.8,1])),
	\samp_rand_rate, 100,
	\samp_rand_range,Pn(Pbrown(1.001,1.9,1.001)),
	\mouseXStart, 0.8, //+0.5
	\mouseXScale, 0,
	\pan, Pn(Pwhite(-1,1)),
	//\stretch, 10
	//\delta,
	\filterFreq, Pn(Pwhite(1.0))*Pn(Pstep([18000,1060,17900,18100,16900],Pn(Pseg([1/68,1/48],10)))),
	//\q, 0.01
).play;
);



///more tries

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
//Env([0,1,1,0],[1,2,1],'sin').plot;
(
 ~two = Pbindef(\m2,
	\instrument,\gabor01,
	\type, \note,
	\sustain,Pseg([0.01,0.9],[1/12],\exp,inf),
	\dur,Pn(Pstep([1/86,1/77],[1/10,1/45]),inf),
	\bufnum, Pn(Prand([~mag[3]],inf),inf),
	\bufnum2, ~chimes[0],
	\bufnum3, ~misc[3],
	\trigs, 0.001,
	\amp, 10,
	\rate, Pn(Pstep([-1.0,0.24,0.3],[1/10,1/80,1/60,1/8])),
	\samp_rand_rate, 1/100,
	\samp_rand_range,Pn(Plprand(0.900,1.3)),
	\mouseXStart, Pn(Pseg([0.1,0.9],60)), //+0.5
	\mouseXScale, 0,
	\pan, Pn(Pwhite(-0.9,0.9)),
	//\stretch, 10
	//\delta,
	\filterFreq, Pn(Pwhite(1.0))*Pn(Pstep([1200,80,1800],1/10 )),
	\q,5
	//\q, 0.01
).play;
);

(
~chimes= Array.new;
~folder739 = PathName.new("/Users/jkilgore/Music/misc-samples/wind_chimes");
(
~folder739.entries.do({
	arg path;
	~chimes = ~chimes.add( Buffer.read(s,path.fullPath));
})
));
(
~mag= Array.new;
~folder65 = PathName.new("/Users/jkilgore/Music/misc-samples/10_28_18-magents");
(
~folder65.entries.do({

	arg path;
	~mag = ~mag.add(Buffer.read(s,path.fullPath));
})
));
