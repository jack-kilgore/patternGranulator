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
