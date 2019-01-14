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
~rate = 2;
~scale = 0.001;
);

s.quit;
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
~rate=1.3;
 ~one = Pbindef(\1,
	\instrument,\gabor1,
	\type, \note,
	\sustain,Pstep([0.016,0.016,0.017,0.017,0.004,0.03,0.05,0.001,0.001,0.001,0.1],1/4,inf),
	\dur,Pn(Pgeom(1/4.7,0.99,18),inf),
	\bufnum, Pn(Prand([~chimes[1]],inf),inf),
	\trigs, 0.001,
	\amp, 3.1,
	\rate, Pstep([1,9,1.07,1.04,0.1,4.005,10.7,0.17,-0.1,0.3,-0.3,0.05],1/Pfunc{~rate},inf),              //[Pfunc{~rate},
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
q

MIDIIn.connectAll;
MIDIIn.disconnectAll;

(

(
MIDIFunc.cc({ |ccval, cn,chan,src|
	if(ccval == 1,
		{ ~rotary = ccval* ~scale},
		{~rotary = (ccval/(-127))* ~scale}
	);
	~rate = ~rate + ~rotary;
	["~rotary"+ ~rate].postln;
},1);
);


(
MIDIFunc.noteOn({ |ccval, cn,chan,src|
	~scale = ~scale * 10;
	["~rotary_scale"+ ~scale].postln;
},9);
);

(
MIDIFunc.noteOn({ |ccval, cn,chan,src|
	~scale = ~scale /10;
	["~rotary_scale"+ ~scale].postln;
},10);
);
//kill it before you execute it again; does not override previous setting; just runs parallel to them

)

