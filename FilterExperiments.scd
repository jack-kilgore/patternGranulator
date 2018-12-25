//Filter Experimentation

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
	OffsetOut.ar(out, sigf);
},\ir!5).add;
)

(
~mag= Array.new;
~folder61 = PathName.new("C:/Users/Jackalaka/Desktop/misc samples/10_28_18-magents");
(
~folder61.entries.do({

	arg path;
	~mag = ~mag.add(Buffer.read(s,path.fullPath));
})
))


//Pn(Pfunc({~test}))
(
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\sustain,Pn(Pgeom(0.2,1.2,1),inf),
	\dur,Pn(Pgeom(0.004,1.2,3),inf),
	\bufnum, Pn(Prand([~mag[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 7.1,
	\rate, 1.0,
	\samp_rand_rate, 100,
	\samp_rand_range,1.35,
	\mouseXStart, 0.1,
	\mouseXScale, 1,
	\filterFreq, Pn(Pfunc({~test})),
	\q, 0.2
).play;
)