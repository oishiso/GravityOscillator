(
~openAnalyzer = {
var window, func;
window = Window("Analyzer", Rect(600, 30, 511, 300)); // width should be 511
func = FreqScopeView(window, window.view.bounds);
func.active_(true); // turn it on the first time;
func.freqMode_(1); //log scale
window.onClose_({ func.kill }); // you must have this
window.front;
}.value
)

{GravAtanOsc.ar(accelerationCoef: 500000.0, atanCoef: 1.0)}.scope
{GravAtanOsc.ar(accelerationCoef: 500000.0, atanCoef: 10.0)}.scope
{GravAtanOsc.ar(accelerationCoef: 500000.0, atanCoef: 100.0)}.scope
{GravAtanOsc.ar(accelerationCoef: 500000.0, atanCoef: 100000.0)}.scope //not much difference anymore

{GravAtanOsc.ar(accelerationCoef: 10000000.0, atanCoef: 0.1)}.scope
{GravAtanOsc.ar(accelerationCoef: 10000000.0, atanCoef: 1.0)}.scope
{GravAtanOsc.ar(accelerationCoef: 10000000.0, atanCoef: 10.0)}.scope //make atanCoef bigger than 50.0 makes it unstable condition


// Compare the following sound
{SinOsc.ar(freq: 440, phase: 0, mul: 0.5, add: 0)}.play
{LFPar.ar(freq: 440, iphase: 0, mul: 0.5, add: 0)}.play //Paravollic waveform has triangle wave like sound quality. It has odd harmonics.
{LFTri.ar(freq: 440, iphase: 0, mul: 0.5, add: 0)}.play
{Pulse.ar(freq: 440, width: 0.5, mul: 0.5, add: 0)}.play


(
SynthDef(\gravAtanOscTest,
	{arg displacement = 0.5,
		velocity = 0.0,
		acceleration = 0.0,
		accelerationCoef = 1000000.0,
		atanCoef = 10.0,
		mul = 1.0,
		add = 0.0;
		var sound = GravAtanOsc.ar(displacement, velocity, acceleration, accelerationCoef, atanCoef, mul, add).scope;
		Out.ar(0, sound)}).load
)

Synth(\gravAtanOscTest)



