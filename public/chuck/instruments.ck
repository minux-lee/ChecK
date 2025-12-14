public class Instruments {
    
    fun void playBass(float note) {
        <<< "Playing Bass Note: " + note >>>;
        SinOsc osc => LPF filter => ADSR env => dac;
        
        env.set(10::ms, 200::ms, 0.6, 100::ms);
        
        400.0 => filter.freq;
        
        Std.mtof(note - 12.0) => osc.freq;
        
        env.keyOn();
        200::ms => now;
        env.keyOff();
        100::ms => now;
    }

    fun void playPad(float note, float velocity) {
        <<< "Playing Pad Note: " + note + " with velocity: " + velocity >>>;
        SawOsc osc1 => ADSR env => LPF lpf => NRev verb => dac;
        SawOsc osc2 => env;
        SawOsc osc3 => env;
        
        0.15 => verb.mix;
        env.set(300::ms, 200::ms, 0.5, 600::ms);

        1000.0 => lpf.freq;
        
        Std.mtof(note) => osc1.freq;
        velocity * 0.15 => osc1.gain;
        Std.mtof(note+0.1) => osc2.freq;
        velocity * 0.15 => osc2.gain;
        Std.mtof(note-0.3) => osc3.freq;
        velocity * 0.15 => osc3.gain;
        
        env.keyOn();
        Global.quarter => now;
        env.keyOff();
        Global.quarter*2.0 => now;
    }

    fun void playLead(float note) {
        <<< "Playing Lead Note: " + note >>>;
        SqrOsc osc => LPF lpf => ADSR env => NRev rev => dac;
        SinOsc lfo => blackhole;

        2000.0 => lpf.freq;

        0.15 => rev.mix;
        env.set(5::ms, 80::ms, 1.0, 300::ms);
        
        Std.mtof(note) => float freq;
        freq => osc.freq;
        0.2 => osc.gain;
        
        env.keyOn();
        Global.quarter/2.0 => now;
        env.keyOff();
        Global.quarter*2 => now;
    }

    fun void playPerc(int type) {
        <<< "Playing Percussion Type: " + type >>>;
        if(type == 0) {
            SinOsc osc => ADSR env => dac;
            env.set(2::ms, 50::ms, 0.0, 10::ms);
            60.0 => osc.freq;
            env.keyOn();
            100::ms => now;
        }
        else if(type == 1) {
            Noise n => LPF f => ADSR env => dac;
            1200 => f.freq;
            env.set(2::ms, 80::ms, 0.0, 10::ms);
            0.4 => n.gain;
            env.keyOn();
            100::ms => now;
        }
    }
}