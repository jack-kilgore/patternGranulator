( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
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
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	//var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	siga = BPeakEQ.ar(siga,150.0,1, -20.0);
	siga = BPeakEQ.ar(siga,100.0,0.2, -20.0);
	siga = BPeakEQ.ar(siga, 600, 0.1, -8);
	siga = BPeakEQ.ar(siga,1900.0,1, -12.0);
	siga = BPeakEQ.ar(siga, 1500, 0.6, -24);
	siga = BPeakEQ.ar(siga, 1000, 0.1, -6);
	siga = BPeakEQ.ar(siga, 480, 0.7, -6);
	siga = BPeakEQ.ar(siga, 4500, 2, -16);
	siga = LPF.ar(siga,5000);
	fBLoopIn = LocalIn.ar(2);
	processing = siga + LeakDC.ar(DelayN.ar(fBLoopIn,0.98,0.98,0.9));
	processing = processing.clip;
	fBLoopOut = LocalOut.ar(processing);

	OffsetOut.ar(out, processing);
},\ir!5).add;
);

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
~chimes= Array.new;
~folder739 = PathName.new("/Users/jkilgore/Music/misc-samples/wind_chimes");
(
~folder739.entries.do({
	arg path;
	~chimes = ~chimes.add(Buffer.read(s,path.fullPath));
})
));


(
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\sustain,Pwhite(0.005,0.028),
	\dur,1/20,
	\bufnum, Pn(Prand([~chimes[0]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 9.5,
	\rate, 1,
	\samp_rand_rate, 100,
	\samp_rand_range,Pn(Pgeom(1.00000,1.51,3)), //1.000000 - 1000  1.00001
	\mouseXStart, 0.116,
	\mouseXScale,0.1 ,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)

(
 ~two = Pbindef(\2,
	\instrument,\gabor1,
	\sustain,Pwhite(0.004,0.015),
	\dur,1/23,
	\bufnum, Pn(Prand([~chimes[0]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 5.5,
	\rate, 1,
	\samp_rand_rate, 100,
	\samp_rand_range,Pn(Pgeom(1.00000,1.001,4)), //1.000000 - 1000  1.00001
	\mouseXStart, 0.36,
	\mouseXScale,0.01 ,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)

(
 ~two = Pbindef(\3,
	\instrument,\gabor1,
	\sustain,Pwhite(0.004,0.015),
	\dur,1/17,
	\bufnum, Pn(Prand([~chimes[1],~chimes[2]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 8.5,
	\rate, 1,
	\samp_rand_rate, 100,
	\samp_rand_range,Pn(Pgeom(1.00000,1.3,7)), //1.000000 - 1000  1.00001
	\mouseXStart, 0.36,
	\mouseXScale,0.01 ,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)

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
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\sustain,Pwhite(0.04,0.034),
	\dur,1/68,
	\bufnum, Pn(Prand([~opn[0]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 3.5,
	\rate, 1.3,
	\samp_rand_rate, 100,
	\samp_rand_range,Pn(Pgeom(1.00000,1.51,3)), //1.000000 - 1000  1.00001
	\mouseXStart, 0.316,
	\mouseXScale,0.1 ,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)
s.reboot;