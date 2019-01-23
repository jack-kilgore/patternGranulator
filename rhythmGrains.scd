//------------Good WindChime rhythm, find in sample-morph reaper project


( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
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
	//var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	OffsetOut.ar(out, siga);
},\ir!5).add;
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

s.reboot;

(
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pstep([0.016,0.016,0.017,0.017,0.004,0.03,0.05,0.001,0.001,0.001,0.1],1/4,inf),
	\dur,Pn(Pgeom(1/11.7,0.99,18),inf),
	\bufnum, Pn(Prand([~chimes[1]],inf),inf),
	\trigs, 0.001,
	\amp, 3.1,
	\rate, Pstep([1,9,1.07,1.04,0.1,4.005,10.7,0.17,-0.1,0.3,-0.3,0.05],1/8.3,inf),              //[Pfunc{~rate},
	\samp_rand_rate, 100,
	\samp_rand_range,1.5,
	\mouseXStart, 0.1,
	\mouseXScale, 0.1,
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
	\pan, Pwhite(-0.7,0.7);
).play;
)


///The cute high pitches

( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
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
	//var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	siga = BPF.ar(siga, filterFreq,0.01);
	OffsetOut.ar(out, siga);
},\ir!5).add;
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
 ~one = Pbindef(\2,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pstep([0.016,0.016,0.017,0.09,0.017,0.004,0.12,0.03,0.09,0.004,0.001,0.001,0.001,0.1,0.01,0.001],1/9,inf),
	\dur,Pn(Pgeom(1/148.1,0.98,12),inf),
	\bufnum, Pn(Prand([~chimes[1]],inf),inf),
	\trigs, 0.001,
	\amp, Pstep([24.1,24.1,20,15,1,0.2,0.7,1,1,19,20,26,29,30,32,24,24,47,24,29,40,43,48],1/49,inf),
	\rate, Pstep([9,9,8.9,1.5,1.7,11,1,2,3,12,9,1,9,9,0.1,0.1,-1.9,0.2,6.7,1,2.6],1/109,inf),              //[Pfunc{~rate},
	\samp_rand_rate, 100,
	\samp_rand_range,1.5,
	\mouseXStart, 0.1,
	\mouseXScale, 0.9,
	\filterFreq, Pwhite(61,16000),
	//\q, 0.01
	\pan, Pwhite(-0.7,0.7);
).play;
)
