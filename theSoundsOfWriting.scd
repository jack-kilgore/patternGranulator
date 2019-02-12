( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var siga;
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, trig,
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

(
 ~one = Pbindef(\misc,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.3,0.07,0.05,0.01,0.4,0.4,0.1,0.3,0.001],[17,7,3.5,7,7,14,20],\exp,inf),
	\dur,Pbrown(1/101,1/124.4,1/10.1),
	\bufnum, Pn(Prand([~misc[0]],inf),inf),
	\trigs, 0.001,
	\amp, 1.0,
	\rate, Pn(Pstep([1.0,1.2,0.9,2,0.6],[0.1,0.6,0.8,1])),
	\samp_rand_rate, 100,
	\samp_rand_range,Pkey(\sustain)+1.001,
	\mouseXStart, 1.2*Pkey(\sustain)+0.3, //+0.5
	\mouseXScale, 0,
	\pan, 0
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);

//1.2*Pkey(\sustain)+0.3
//Pkey(\sustain)+0.5