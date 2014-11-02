#include "SC_PlugIn.h"
#include <math.h>

//  Created by So Oishi on 30/10/14.


// BASIC ADMINISTRATION

static InterfaceTable *ft;

struct GravAtanOsc : public Unit
{
    float displacement;
    float velocity;
    float acceleration;
};

// declare unit generator functions
extern "C"
{
    void GravAtanOsc_Ctor(GravAtanOsc *unit);
    void GravAtanOsc_next(GravAtanOsc *unit, int inNumSamples);
};

//////////////////////////////////////////////////////////////////

// CONSTRUCTOR

void GravAtanOsc_Ctor(GravAtanOsc *unit)
{
    SETCALC(GravAtanOsc_next);

    unit->displacement = ZIN0(0);
    unit->velocity = ZIN0(1);
    unit->acceleration = ZIN0(2);

    GravAtanOsc_next(unit, 1);
}

//////////////////////////////////////////////////////////////////

// UGEN CALCULATION

void GravAtanOsc_next(GravAtanOsc *unit, int inNumSamples)
{
    float *out = ZOUT(0);
    
    float displacement = unit->displacement;
    float velocity = unit->velocity;
    float acceleration = unit->acceleration;
    float accelerationCoef = ZIN0(3);
    float atanCoef = ZIN0(4);
    
    LOOP(inNumSamples,
          acceleration = -accelerationCoef * atan(atanCoef*displacement);
          velocity = velocity + (acceleration / SAMPLERATE);
          displacement = displacement + (velocity / SAMPLERATE);
          ZXP(out) = displacement;
         )
    unit->displacement = displacement;
    unit->velocity = velocity;
    unit->acceleration = acceleration;
}

////////////////////////////////////////////////////////////////////

// LOAD FUNCTION

// the load function is called by the host when the plugin is loaded
// Unless the flag for STATIC_PLUGINS is on, the argument (PB_SINE) does not seem to matter
// it can also be omitted (except when STATIC-PLUGINS are desired)

PluginLoad(GravAtanOsc)
{
    ft = inTable;
    
    DefineSimpleUnit(GravAtanOsc);
}

////////////////////////////////////////////////////////////////////

