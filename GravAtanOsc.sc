GravAtanOsc : PureUGen  {
	*ar { arg displacement = 0.5, velocity = 0.0, acceleration = 0.0, accelerationCoef = 100000000.0, atanCoef = 10.0, mul = 1.0, add = 0.0;
		^this.multiNew('audio', displacement, velocity, acceleration, accelerationCoef, atanCoef).madd(mul, add)
	}
	*kr { arg displacement = 0.5, velocity = 0.0, acceleration = 0.0, accelerationCoef = 100000000.0, atanCoef = 10.0, mul = 1.0, add = 0.0;
		^this.multiNew('control', displacement, velocity, acceleration, accelerationCoef, atanCoef).madd(mul, add)
	}
}


