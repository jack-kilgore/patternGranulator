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


(
 ~two = Pbindef(\1,
	\instrument,\gabor1,
	\sustain,Pwhite(0.002,0.04),
	\dur,1/1.7,
	\bufnum, Pn(Prand([~opn[0],~chimes[0],~mag[3]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 1.5,
	\rate, 1,
	\samp_rand_rate, 100,
	\samp_rand_range,Pn(Pgeom(1.0, 1.001, 200)), //1.000000 - 1000  1.00001
	\mouseXStart, 0.516,
	\mouseXScale,0.1 ,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)

(
 ~three = Pbindef(\2,
	\instrument,\gabor1,
	\sustain,Pwhite(0.002,0.04),
	\dur,1/1.4,
	\bufnum, Pn(Prand([~opn[0],~chimes[0],~mag[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 1.0,
	\rate, 0.6,
	\samp_rand_rate, 100,
	\samp_rand_range,Pn(Pgeom(1.0, 1.004, 200)), //1.000000 - 1000  1.00001
	\mouseXStart, Pn(Pseries(0.1,0.01,10)),
	\mouseXScale,Pn(Pwhite(0.001,1)) ,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)


