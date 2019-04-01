( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor2,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum,bufnum2 trigs=2000, rate1 =1, rate2 = 1, rate,time
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	/*var sigb = PlayBuf.ar(2, bufnum2, BufRateScale.kr(bufnum2)*rate*2.1, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum2)//*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	);
	*/*/
	/////Glisson Synthesis Buffer
	/*
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
	*/
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate1, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
	*MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)
	);
	//*BufFrames.kr(bufnum)*mouseXStart
		/**MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*sigb
		*/



	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	//var siga = HPF.ar(Pan2.ar(sig*env,pan),25); //NO BPF
	OffsetOut.ar(out, sigf.clip2(2));
},\ir!5).add;
);
s.quit;

//SPOOKY INTRO PRESET
(
~grainRate = 100;
~fundFreq = 0.9;
~grainSize = 0.2;
~volume = 1;
~sampleStart = 0.2;
~grainBound = 1.00;
~sampleBounds = 1.0;
~loopBound = 1.5;
~loopDuration = 10;
//\mouseXStart, Pn(Pseg([0,1],[7])),
)
(
 ~devil1 = Pbindef(\2,
	\instrument,\gabor2,
	\sustain,Pfunc{~grainSize},
	\dur,1/Pfunc{ exprand(0.9, 1.3)* ~grainRate},
	\bufnum, Pn(Prand([~slinkie[0]],inf),inf), //magnet5 experiments,~chimes[0],~mag[3]
	\bunum2, 0,
	\trigs, 0.001,
	\amp, Pfunc{~volume},
	\rate, Pfunc{~fundFreq},
	\rate1, Pfunc{~fundFreq},
	\rate2,Pfunc{~fundFreq},
	\time, 1,
	\samp_rand_rate, 120,
	\samp_rand_range,Pfunc{~grainBound}, //1.000000 - 1000  1.00001
	\mouseXStart, Pn(Pseg([0,1],[7])), //.216Pn(Pseg([0,0.8,0.5,0.1],[1.3,1/10,1/12]))
	\mouseXScale, Pfunc{~sampleBounds},
	\filterFreq, Pn(Pbrown(40,70,1)),
	\q, 14,
	\pan, 0
).play;
)
~grainRate = 100;
~fundFreq = 0.9;
~grainSize = 0.2;
~volume = 1;
~sampleStart = 0.2;
~grainBound = 1.00;
~sampleBounds = 1.0;
~loopBound = 1.5;
~loopDuration = 10;



(
 ~devil1 = Pbindef(\2,
	\instrument,\gabor2,
	\sustain,Pfunc{~grainSize},
	\dur,1/Pfunc{ exprand(0.9, 1.3)* ~grainRate},
	\bufnum, Pn(Prand([~rubber[3],~rubber[2]],inf),inf), //magnet5 experiments,~chimes[0],~mag[3]
	\bunum2, 0,
	\trigs, 0.001,
	\amp, Pfunc{~volume},
	\rate, Pfunc{~fundFreq},
	\rate1, Pfunc{~fundFreq},
	\rate2,Pfunc{~fundFreq},
	\time, 1,
	\samp_rand_rate, 120,
	\samp_rand_range,Pfunc{~grainBound}, //1.000000 - 1000  1.00001
	\mouseXStart, Pn(Pseg([0,1],250)), //.216
	\mouseXScale, Pfunc{~sampleBounds},
	\filterFreq, Pn(Pbrown(40,70,1)),
	\q, 10,
	\pan, 0
).play;
)
//preset for rubber[3] and rubber[2] simultaneosuly
(
~grainRate = 39;
~fundFreq = 1.28;
~grainSize = 0.073;
~volume = 2.23;
~sampleStart = 0.0052;
~grainBound  = 0.9998;
~sampleBounds = 0.926;
)
////////////////

(
~spin= Array.new;
~folder79 = PathName.new("/Users/jkilgore/Music/misc-samples/96k/3_27_19_littleThings-Michael/spin/");
(
~folder79.entries.do({
	arg path;
	~spin = ~spin.add(Buffer.read(s,path.fullPath));
})
));

