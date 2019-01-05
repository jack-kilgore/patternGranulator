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
	var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	OffsetOut.ar(out, sigf);
},\ir!5).add;
);
(
(
~opn= Array.new;
~folder65 = PathName.new("/Users/jkilgore/Music/misc-samples/AudioInspo/OPN/");
(
~folder65.entries.do({
	arg path;
	~opn = ~opn.add(Buffer.read(s,path.fullPath));
})
));

(
~mag= Array.new;
~folder61 = PathName.new("/Users/jkilgore/Music/misc-samples/10_28_18-magents/");
(
~folder61.entries.do({
	arg path;
	~mag = ~mag.add(Buffer.read(s,path.fullPath));
})
));

(
~chimes= Array.new;
~folder739 = PathName.new("/Users/jkilgore/Music/misc-samples/wind_chimes");
(
~folder739.entries.do({
	arg path;
	~chimes = ~chimes.add(Buffer.read(s,path.fullPath));
})
));
)
(
~four.stop;
~three.stop;
(
 ~two = Pbindef(\1,
	\instrument,\gabor1,
	\sustain,Pn(Pwhite(0.7,0.8)),
	\dur,1/200,
	\bufnum, Pn(Prand([~opn[0],~chimes[0],~mag[3]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 1.0,
	\rate, Pn(Pgeom(0.6,1.0002,2)),
	\samp_rand_rate, 120,
	\samp_rand_range,Pn(Pgeom(1.0, 1.001, 10)), //1.000000 - 1000  1.00001
	\mouseXStart, 0.216,
	\mouseXScale,0.1 ,
	\filterFreq, Pn(Pbrown(40,80,1)),
	\q, 0.6
).play;
)
)

(
 ~three = Pbindef(\2,
	\instrument,\gabor1,
	\sustain,Pwhite(0.002,0.4),
	\dur,1/28.4,
	\bufnum, Pn(Prand([~chimes[0],~mag[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.3,
	\rate, Pn(Pgeom(1.2,1.002,18)),
	\samp_rand_rate, 100,
	\samp_rand_range,Pn(Pgeom(1.0, 1.0004, 200)), //1.000000 - 1000  1.00001
	\mouseXStart, Pn(Pseries(0.1,0.01,10)),
	\mouseXScale,Pn(Pwhite(0.001,1)) ,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)



(
 ~four = Pbindef(\3,
	\instrument,\gabor1,
	\sustain,Pwhite(0.002,0.4),
	\dur,1/38.4,
	\bufnum, Pn(Prand([~mag[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 3.3,
	\rate, Pn(Pgeom(1.2,1.002,18)),
	\samp_rand_rate, 100,
	\samp_rand_range,Pn(Pgeom(1.0, 1.0004, 200)), //1.000000 - 1000  1.00001
	\mouseXStart, Pn(Pseries(0.1,0.01,10)),
	\mouseXScale,Pn(Pwhite(0.001,1)) ,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)


/////beautiful bass preset

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
	var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	OffsetOut.ar(out, sigf.clip2(2));
},\ir!5).add;
);
(
(
~opn= Array.new;
~folder65 = PathName.new("/Users/jkilgore/Music/misc-samples/AudioInspo/OPN/");
(
~folder65.entries.do({
	arg path;
	~opn = ~opn.add(Buffer.read(s,path.fullPath));
})
));

(
~mag= Array.new;
~folder61 = PathName.new("/Users/jkilgore/Music/misc-samples/10_28_18-magents/");
(
~folder61.entries.do({
	arg path;
	~mag = ~mag.add(Buffer.read(s,path.fullPath));
})
));

(
~chimes= Array.new;
~folder739 = PathName.new("/Users/jkilgore/Music/misc-samples/wind_chimes");
(
~folder739.entries.do({
	arg path;
	~chimes = ~chimes.add(Buffer.read(s,path.fullPath));
})
));
)
(
~four.stop;
~three.stop;
(
 ~two = Pbindef(\1,
	\instrument,\gabor1,
	\sustain,Pn(Pwhite(0.7,0.8)),
	\dur,1/280,
	\bufnum, Pn(Prand([~opn[0],~chimes[0],~mag[3]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.6,
	\rate, Pn(Pgeom(0.6,1.0002,6)),
	\samp_rand_rate, 120,
	\samp_rand_range,Pn(Pgeom(1.0, 1.00001, 10)), //1.000000 - 1000  1.00001
	\mouseXStart, 0.216,
	\mouseXScale,0.1 ,
	\filterFreq, Pn(Pbrown(50,120,3)),
	\q, 0.6
).play;
)
)
