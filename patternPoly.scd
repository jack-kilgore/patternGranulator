( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan=0, bufnum, trigs=2000, rate =1,
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

(
~seth= Array.new;
~folder63 = PathName.new("/Users/jkilgore/Music/misc-samples/AudioInspo/Seth Graham - Gasp/");
(
~folder63.entries.do({
	arg path;
	~seth = ~seth.add(Buffer.read(s,path.fullPath));
})
));
(
~sticker= Array.new;
~folder73 = PathName.new("/Users/jkilgore/Music/misc-samples/sticker");
(
~folder73.entries.do({
	arg path;
	~sticker = ~sticker.add(Buffer.read(s,path.fullPath));
})
));


)

(
 ~two = Pbindef(\1,
	\instrument,\gabor1,
	\sustain,0.038,
	\dur,1/520,
	\bufnum, Pn(Prand([~sticker[10]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.5,
	\rate, 1,
	\samp_rand_rate, 12,
	\samp_rand_range,1.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,1,
	\pan, 0.7
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
)

(
 ~two1 = Pbindef(\2,
	\instrument,\gabor1,
	\sustain,0.038,
	\dur,1/520,
	\bufnum, Pn(Prand([~sticker[10]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.5,
	\rate, 1.2,
	\samp_rand_rate, 12,
	\samp_rand_range,1.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,1,
	\pan, -0.7
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
)
(
 ~two2 = Pbindef(\3,
	\instrument,\gabor1,
	\sustain,0.038,
	\dur,1/520,
	\bufnum, Pn(Prand([~sticker[10]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.7,
	\rate, 0.6,
	\samp_rand_rate, 12,
	\samp_rand_range,1.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,1,
	\pan, 0.2
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
)

(
 ~two3 = Pbindef(\4,
	\instrument,\gabor1,
	\sustain,0.042,
	\dur,1/520,
	\bufnum, Pn(Prand([~sticker[10]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.7,
	\rate, 1.6,
	\samp_rand_rate, 12,
	\samp_rand_range,1.001, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,1,
	\pan, Pn(Pseries(-1, 0.01, 400)),
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
)

(
 ~two4 = Pbindef(\5,
	\instrument,\gabor1,
	\sustain,0.012,
	\dur,1/720,
	\bufnum, Pn(Prand([~sticker[10]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.4,
	\rate, 0.4,
	\samp_rand_rate, 12,
	\samp_rand_range,2.1, //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,1,
	\pan, 0,
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
)




~two1.stop;
(
 ~four = Pbindef(\4,
	\instrument,\gabor1,
	\sustain,0.02,
	\dur,1/34,
	\bufnum, Pn(Prand([~seth[4]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.4,
	\rate, 0.6,
	\samp_rand_rate, 120,
	\samp_rand_range,Pn(Pgeom(1.0, 1.0008, 20000)), //1.000000 - 1000  1.00001
	\mouseXStart, 0.316,
	\mouseXScale,0.1,
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
)
~four.stop;

(
 ~three = Pbindef(\2,
	\instrument,\gabor1,
	\sustain,Pn(Pgeom(0.01,1.0021,96)),
	\dur,1/Pn(Pwhite(0.1,0.9)),
	\bufnum, Pn(Prand([~opn[0],~chimes[0],~seth[3]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 2.4,
	\rate, Pn(Pwhite(0.4,0.6),inf),
	\samp_rand_rate, 120,
	\samp_rand_range,Pn(Pgeom(1.0, 1.000001, 3000)), //1.000000 - 1000  1.00001
	\mouseXStart, 0.116,
	\mouseXScale,0.5,
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
)

(
 ~three = Pbindef(\2,
	\instrument,\gabor1,
	\sustain,Pn(Pgeom(0.9,1.1,1)),
	\dur,1/0.7,
	\bufnum, Pn(Prand([~opn[0],~chimes[0],~seth[5]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.4,
	\rate, Pn(Pwhite(1/Pgeom(0.6,1.0002,2),0.1),inf),
	\samp_rand_rate, 120,
	\samp_rand_range,Pn(Pgeom(1.0, 1.0001, 100)), //1.000000 - 1000  1.00001
	\mouseXStart, 0.516,
	\mouseXScale,0 ,
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
)
~three.stop;

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
~three.stop;


(
 ~four = Pbindef(\3,
	\instrument,\gabor1,
	\sustain,Pwhite(0.002,0.4),
	\dur,1/0.8,
	\bufnum, Pn(Prand([~mag[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 3.3,
	\rate, Pn(Pgeom(0.2,1.002,18)),
	\samp_rand_rate, 100,
	\samp_rand_range,Pn(Pgeom(1.0, 1.0004, 400)), //1.000000 - 1000  1.00001
	\mouseXStart, 0,
	\mouseXScale,0.2 ,
	//\filterFreq, 60,
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
 ~bass = Pbindef(\1,
	\instrument,\gabor1,
	\sustain,Pn(Pwhite(0.7,0.8)),
	\dur,1/220,
	\bufnum, Pn(Prand([~opn[0],~chimes[0],~mag[3]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.6,
	\rate, Pn(Pgeom(0.6,1.0002,6)),
	\samp_rand_rate, 120,
	\samp_rand_range,Pn(Pgeom(1.0, 1.00001, 10)), //1.000000 - 1000  1.00001
	\mouseXStart, 0.216,
	\mouseXScale,0.1 ,
	\filterFreq, Pn(Pbrown(40,70,1)),
	\q, 0.5
).play;
)
)
