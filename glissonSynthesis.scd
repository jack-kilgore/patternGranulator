s.quit;
(
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
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\sustain,0.02,
	\dur,0.03,
	\bufnum, Pn(Prand([~mag[1]],inf),inf),
	\trigs, 0.001,
	\amp, 20.1,
	\rate, Pn(Pseg([0.1,3],0.03)),
	\samp_rand_rate, 100,
	\samp_rand_range,2.6,
	\mouseXStart, 0,
	\mouseXScale, 1,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)


( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gaborGen1,{|out, amp=0.01, freq1=440,freq2 =480, sustain=0.01, pan, time| //time: (0,1]
	var amp2, env;
	var snd = SinOsc.ar(XLine.ar(freq1,freq2,sustain*time));
	//BPF.ar(snd,XLine.ar(1150,1300,time),0.001);
	amp2 = amp*AmpComp.ir(freq1.max(50))*0.5;
	env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(snd*env,pan),25));
},\ir!5).add;
);

(
 ~two= Pbindef(\2,
	\instrument,\gaborGen1,
	\sustain,Pn(Pwhite(0.01,0.25)),
	\dur,Pn(Pwhite(1/120,1/0.9)),
	\freq1, Pn(Pwhite(300,890)),
	\freq2, Pkey(\freq1) *Pn(Pwhite(1,3)),
	\amp, 0.3,
	\time,Pn(Pseg([1,1],[10])),
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)

(
 ~three= Pbindef(\3,
	\instrument,\gaborGen1,
	\sustain,Pn(Pwhite(0.009,0.25)),
	\dur,Pn(Pwrand(
		[
			Pstep(
			Pwhite(1/30,1/14),
			0.8,
			Pwhite(1,2)),

			Pwhite(1/100,1/0.4)
		],

		[0.2,0.8],inf)),
	\freq1, Pn(Pwhite(2500,6000)),
	\freq2, Pkey(\freq1) *Pn(Pwhite(0.8,1.9)),
	\amp, 0.7,
	\time,Pn(Pseg([1,1],[10])),
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)
s.quit;

(
(
 ~four= Pbindef(\4,
	\instrument,\gaborGen1,
	\sustain,0.1,
	\dur,Pn(Pwhite(1/120,1/0.9)),
	\freq1, Pn(Pwhite(9000,9990)),
	\freq2, 260,
	\amp, 0.3,
	\time,Pn(Pseg([1,1],[10])),
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);

(
 ~five= Pbindef(\5,
	\instrument,\gaborGen1,
	\sustain,0.1,
	\dur,Pn(Pwhite(1/120,1/0.9)),
	\freq1, Pn(Pwhite(2000,10090)),
	\freq2, 260,
	\amp, 0.3,
	\time,Pn(Pseg([1,1],[10])),
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);

(
 ~six= Pbindef(\6,
	\instrument,\gaborGen1,
	\sustain,0.1,
	\dur,Pn(Pwhite(1/120,1/0.9)),
	\freq1, Pn(Pwhite(6000,7090)),
	\freq2, 260,
	\amp, 0.3,
	\time,Pn(Pseg([1,1],[10])),
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);
(
 ~sev= Pbindef(\7,
	\instrument,\gaborGen1,
	\sustain,0.1,
	\dur,Pn(Pwhite(1/120,1/0.9)),
	\freq1, Pn(Pwhite(9000,9990)),
	\freq2, 260,
	\amp, 0.3,
	\time,Pn(Pseg([1,1],[10])),
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);

(
 ~eig= Pbindef(\8,
	\instrument,\gaborGen1,
	\sustain,0.1,
	\dur,Pn(Pwhite(1/120,1/0.9)),
	\freq1, Pn(Pwhite(2000,10090)),
	\freq2, 260,
	\amp, 0.3,
	\time,Pn(Pseg([1,1],[10])),
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);

(
 ~nine= Pbindef(\9,
	\instrument,\gaborGen1,
	\sustain,1,
	\dur,Pn(Pwhite(1/120,1/0.9)),
	\freq1, Pn(Pwhite(17000,18090)),
	\freq2, 30,
	\amp, 0.3,
	\time,Pn(Pseg([0.7,0.7],[10])),
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
	\pan, ((Pkey(\freq1)%1000)-500)/500
).play;
);
)

(
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1Glisson,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate1 =1, rate2 = 1, time
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*XLine.ar(rate1,rate2,time*sustain), trig,
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
 ~one = Pbindef(\1,
	\instrument,\gabor1Glisson,
	\sustain,0.25,
	\dur,Pn(Pwhite(1/120,1/120)),
	\bufnum, Pn(Prand([~mag[3]],inf),inf),
	\trigs, 0.001,
	\amp, 0.4,
	\rate1, Pn(Pwhite(2.7,2.7)),
	\rate2, 0.1,
	\time, 1,
	\samp_rand_rate, 100,
	\samp_rand_range,1.001,
	\mouseXStart, 0.2,
	\mouseXScale, 0.2,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)


(
 ~two = Pbindef(\2,
	\instrument,\gabor1Glisson,
	\sustain,0.2,
	\dur,Pn(Pwhite(1/120,1/120)),
	\bufnum, Pn(Prand([~mag[6]],inf),inf),
	\trigs, 0.001,
	\amp, 0.5,
	\rate1, 10,
	\rate2, Pn(Pwhite(0.4,0.6)),
	\time, 1,
	\samp_rand_rate, 100,
	\samp_rand_range,1.1,
	\mouseXStart, 0,
	\mouseXScale, 1,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)

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
~chimes= Array.new;
~folder739 = PathName.new("/Users/jkilgore/Music/misc-samples/wind_chimes");
(
~folder739.entries.do({
	arg path;
	~chimes = ~chimes.add(Buffer.read(s,path.fullPath));
})
));


s.quit;

//BPF

(
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1GlissonBPF,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate1 =1, rate2 = 1, time
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*XLine.ar(
		rate1,
		rate2,
		time*sustain), trig,
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
	siga = LPF.ar(siga,10000);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);
)
s.quit;

(
 ~onef = Pbindef(\1,
	\instrument,\gabor1GlissonBPF,
	\sustain,Pn(Pseg([0.22,0.5],30)),
	\dur,Pn(Pwhite(1/120,1/120)),
	\bufnum, Pn(Prand([~mag[3]],inf),inf),
	\trigs, 0.001,
	\amp, 0.6,
	\rate1, Pn(Pwrand([2.1,0.1], [0.9,0.1])),
	\rate2,Pn(Pwrand([2.1,0.1], [0.1,0.9])),
	\time, 1,
	\samp_rand_rate, 100,
	\samp_rand_range,1.0001,
	\mouseXStart, 0.2,
	\mouseXScale, 0.2,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)