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
	siga = BPeakEQ.ar(siga, 80, 0.1,12);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);
)


(
~i3_2= Array.new;
~folder6 = PathName.new("/Users/jkilgore/Music/misc-samples/3_02_19-MiscSamples/");
(
~folder6.entries.do({
	arg path;
	~i3_2 = ~i3_2.add(Buffer.read(s,path.fullPath));
})
));

(
 ~sticker0 = Pbindef(\sticker0,
	\instrument,\gabor1,
	\sustain,0.5,
	\dur,1/30,
	\bufnum, Pn(Prand([~i3_2[5]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 0.5,
	\rate, Pn(Pgeom(0.7,1.1,100)),
	\samp_rand_rate, 12,
	\samp_rand_range,1.00, //1.000000 - 1000  1.00001
	\mouseXStart,Pn(Pseg([0.4,0.9],[Pwhite(1/500,1/1)])) ,
	\mouseXScale,Pn(Pwhite(0,1)),
	\pan, Pn(Pwhite(-0.8, 0.8))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);

(
 ~sticker1 = Pbindef(\sticker1,
	\instrument,\gabor1,
	\sustain,Pn(Pwhite(0.001,0.05)),
	\dur,Pn(Pseg([1/1200,1/30,1/38],[1.2,20])) ,
	\bufnum, Pn(Prand([~i3_2[5]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 1.5,
	\rate, Pn(Pbrown(1,1.7,1)),
	\samp_rand_rate, 12,
	\samp_rand_range,1.0, //1.000000 - 1000  1.00001
	\mouseXStart,Pn(Pseg([0.1,0.9,0.99,0.5,0.9,0,0.1,1],[1,0.1,0.1,1,1,3,10])) ,
	\mouseXScale,1,
	\pan, Pn(Pseg([-0.8,0.8,0,0],[1.2,0.1,20]))
	//\filterFreq, Pn(Pbrown(40,80,1)),
	//\q, 0.6
).play;
);
s.reboot;