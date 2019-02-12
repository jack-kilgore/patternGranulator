
(
//x'd out BPF for now, need to do more experiments in separate file
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

( //a gabor(approx. gaussian-shaped) grain
SynthDef(\sin,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	/*var sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum)*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	); */
	var sig = SinOsc.ar(freq);
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
~yog= Array.new;
~folder65 = PathName.new("/Users/jkilgore/Music/misc-samples/yogurt/");
(
~folder65.entries.do({

	arg path;
	~yog = ~yog.add(Buffer.read(s,path.fullPath));
})
))
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

//**FLUTTER DORNE *** TOO HIGH GAIN
(
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.3,0.07,0.01,0.001,0.0001,0.4,0.4,0.1,0.3,0.001],[17,7,3,16,7,7,14,20],\exp,inf),
	\dur,Pbrown(1/21,1/24.4,1/10.1),
	\bufnum, Pn(Prand([~pencil[1]],inf),inf),
	\trigs, 0.001,
	\amp, 20.1,
	\rate, Pn(Pbrown(1.39,1.393)),
	\samp_rand_rate, 100,
	\samp_rand_range,1.012,
	\mouseXStart, 0,
	\mouseXScale, 0,
	\pan, 0
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);
(
(
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.07,0.07],42.82,\cub,inf),
	\dur,Pbrown(1/21,1/23.4,1/10.1),
	\bufnum, Pn(Prand([~pencil[1]],inf),inf),
	\trigs, 0.001,
	\amp, 20.1,
	\rate, Pn(Pbrown(2.0,2.01)),
	\samp_rand_rate, 100,
	\samp_rand_range,1.0194,
	\mouseXStart, 0,
	\mouseXScale, 0,
	\pan, Pn(Pseg([-1,-0.7,0,0,-1,0.1],[0.91,1.91,9,7,1],\sqr))
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);
)
////////////////////

( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gaborop,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var siga;
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, trig,
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
	siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);

///***********OPN BEAUTY
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
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.3,0.07,0.01,0.001,0.0001,0.4,0.4,0.1,0.3,0.001],[17,7,3,8.5,7,7,14,20],\exp,inf),
	\dur,Pbrown(1/101,1/124.4,1/10.1),
	\bufnum, Pn(Prand([~op[0]],inf),inf),
	\trigs, 0.001,
	\amp, 1.0,
	\rate, Pn(Pbrown(1.0,1.01)),
	\samp_rand_rate, 100,
	\samp_rand_range,Pkey(\sustain)+1.001,
	\mouseXStart, 0.61,
	\mouseXScale, 0,
	\pan, 0
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
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
	\sustain,Pseg([0.3,0.07,0.01,0.001,0.0001,0.4,0.4,0.1,0.3,0.001],[17,7,3,8.5,7,7,14,20],\exp,inf),
	\dur,Pbrown(1/101,1/124.4,1/10.1),
	\bufnum, Pn(Prand([~misc[0]],inf),inf),
	\trigs, 0.001,
	\amp, 1.0,
	\rate, Pn(Pbrown(1.0,1.01)),
	\samp_rand_rate, 100,
	\samp_rand_range,Pkey(\sustain)+1.001,
	\mouseXStart, Pkey(\sustain)+0.5,
	\mouseXScale, 0,
	\pan, 0
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);


//////////////////////////


(
 ~two = Pbindef(\2,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.1,0.1],3,\cub,inf),
	\dur,1/20,
	\bufnum, Pn(Prand([~pencil[5]],inf),inf),
	\trigs, 0.001,
	\amp, 3.1,
	\rate, 1.9,
	\samp_rand_rate, 100,
	\samp_rand_range,1.001,
	\mouseXStart, 0,
	\mouseXScale, 1,
	\pan, -1
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)

(
 ~two = Pbindef(\3,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.1,0.1],3,\cub,inf),
	\dur,1/20,
	\bufnum, Pn(Prand([~pencil[5]],inf),inf),
	\trigs, 0.001,
	\amp, 0 .1,
	\rate, 1.9,
	\samp_rand_rate, 100,
	\samp_rand_range,1.001,
	\mouseXStart, 0,
	\mouseXScale, 1,
	\pan, 1
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)






///DRONE
/*
(
 ~three = Pbindef(\4,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.01,0.2],1/200,\cub,inf),
	\dur,1/100,
	\bufnum, Pn(Prand([~pencil[5]],inf),inf),
	\trigs, 0.001,
	\amp, 0.45,
	\rate, Pn(Pseg([1.7,1.71],1/200,'sin')),
	\samp_rand_rate, 100,
	\samp_rand_range,1.01,
	\mouseXStart, Pn(Pseg([0.59,0.62],1/9.7)),
	\mouseXScale, 1,
	\pan, 0
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);*/

(
 ~three = Pbindef(\5,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.1,0.1],3,\cub,inf),
	\dur,1/400,
	\bufnum, Pn(Prand([~pencil[5]],inf),inf),
	\trigs, 0.001,
	\amp, 7.2,
	\rate, Pn(Pbrown(0.25,0.26)),
	\samp_rand_rate, 100,
	\samp_rand_range,1.001,
	\mouseXStart, Pn(Pseg([0.6,0.601],1000)),
	\mouseXScale,1,
	\pan, 0
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);

