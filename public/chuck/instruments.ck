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

        8.0 => lfo.freq;
        7.0 => float depth;

        2000.0 => lpf.freq;

        0.15 => rev.mix;
        env.set(5::ms, 80::ms, 1.0, 300::ms);
        
        Std.mtof(note) => float freq;
        freq => osc.freq;
        0.2 => osc.gain;
        
        env.keyOn();
        for(0=>int i; i<50; i++){
            freq + lfo.last()*depth => osc.freq;
            Global.quarter/100.0=>now;
        }
        env.keyOff();
        for(0=>int i; i<200; i++){
            freq + lfo.last()*depth => osc.freq;
            Global.quarter/100.0=>now;
        }
    }

    fun void playPerc(int type) {
        <<< "Playing Percussion Type: " + type >>>;
        SndBuf buffer => NRev rev => dac;
        0.05 => rev.mix;
        if(type == 0) {
            "./drums/808 Kick.wav" => buffer.read;
        }
        else if(type == 1) {
            "./drums/808 snare.wav" => buffer.read;
        }
        else if(type == 2) {
            "./drums/808 CH.wav" => buffer.read;
        }
        buffer.samples() => buffer.pos;
        0 => buffer.pos;
        0.3 => buffer.gain;
        buffer.length() + 0.5::second => now;
    }
}