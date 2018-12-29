///Order confusion with sounds in fast succession
//notice perception bias based off if you start at obviously percieved lag
//or start at the ara below threshold of lag
//explantion written in margins of microsound on page 25
(
//a simple percussive envelope
SynthDef(\percSin, {|out,amp=0.1,freq=440,sustain=0.1,
	pan|
	var snd = FSinOsc.ar(freq);
	var env = EnvGen.ar(
		Env.perc(0.1,0.9,amp),timeScale:sustain,
		doneAction:2);
	OffsetOut.ar(out,Pan2.ar(snd*env,pan));
}, \ir!5).add;
)
(
Pbindef(\hi,
	\instrument,\percSin, \sustain,0.05,
	\freq,870, \amp,0.2, \dur,1, \lag,0
).play;
Pbindef(\lo,
	\instrument,\percSin, \sustain,0.05,
	\freq,240, \amp,0.1, \dur,1, \lag,0
).play;
)

//try different lag times between them
Pbindef(\hi, \lag,0.1);
Pbindef(\hi, \lag,0.03);
Pbindef(\hi, \lag,0.01);
Pbindef(\hi, \lag,0.001);


//hi too early or too late by a fixed time -
// which one is first?
Pbindef(\hi, \lag, ([-1,1].choose*0.01).postln).play;
Pbindef(\hi, \lag,([-1,1].choose*0.03).postln).play;
//
//is it easier to here when sounds panned apart
Pbindef(\hi,\pan,1); Pbindef(\lo,\pan,-1);
Pbindef(\hi, \pan,-1); Pbindef(\lo,\pan,1);



///Order confusion with sounds in fast succession
//notice perception bias based off if you start at obviously percieved lag
//or start at the ara below threshold of lag
//explantion written in margins of microsound on page 25
(
//a simple percussive envelope
SynthDef(\percSin, {|out,amp=0.1,freq=440,sustain=0.1,
	pan|
	var snd = FSinOsc.ar(freq);
	var env = EnvGen.ar(
		Env.perc(0.1,0.9,amp),timeScale:sustain,
		doneAction:2);
	OffsetOut.ar(out,Pan2.ar(snd*env,pan));
}, \ir!5).add;
)
(
Pbindef(\hi,
	\instrument,\percSin, \sustain,0.05,
	\freq,870, \amp,0.2, \dur,1, \lag,0
).play;
Pbindef(\lo,
	\instrument,\percSin, \sustain,0.05,
	\freq,240, \amp,0.1, \dur,1, \lag,0
).play;
)

//try different lag times between them
Pbindef(\hi, \lag,0.1);
Pbindef(\hi, \lag,0.03);
Pbindef(\hi, \lag,0.01);
Pbindef(\hi, \lag,0.001);


//hi too early or too late by a fixed time -
// which one is first?
Pbindef(\hi, \lag, ([-1,1].choose*0.01).postln).play;
Pbindef(\hi, \lag,([-1,1].choose*0.03).postln).play;
//
//is it easier to here when sounds panned apart
Pbindef(\hi,\pan,1); Pbindef(\lo,\pan,-1);
Pbindef(\hi, \pan,-1); Pbindef(\lo,\pan,1);


//Perception of pitch dependent on frequency experiment
//see microsound page 24

(//a gabor grain, gaussian-shaped env
SynthDef(\gabor, {|out, freq=440,sustain=1,pan,amp=0.1,
	width=0.25|
	var env =
	LFGauss.ar(sustain,width,loop:0,doneAction:2);
	var son = SinOsc.ar(freq,0,env);
	OffsetOut.ar(out,Pan2.ar(son,pan,amp));
},\ir!6).add;
)
(
Pbindef(\grain,
	\instrument, \gabor, \freq,200,
	\dur,1, \sustain,15/1000, \amp,0.9
).play;
)


///musical experiments
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
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\sustain,0.02,
	\dur,0.03,
	\bufnum, Pn(Prand([~mag[1]],inf),inf), //magnet5 experiments
	\trigs, 0.001,
	\amp, 20.1,
	\rate, 0.7,
	\samp_rand_rate, 100,
	\samp_rand_range,2.6,
	\mouseXStart, 0,
	\mouseXScale, 1,
	//\filterFreq, Pn(Pfunc({~test})),
	//\q, 0.01
).play;
)