(
 ~bo1 = Pbindef(\6,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.1,0.1],3,\cub,inf),
	\dur,1/400,
	\bufnum, Pn(Prand([~pencil[5]],inf),inf),
	\trigs, 0.001,
	\amp, 2.2,
	\rate, Pn(Pbrown(0.54,0.55)),
	\samp_rand_rate, 100,
	\samp_rand_range,1.001,
	\mouseXStart, 0.601,
	\mouseXScale,1,
	\pan, Pn(Pbrown(0.07,1,0.01))
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);
~bo1.stop;
(
 ~bo = Pbindef(\7,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.1,0.1],3,\cub,inf),
	\dur,1/400,
	\bufnum, Pn(Prand([~pencil[5]],inf),inf),
	\trigs, 0.001,
	\amp, 3.2,
	\rate, Pn(Pbrown(0.53,0.55)),
	\samp_rand_rate, 100,
	\samp_rand_range,1.001,
	\mouseXStart, 0.601,
	\mouseXScale,1,
	\pan, Pn(Pbrown(-1,-0.7,0.01))
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);
~bo.stop;
(
 ~eh = Pbindef(\8,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.14,0.14],3,\cub,inf),
	\dur,Pn(Pwhite(1/11,1/26)),
	\bufnum, Pn(Prand([~pencil[1]],inf),inf),
	\trigs, 0.001,
	\amp, Pn(Pbrown(0.01,0.5,0.01)),
	\rate, Pn(Pwhite(1.0,1.1)),
	\samp_rand_rate, 100,
	\samp_rand_range,1.001,
	\mouseXStart, Pn(Pseg([0.85,0.86],1000)),
	\mouseXScale,1,
	\pan, 0
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);
~eh.stop;
(
 ~hm = Pbindef(\9,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pseg([0.099,0.099],3,\cub,inf),
	\dur,1/200,
	\bufnum, Pn(Prand([~pencil[5]],inf),inf),
	\trigs, 0.001,
	\amp, 14.2,
	\rate, Pn(Pbrown(0.28,0.29)),
	\samp_rand_rate, 100,
	\samp_rand_range,1.001,
	\mouseXStart, Pn(Pseg([0.6,0.601],1000)),
	\mouseXScale,1,
	\pan, Pn(Pwhite(-0.9,1))
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);
~hm.stop;
//0.669
(
 ~v = Pbindef(\11,
	\instrument,\gabor1,
	\type, \note,
	\sustain,0.4*Pkey(\amp),
	\dur,1/300,
	\bufnum, Pn(Prand([~v0m[0]],inf),inf),
	\trigs, 0.001,
	\amp, Pn(Pseg([0.0001,0.05,1.0,0.001],[21,50,20],\exp)),
	\rate, Pn(Pseg([1.48,1.9,1.9,2.1],[20,10,60])),
	\samp_rand_rate, 100,
	\samp_rand_range,1.001,
	\mouseXStart, Pn(Pseg([0.1,0.661,0.675 ],[20,70],\lin)),
	\mouseXScale,1,
	\pan, Pn(Pwhite(-1,1))
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);


~v.stop;


(
 ~hi = Pbindef(\10,
	\instrument,\sin,
	\type, \note,
	\sustain,Pseg([0.1,0.1],3,\cub,inf),
	\dur,1/8,
	//\bufnum, Pn(Prand([~bowl[1]],inf),inf),
	\trigs, 0.001,
	\amp, Pn(Pwhite(0.01,0.05)),
	\rate, Pn(Pbrown(1.63,1.65)),
	\samp_rand_rate, 100,
	\samp_rand_range,1.01,
	\mouseXStart, 0.6,
	\mouseXScale,1,
	\pan, Pn(Pwhite(-1,1)),
	\freq, 16000
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
);


~hi.stop;



/////END OF DRONE
//meander

(
 ~elv = Pbindef(\8,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pn(Pkey(\amp))*0.09,
	\dur,1/29.4,
	\bufnum, Pn(Prand([~pencil[0]],inf),inf),
	\trigs, 0.001,
	\amp, Pn(Pseg([0.01,0.4,0.4,0.01],[30.7,200,22],'exp')),
	\rate, Pn(Pbrown(3,9)),
	\samp_rand_rate, 100,
	\samp_rand_range,1.519,
	\mouseXStart, 0.2,
	\mouseXScale, 0,
	\pan, Pn(Pwhite(-0.6,0.8))
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)
~elv.

(
 ~elv = Pbindef(\9,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pn(Pkey(\amp))*2.9,
	\dur,1/19.4,
	\bufnum, Pn(Prand([~pencil[1]],inf),inf),
	\trigs, 0.001,
	\amp, Pn(Pseg([0.01,0.06,0.06,0.01],[1.7,11,1],'exp')),
	\rate, Pn(Pbrown(1,3)),
	\samp_rand_rate, 100,
	\samp_rand_range,2.519,
	\mouseXStart, 0.2,
	\mouseXScale, 0,
	\pan, Pn(Pwhite(-1,1))
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)

(
 ~one = Pbindef(\10,
	\instrument,\gabor1,
	\type, \note,
	\sustain,0.3,
	\dur,1/29.4,
	\bufnum, Pn(Prand([~pencil[3],~pencil[2],~pencil[0]],inf),inf),
	\trigs, 0.001,
	\amp, Pn(Pseg([0.01,0.15,0.15,0.01],[1.7,11,1],'exp')),
	\rate, Pn(Pbrown(1,3)),
	\samp_rand_rate, 100,
	\samp_rand_range,2.519,
	\mouseXStart, 0.2,
	\mouseXScale, 0,
	\pan, Pn(Pbrown(-1,1))
	//\stretch, 10
	//\delta,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)