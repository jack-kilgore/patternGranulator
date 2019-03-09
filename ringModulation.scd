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
	PlayBuf.ar(1, bufnum2, BufRateScale.kr(bufnum2)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum)*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	)*0.6;
	var sigc =
	PlayBuf.ar(2, bufnum3, BufRateScale.kr(bufnum3)*rate*0.6, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum)*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	)*0.6;
	siga = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*sigb, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum)*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	);

	//siga = BPF.ar(siga,filterFreq,q);
	//siga = LPF.ar(siga,15000);
	//siga = BPeakEQ.ar(siga, 1200, 0.3, -12.0);
	siga = siga*(sigb
	);
	siga = HPF.ar(Pan2.ar(siga*env*amp2,pan),20);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);

(
 ~two = Pbindef(\m2,
	\instrument,\gabor01,
	\type, \note,
	\sustain,Pseg([0.1,0.2],[1/12],\exp,inf),
	\dur,Pn(Pstep([1/166,1/167],[1/10,1/45]),inf),
	\bufnum, Pn(Prand([~v0m [0]],inf),inf),
	\bufnum2, ~op[0],
	\bufnum3, ~pencil[0],
	\trigs, 0.001,
	\amp, 5 ,
	\rate, Pn(Pstep([-1.0],[1/10,1/80,1/60,1/8])),
	\samp_rand_rate, 1/100,
	\samp_rand_range,Pn(Plprand(1.00,1.1)),
	\mouseXStart, Pn(Pseg([0.1,0.9],1/120)), //+0.5
	\mouseXScale, 0,
	//\pan, Pn(Pwhite(-0.9,0.9)),
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

(
~yog= Array.new;
~folder65 = PathName.new("/Users/jkilgore/Music/misc-samples/yogurt/");
(
~folder65.entries.do({

	arg path;
	~yog = ~yog.add(Buffer.read(s,path.fullPath));
})
));
(
~pencil= Array.new;
~folder65 = PathName.new("/Users/jkilgore/Music/misc-samples/pencilWrites/");
(
~folder65.entries.do({

	arg path;
	~pencil = ~pencil.add(Buffer.read(s,path.fullPath));
})
));
(
~v0m= Array.new;
~folder65 = PathName.new("/Users/jkilgore/Music/misc-samples/vocals/mono");
(
~folder65.entries.do({
	arg path;
	~v0m = ~v0m.add(Buffer.read(s,path.fullPath));
})
));
(
~op= Array.new;
~folder65 = PathName.new("/Users/jkilgore/Music/misc-samples/AudioInspo/OPN/");
(
~folder65.entries.do({

	arg path;
	~op = ~op.add(Buffer.read(s,path.fullPath));
})
));
(
~misc= Array.new;
~folder65 = PathName.new("/Users/jkilgore/Music/misc-samples/bookReads/");
(
~folder65.entries.do({

	arg path;
	~misc = ~misc.add(Buffer.read(s,path.fullPath));
})
));
