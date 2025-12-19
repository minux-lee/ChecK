import { Chuck } from 'webchuck';
import type { MusicalMode, Role, Direction } from '../game/types';

class AudioEngine {
    public chuck: Chuck | null = null;
    public isReady: boolean = false;

    async init() {
        if (this.chuck) return;

        try {
            this.chuck = await Chuck.init([]);

            await Promise.all([
                this.chuck.loadFile('./chuck/global.ck'),
                this.chuck.loadFile('./chuck/instruments.ck'),
                this.chuck.loadFile('./chuck/main.ck'),
                this.chuck.loadFile('./chuck/drums/808 Kick.wav'),
                this.chuck.loadFile('./chuck/drums/808 snare.wav'),
                this.chuck.loadFile('./chuck/drums/808 CH.wav')
            ]);

            this.chuck.runFile('global.ck');
            this.chuck.runFile('instruments.ck');
            this.chuck.runFile('main.ck');

            this.setupTickListener();

            this.isReady = true;
            console.log('Audio Engine Ready');
        } catch (e) {
            console.error('Audio Engine Init Failed:', e);
        }
    }

    private setupTickListener() {
        if (!this.chuck) return;
    }

    public triggerInstrument(
        beat: number,
        mode: MusicalMode,
        x: number,
        y: number,
        inst: Role,
        dir: Direction,
        length: number
    ) {
        const code = `
            Instruments inst_obj;
            inst_obj.onTick(
                ${beat},
                "${mode}",
                ${x},
                ${y},
                "${inst}",
                "${dir}",
                ${length}
            );
        `;
        this.runCode(code);
    }

    public setBPM(bpm: number) {
        this.runCode(`${bpm} => Global.bpm; updateTiming();`);
    }

    private runCode(code: string) {
        if (this.chuck && this.isReady) {
            this.chuck.runCode(code);
        }
    }
}

export const audioEngine = new AudioEngine();