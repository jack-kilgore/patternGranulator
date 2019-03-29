(
~devil= Array.new;
~folder79 = PathName.new("/Users/jkilgore/Music/misc-samples/96k/DevilDam-ForrestMichael/");
(
~folder79.entries.do({
	arg path;
	~devil = ~devil.add(Buffer.read(s,path.fullPath));
})
));

(
~house= Array.new;
~folder7 = PathName.new("/Users/jkilgore/Music/misc-samples/96k/3_27_19_littleThings-Michael/");
(
~folder7.entries.do({
	arg path;
	~house = ~house.add(Buffer.read(s,path.fullPath));
})
));

(
( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1GlissonBPF,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate1 =1, rate2 = 1, time
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
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
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	//var sigf = BPF.ar(HPF.ar(Pan2.ar(sig*env,pan),25),filterFreq,q);
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	siga = LPF.ar(siga,10000);
	OffsetOut.ar(out, siga);
},\ir!5).add;
);
)

( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor2,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum,bufnum2 trigs=2000, rate1 =1, rate2 = 1, rate,time
	samp_rand_rate = 1, samp_rand_range = 2, mouseXScale = 1, mouseXStart = 0, filterFreq=440,q = 1.0|
	var f = {(mouseXStart)*(BufFrames.kr(bufnum))};
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sigb = PlayBuf.ar(2, bufnum2, BufRateScale.kr(bufnum2)*rate*2.1, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)
		* BufFrames.kr(bufnum2)//*mouseXStart

		/* *MouseX.kr(f.value,
			((BufFrames.kr(bufnum)-f.value)
				*mouseXScale)
			+ f.value)*/
	);
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
	var siga = HPF.ar(Pan2.ar(sig*env,pan),25);
	sigf = sigf;
	//sigf = sigf;
	OffsetOut.ar(out, sigf.clip2(2));
},\ir!5).add;
);
a = Buffer.read(s, "/Users/jkilgore/Music/misc-samples/voiceSketches/slurp/2.slurp96k.wav");
(
~grainRate = 100;
~fundFreq = 1.0;
~grainSize = 0.2;
~volume =2;
~sampleStart = 0.001;
~grainBound = 1.01;
~sampleBounds = 1;
~loopBound = 1.5;
~loopDuration = 10;
)
(
 ~devil1 = Pbindef(\2,
	\instrument,\gabor2,
	\sustain,Pfunc{~grainSize},
	\dur,1/(Pfunc{~grainRate}),
	\bufnum, Pn(Prand([~house[8]],inf),inf), //magnet5 experiments,~chimes[0],~mag[3]
	\bunum2, Pn(Prand([~devil[2],~devil[2]],inf),inf),
	\trigs, 0.001,
	\amp, Pfunc{~volume},
	\rate, Pfunc{~fundFreq},
	\rate1, Pfunc{~fundFreq},
	\rate2,Pfunc{~fundFreq},
	\time, 1,
	\samp_rand_rate, 120,
	\samp_rand_range,Pfunc{~grainBound}, //1.000000 - 1000  1.00001
	\mouseXStart, Pfunc{~sampleStart}, //.216
	\mouseXScale, Pfunc{~sampleBounds},
	\filterFreq, Pn(Pbrown(40,70,1)),
	\q, 10,
	\pan, 0
).play;
)
s.reboot;
s.quit;




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
				~grainRate = (~grainRate + 1).postln;
			};

			if(msg[1] == 0) {
				~grainRate = (~grainRate - 1).postln;
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
				~fundFreq = (~fundFreq + 0.01).postln;
			};

			if(msg[1] == 0) {
				~fundFreq = (~fundFreq - 0.01).postln;
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
s.quit;
(

w = Window("Audio Microscope", Rect(
	Window.screenBounds.width/1.38,
	Window.screenBounds.height/1.9,
	500,
	400
))
.front
.alwaysOnTop_(true);

~s0 = Slider(w,Rect(20,20,150,30))
.background_(Color(88/255,127/255,188/255))
.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,1,800).postln;
	~rate = cf;
});
~s1 = Slider(w,Rect(20,50,150,30))
.background_(Color(88/255,127/255,188/255))
.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.01,5).postln;
	~freq = cf;
});
~s2 = Slider(w,Rect(20,80,150,30))
.background_(Color(88/255,127/255,188/255))
.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.001,1).postln;
	~sustain = cf;
});
~s3 = Slider(w,Rect(20,110,150,30))
.background_(Color(88/255,127/255,188/255))
.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.0001,6).postln;
	~volume = cf;
});
~s4 = Slider(w,Rect(20,140,150,30))
.background_(Color(88/255,127/255,188/255))
.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0,1).postln;
	~time = cf;
});
~s5 = Slider(w,Rect(20,170,150,30))
.background_(Color(88/255,127/255,188/255))
.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,1.0001,1.5).postln;
	~rand = cf;
});

MIDIFunc.cc({ |ccval, cn,chan,src|
	~grainRate= (ccval.linexp(0,127,1,800)).postln;
},6);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~freq= (ccval.linexp(0,127,0.4,5)).postln;
},7);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~grainSize= (ccval.linexp(0,127,0.001,1)).postln;
},8);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~volume= (ccval.linexp(0,127,0.001,6)).postln;
},9);
/*
MIDIFunc.cc({ |ccval, cn,chan,src|
	~time= (ccval.linexp(0,127,0,1)).postln;
},2);
*/
MIDIFunc.cc({ |ccval, cn,chan,src|
	~rand= (ccval.linexp(0,127,1.0001,1.5)).postln;
},5);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~scale= (ccval.linlin(0,127,0.001,1.0)).postln;
},3);
)
MIDIIn.connectAll;

s.reboot;