(
~rubber = Array.new;
~folder79 = PathName.new("/Users/jkilgore/Music/misc-samples/96k/3_27_19_littleThings-Michael/rubberband/");
(
~folder79.entries.do({
	arg path;
	~rubber = ~rubber.add(Buffer.read(s,path.fullPath));
})
));
(
~slinkie = Array.new;
~folder79 = PathName.new("/Users/jkilgore/Music/misc-samples/96k/3_27_19_littleThings-Michael/slinkie/");
(
~folder79.entries.do({
	arg path;
	~slinkie = ~slinkie.add(Buffer.read(s,path.fullPath));
})
));
b = SoundFile.collect("/Users/jkilgore/Music/misc-samples/96k/3_27_19_littleThings-Michael/spin/*", s);
b.inspect;

(

OSCdef.new(
	\grainSize,
	{
		arg msg;
		if(~grainSize < 0.001) {
			~grainSize = 0.001.postln;
		} {
			if(msg[1] == 1.0) {
				~grainSize = (~grainSize + 0.001).postln;
			};

			if(msg[1] == 0) {
				~grainSize = (~grainSize - 0.001).postln;
			};
		};

	},
	'/1/encoder1'
);

OSCdef.new(
	\grainRate,
	{
		arg msg;
		msg.postln;
		if(~grainRate <= 1) {
			~grainRate = 2.postln;
		} {
			if(msg[1] == 1.0) {
				~grainRate = (~grainRate + 0.4).postln;
			};

			if(msg[1] == 0) {
				~grainRate = (~grainRate - 0.4).postln;
			};
		};

	},
	'/1/encoder2'
);

OSCdef.new(
	\sampleBounds,
	{
		arg msg;
		msg.postln;
		if(~sampleBounds < 0.002) {
			~sampleBounds = 0.002.postln;
		} {
			if(msg[1] == 1.0) {
				~sampleBounds = (~sampleBounds + 0.001).postln;
			};

			if(msg[1] == 0) {
				~sampleBounds = (~sampleBounds - 0.001).postln;
			};
		};

	},
	'/1/encoder3'
);

OSCdef.new(
	\volume,
	{
		arg msg;
		msg.postln;
		if(~volume <= 0.0001) {
			~volume = 0.0002.postln;
		} {
			if(msg[1] == 1.0) {
				~volume = (~volume + 0.01).postln;
			};

			if(msg[1] == 0) {
				~volume = (~volume - 0.01).postln;
			};
		};

	},
	'/1/encoder4'
);

OSCdef.new(
	\fundFreq,
	{
		arg msg;
		msg.postln;
		if(~fundFreq == -10001) {
			~fundFreq = 0.0002.postln;
		} {
			if(msg[1] == 1.0) {
				~fundFreq = (~fundFreq + 0.008).postln;
			};

			if(msg[1] == 0) {
				~fundFreq = (~fundFreq - 0.008).postln;
			};
		};

	},
	'/1/encoder5'
);

OSCdef.new(
	\grainBound,
	{
		arg msg;
		msg.postln;
		if(~grainBound == -10001) {
			~grainBound = 1.0002.postln;
		} {
			if(msg[1] == 1.0) {
				~grainBound = (~grainBound + 0.0001).postln;
			};

			if(msg[1] == 0) {
				~grainBound = (~grainBound - 0.0001).postln;
			};
		};

	},
	'/1/encoder6'
);

OSCdef.new(
	\sampleStart,
	{
		arg msg;
		msg.postln;
		if(~sampleStart < 0.0002) {
			~sampleStart = 0.0002.postln;
		} {
			if(msg[1] == 1.0) {
				~sampleStart = (~sampleStart + 0.001).postln;
			};

			if(msg[1] == 0) {
				~sampleStart = (~sampleStart - 0.001).postln;
			};
		};

	},
	'/1/encoder7'
);

OSCdef.new(
	\loopBound,
	{
		arg msg;
		msg.postln;
		if(~loopBound < 1.1) {
			~loopBound = 1.1.postln;
		} {
			if(msg[1] == 1.0) {
				~loopBound = (~loopBound + 0.1).postln;
			};

			if(msg[1] == 0) {
				~loopBound = (~loopBound - 0.1).postln;
			};
		};

	},
	'/1/encoder8'
);

OSCdef.new(
	\loopDuration,
	{
		arg msg;
		msg.postln;
		if(~loopDuration < 0.01) {
			~loopDuration = 0.05.postln;
		} {
			if(msg[1] == 1.0) {
				~loopDuration = (~loopDuration + 0.01).postln;
			};

			if(msg[1] == 0) {
				~loopDuration = (~loopDuration - 0.01).postln;
			};
		};

	},
	'/1/encoder9'
);

)