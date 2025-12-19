public class Instruments {

    fun void playBass(float note, int mix, int md) {
        <<< "Playing Bass Note: " + note >>>;
        if(md==0){
            SinOsc osc => LPF filter => ADSR env => dac;
            
            env.set(10::ms, 200::ms, Math.min(0.1*(mix-1),1.0), 100::ms);
            0.7 => osc.gain;
            
            400.0 => filter.freq;
            
            Std.mtof(note - 12.0) => osc.freq;
            
            env.keyOn();
            Global.quarter => now;
            env.keyOff();
            100::ms => now;            
        }
        else if(md==1){
            SawOsc osc => LPF lpf => ADSR env => dac;
            SawOsc oscu => lpf;

            env.set(250::ms, 200::ms, Math.min(0.1*(mix-1),1.0), 100::ms);
            0.2 => osc.gain;
            0.2 => oscu.gain;
            500 => lpf.freq;

            Std.mtof(note - 12.0) => osc.freq;
            Std.mtof(note - 12.1) => oscu.freq;


            env.keyOn();
            Global.quarter => now;
            env.keyOff();
            100::ms => now;
        }
        else if(md==2){
            SqrOsc osc => ADSR env => dac;
            env.set(10::ms, 200::ms, Math.min(0.1*(mix-1),1.0), 100::ms);
            0.3 => osc.gain;
            Std.mtof(note-12.0)=>osc.freq;
            env.keyOn();
            Global.quarter => now;
            env.keyOff();
            100::ms => now; 
        }
        else if(md==3){
            Rhodey osc => NRev rev => dac;
            0.5=>osc.gain;
            0.03*(mix-1.0) => rev.mix;
            Std.mtof(note)=>osc.freq;
            osc.noteOn(0.5);
            Global.quarter=>now;
            osc.noteOff(0.5);
            Global.quarter=>now;
        }
    }

    fun void playPad(float note, float velocity, int mix, int md) {
        <<< "Playing Pad Note: " + note + " with velocity: " + velocity >>>;
        if(md==0){
            SawOsc osc1 => ADSR env => LPF lpf => NRev verb => dac;
            SawOsc osc2 => env;
            SawOsc osc3 => env;
            
            0.15 => verb.mix;
            env.set(100::ms, 200::ms, 0.7, 100::ms);

            1000.0 => lpf.freq;
            
            Std.mtof(note) => osc1.freq;
            velocity * 0.15 => osc1.gain;
            Std.mtof(note+0.02*(mix-1)) => osc2.freq;
            velocity * 0.15 => osc2.gain;
            Std.mtof(note-0.02*(mix-1)) => osc3.freq;
            velocity * 0.15 => osc3.gain;
            
            env.keyOn();
            Global.quarter*1.5 => now;
            env.keyOff();
            Global.quarter*2.0 => now;
        }
        else if(md==1){
            SawOsc osc1 => ADSR env => LPF lpf => NRev verb => dac;
            SawOsc osc2 => env;
            SawOsc osc3 => env;
            
            0.15 => verb.mix;
            env.set(200::ms, 100::ms, 0.4, 100::ms);

            1000.0 => lpf.freq;
            
            Std.mtof(note+12.0) => osc1.freq;
            velocity * 0.15 => osc1.gain;
            Std.mtof(note+12.0+0.02*(mix-1)) => osc2.freq;
            velocity * 0.15 => osc2.gain;
            Std.mtof(note+12.0-0.02*(mix-1)) => osc3.freq;
            velocity * 0.15 => osc3.gain;
            
            env.keyOn();
            Global.quarter*1.9 => now;
            env.keyOff();
            Global.quarter*2.0 => now;
        }
        else if(md==2){
            SqrOsc osc => ADSR env => dac;
            env.set(10::ms, 100::ms, 0.5, 50::ms);
            Std.mtof(note)=>osc.freq;
            0.2=>osc.gain;
            env.keyOn();
            Global.quarter*0.45 => now;
            env.keyOff();
            Global.quarter*0.05 => now;

            0.02*mix=>osc.gain;

            env.keyOn();
            Global.quarter*1.4 => now;
            env.keyOff();
            Global.quarter/2.0 => now;
        }
        else if(md==3){
            Rhodey osc => NRev rev => dac;
            0.5=>osc.gain;
            0.03*(mix-1.0) => rev.mix;
            Std.mtof(note+12.0)=>osc.freq;
            osc.noteOn(0.5);
            Global.quarter=>now;
            osc.noteOff(0.5);
            Global.quarter=>now;
        }
    }

    fun void playLead(float note, float mix, int md, float susl) {
        <<< "Playing Lead Note: " + note >>>;
        if(md==0||md==2){
            SqrOsc osc => LPF lpf => ADSR env => NRev rev => dac;
            SinOsc lfo => blackhole;

            8.0 => lfo.freq;
            3.0 => float depth;

            2000.0 => lpf.freq;

            0.03*(mix-1.0) => rev.mix;
            env.set(5::ms, 80::ms, 1.0, 300::ms);
            
            Std.mtof(note+12.0) => float freq;
            freq => osc.freq;
            0.2 => osc.gain;
            
            env.keyOn();
            for(0=>int i; i<90.0*susl; i++){
                freq + lfo.last()*depth => osc.freq;
                Global.quarter/100.0=>now;
            }
            env.keyOff();
            for(0=>int i; i<200; i++){
                freq + lfo.last()*depth => osc.freq;
                Global.quarter/100.0=>now;
            }
        }
        else if(md==1){
            Flute osc => LPF lpf => NRev rev => dac;
            2000.0 => lpf.freq;
            0.3 => osc.gain;
            Std.mtof(note+12.0) => osc.freq;
            0.03*(mix-1.0) => rev.mix;

            1=>osc.noteOn;
            Global.quarter*susl => now;
            1=>osc.noteOff;
            100::ms => now;
        }
        else if(md==3){
            Rhodey osc => NRev rev => dac;
            0.5=>osc.gain;
            0.03*(mix-1.0) => rev.mix;
            Std.mtof(note+24.0)=>osc.freq;
            osc.noteOn(0.5);
            Global.quarter=>now;
            osc.noteOff(0.5);
            Global.quarter=>now;
        }
    }

    fun void playPerc(int type, int mix, int md) {
        <<< "Playing Percussion Type: " + type >>>;
        if(md == 0||md == 3){
            SndBuf buffer => NRev rev => dac;
            0.02*(mix - 1) => rev.mix;
            if(type == 0) {
                "808 Kick.wav" => buffer.read;
            }
            else if(type == 1) {
                "808 snare.wav" => buffer.read;
            }
            else if(type == 2) {
                "808 CH.wav" => buffer.read;
            }
            buffer.samples() => buffer.pos;
            0 => buffer.pos;
            0.1 => buffer.gain;
            buffer.length() + 0.5::second => now;
        }
        else if(md == 1){
            SndBuf buffer => NRev rev => dac;
            0.02*(mix - 1) => rev.mix;
            if(type == 0) {
                "TympC.wav" => buffer.read;
            }
            else if(type == 1) {
                "TympG.wav" => buffer.read;
            }
            else if(type == 2) {
                "TympF.wav" => buffer.read;
            }
            else if(type == 3) {
                "Cymb.wav" => buffer.read;
            }
            else if(type == 4) {
                "Tria.wav" => buffer.read;
            }
            buffer.samples() => buffer.pos;
            0 => buffer.pos;
            0.5 => buffer.gain;
            buffer.length() + 0.5::second => now;
        }
        else if(md == 2){
            if(type == 0){
                SinOsc osc => ADSR env => Gain g => dac;

                env.set(
                    2::ms,   // attack
                    30::ms,  // decay
                    0.0,     // sustain
                    10::ms   // release
                );

                0.9 => g.gain;

                env.keyOn();

                90 => float f;
                for (0 => int i; i < 15; i++)
                {
                    f => osc.freq;
                    f - 4 => f;
                    2::ms => now;
                }

                env.keyOff();
                40::ms => now;
            }
            else if(type == 1){
                Noise n => ADSR nEnv => Gain ng => dac;
                SqrOsc body => ADSR bEnv => Gain bg => dac;

                nEnv.set(1::ms, 40::ms, 0.0, 20::ms);
                bEnv.set(2::ms, 60::ms, 0.0, 30::ms);

                0.6 => ng.gain;
                0.25 => bg.gain;
                200 => body.freq;

                nEnv.keyOn();
                bEnv.keyOn();

                70::ms => now;

                nEnv.keyOff();
                bEnv.keyOff();

                50::ms => now;
            }
            else if(type == 2){
                Noise n => HPF hpf => ADSR env => Gain g => dac;

                9000 => hpf.freq;
                0.35 => g.gain;

                env.set(
                    1::ms,
                    15::ms,
                    0.0,
                    5::ms
                );

                env.keyOn();
                20::ms => now;
                env.keyOff();
                10::ms => now;
            }
        }
    }

    fun void onTick(int beatCount, string mode, int x, int y, string instrument, string dir, int length) {
        <<< "Tick: " + beatCount + " Instrument: " + mode + instrument + " Position: (" + x + "," + y + ") Direction: " + dir + " Length: " + length >>>;
        int d_i;
        if(dir == "UP") 0 => d_i;
        else if(dir == "DOWN") 1 => d_i;
        else if(dir == "RIGHT") 2 => d_i;
        else if(dir == "LEFT") 3 => d_i;
        
        if(mode == "ARABIC"){
            if(instrument == "BASS"){
                [45,45,52,57,50,50,57,62]@=>int Notes[];
                playBass(Notes[((beatCount % 8)/4)*4 + d_i], length, 0);
            }
            else if(instrument == "PAD"){
                [45,49, 49,52, 45,52, 49,57, 50,53, 53,57, 50,57, 53,62] @=> int Notes[];
                if(beatCount % 2 == 0){
                    spork ~ playPad(Notes[((beatCount % 8)/4)*8 + ((x + y)%4)*2], 1.0, length, 0);
                    playPad(Notes[((beatCount % 8)/4)*8 + ((x + y)%4)*2 + 1], 1.0, length, 0);
                }
            }
            else if(instrument == "LEAD"){
                [57, 58, 61, 62, 64, 65, 68, 69]@=>int Notes[];
                spork ~ playLead(Notes[x], length, 0, 0.5);
                Global.quarter/2.0 => now;
                playLead(Notes[y], length, 0, 0.5);
            }
            else if(instrument == "PERC"){
                [0,1,2]@=>int Notes[];
                spork~playPerc(Notes[beatCount % 2], length, 0);
                Global.quarter/2.0 => now;
                if(d_i%2==0){
                    spork~playPerc(Notes[2], length, 0);
                    Global.quarter/4.0 => now;
                    playPerc(Notes[2], length, 0);
                }
                else{
                    playPerc(Notes[2], length, 0);
                }
                
            }
        }

        if(mode == "ORCHESTRAL"){
            if(instrument == "BASS"){
                [36, 36, 43, 48,
                41, 41, 48, 53,
                43, 43, 50, 55,
                36, 36, 43, 48] @=> int Notes[];
                playBass(Notes[((beatCount % 16)/4)*4 + d_i], length, 1);
            }
            else if(instrument == "PAD"){
                [48, 51, 51, 55, 48, 55, 51, 60,
                53, 56, 56, 60, 53, 60, 56, 65,
                55, 59, 59, 62, 55, 62, 59, 67,
                48, 51, 51, 55, 48, 55, 51, 60]
                @=> int Notes[];
                if(beatCount % 2 == 0){
                    spork ~ playPad(Notes[((beatCount % 16)/4)*8 + ((x + y)%4)*2], 1.0, length, 1);
                    playPad(Notes[((beatCount % 16)/4)*8 + ((x + y)%4)*2 + 1], 1.0, length, 1);
                }
            }
            else if(instrument == "LEAD"){
                [60, 62, 63, 65, 67, 68, 71, 72]@=>int Notes[];
                if((x+y)%3==0){
                    spork ~ playLead(Notes[x], length, 1, 0.5);
                    Global.quarter/2.0 => now;
                    playLead(Notes[y], length, 1, 0.5);                    
                }
                else{
                    playLead(Notes[x], length, 1, 1.0);
                }

            }
            else if(instrument == "PERC"){
                [0,2,1,0]@=>int Notes[];
                if(beatCount % 2 == 0){
                    spork~playPerc(Notes[((beatCount % 16)/4)], length, 1);
                    if(d_i == 0) spork~playPerc(3, length, 1);
                    Global.quarter*2.0 => now;
                }
                else{
                    if(d_i % 2 == 0){
                        playPerc(4, length, 1);
                    }
                    else{
                        spork~playPerc(4, length, 1);
                        Global.quarter/2.0 => now;
                        playPerc(4, length, 1);
                    }
                }
                
            }
        }

        if(mode == "EIGHT_BIT"){
            if(instrument == "BASS"){
                [43,43,50,55, 45,45,50,57, 43,43,49,54, 47,47,54,59]@=>int Notes[];
                playBass(Notes[((beatCount % 16)/4)*4 + d_i], length, 2);
            }
            else if(instrument == "PAD"){
                [55,59,59,62,59,66,62,66,
                57,61,61,64,61,67,64,67,
                54,57,57,61,57,64,61,64,
                59,62,62,66,62,69,66,69] @=> int Notes[];
                if(beatCount % 2 == 0){
                    spork ~ playPad(Notes[((beatCount % 16)/4)*8 + ((x + y)%4)*2], 1.0, length, 2);
                    playPad(Notes[((beatCount % 16)/4)*8 + ((x + y)%4)*2 + 1], 1.0, length, 2);
                }
            }
            else if(instrument == "LEAD"){
                [62, 64, 66, 69, 71, 73, 74, 76]@=>int Notes[];
                if((x+y)%3==0){
                    spork ~ playLead(Notes[x], length, 2, 0.5);
                    Global.quarter/2.0 => now;
                    playLead(Notes[y], length, 2, 0.5);                    
                }
                else{
                    playLead(Notes[x], length, 2, 1.0);
                }
            }
            else if(instrument == "PERC"){
                [0,1,2]@=>int Notes[];
                spork~playPerc(Notes[beatCount % 2], length, 2);
                Global.quarter/2.0 => now;
                if(d_i%2==0){
                    spork~playPerc(Notes[2], length, 2);
                    Global.quarter/4.0 => now;
                    playPerc(Notes[2], length, 2);
                }
                else{
                    playPerc(Notes[2], length, 2);
                }
                
            }            
        }

        if(mode == "PIANO"){
            if(instrument == "BASS"){
                [45,47,49,51,53,55,57]@=>int Notes[];
                playBass(Notes[(x+y)%4 + d_i], length, 3);
            }
            else if(instrument == "PAD"){
                if(beatCount % 2 == 0){
                    spork ~ playPad(45+(x+y)*2, 1.0, length, 3);
                    playPad(45+(x+y)*2 + 4, 1.0, length, 3);
                }
            }
            else if(instrument == "LEAD"){
                [45,47,49,51,53,55,57,59]@=>int Notes[];
                spork ~ playLead(Notes[x], length, 3, 0.5);
                Global.quarter/4.0 => now;
                spork ~ playLead(Notes[y], length, 3, 0.5);
                Global.quarter/4.0 => now;
                spork ~ playLead(Notes[x]+(1 - (d_i%2)*2)*2, length, 3, 0.5);
                Global.quarter/4.0 => now;
                spork ~ playLead(Notes[y]+(1 - (d_i%2)*2)*2, length, 3, 0.5);
                Global.quarter/4.0 => now;
            }
            else if(instrument == "PERC"){
                [0,1,2]@=>int Notes[];
                spork~playPerc(Notes[beatCount % 2], length, 3);
                Global.quarter/2.0 => now;
                if(d_i%2==0){
                    spork~playPerc(Notes[2], length, 3);
                    Global.quarter/4.0 => now;
                    playPerc(Notes[2], length, 3);
                }
                else{
                    playPerc(Notes[2], length, 3);
                }
                
            }
        }
    }
}