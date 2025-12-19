import { useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import clsx from 'clsx';
import { useGameStore } from './store/useStore';
import { Board } from './components/Board';
import { AboutSection } from './components/AboutSection';
import { loadModel } from './ai/AIController';
import type { Role, MusicalMode } from './game/types';

function App() {
    const {
        snakes,
        gridSize,
        isPlaying,
        musicalMode,
        togglePlay,
        setDirection,
        reset,
        togglePlayerType,
        addSnake,
        removeSnake,
        setMusicalMode,
        tick
    } = useGameStore();

    useEffect(() => { loadModel(); }, []);

    useEffect(() => {
        const handleKeyDown = (e: KeyboardEvent) => {
            if (['ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight', ' '].includes(e.key)) {
                e.preventDefault();
            }

            const humanSnakes = snakes.filter(s => s.type === 'HUMAN').sort((a, b) => a.id - b.id);
            const player1 = humanSnakes[0];
            const player2 = humanSnakes[1];

            if (player1) {
                if (e.key === 'w' || e.key === 'W') setDirection(player1.id, 'UP');
                if (e.key === 's' || e.key === 'S') setDirection(player1.id, 'DOWN');
                if (e.key === 'a' || e.key === 'A') setDirection(player1.id, 'LEFT');
                if (e.key === 'd' || e.key === 'D') setDirection(player1.id, 'RIGHT');
            }
            if (player2) {
                if (e.key === 'ArrowUp') setDirection(player2.id, 'UP');
                if (e.key === 'ArrowDown') setDirection(player2.id, 'DOWN');
                if (e.key === 'ArrowLeft') setDirection(player2.id, 'LEFT');
                if (e.key === 'ArrowRight') setDirection(player2.id, 'RIGHT');
            }

            if (e.key === ' ') togglePlay();
        };
        window.addEventListener('keydown', handleKeyDown);
        return () => window.removeEventListener('keydown', handleKeyDown);
    }, [setDirection, snakes, togglePlay]);

    useEffect(() => {
        let interval: number;
        if (isPlaying) {
            interval = window.setInterval(() => tick(), 500);
        }
        return () => clearInterval(interval);
    }, [isPlaying, tick]);

    const getControlsLabel = (snakeId: number, type: string) => {
        if (type === 'AI') return null;
        const humanSnakes = snakes.filter(s => s.type === 'HUMAN').sort((a, b) => a.id - b.id);
        const index = humanSnakes.findIndex(s => s.id === snakeId);
        if (index === 0) return "WASD";
        if (index === 1) return "ARROWS";
        return null;
    };

    const modes: MusicalMode[] = ['ARABIC', 'ORCHESTRAL', 'EIGHT_BIT', 'PIANO'];

    return (
        <div className="bg-slate-950 min-h-screen">
            <div className="min-h-screen flex flex-col items-center p-8">
                <header className="mb-8 text-center shrink-0">
                    <h1 className="text-6xl font-black tracking-[0.15em] text-transparent bg-clip-text bg-gradient-to-r from-blue-400 via-purple-500 to-emerald-400 mb-2 font-display">
                        SCALES
                    </h1>
                    <p className="text-slate-400 text-xs tracking-[0.3em] uppercase">
                        Generative Audio Ensemble
                    </p>
                </header>

                <div className="flex-1 w-full flex items-center justify-center my-4">
                    <div className="flex flex-wrap justify-center gap-8 max-w-7xl">
                        <AnimatePresence mode="popLayout">
                            {snakes.map((snake) => (
                                <motion.div
                                    key={snake.id}
                                    layout
                                    initial={{ opacity: 0, scale: 0.8, y: 20 }}
                                    animate={{ opacity: 1, scale: 1, y: 0 }}
                                    exit={{ opacity: 0, scale: 0.5, transition: { duration: 0.2 } }}
                                    transition={{ type: "spring", stiffness: 300, damping: 25 }}
                                >
                                    <Board
                                        snake={snake}
                                        gridSize={gridSize}
                                        onToggleType={() => togglePlayerType(snake.id)}
                                        onRemove={() => removeSnake(snake.id)}
                                        controls={getControlsLabel(snake.id, snake.type)}
                                    />
                                </motion.div>
                            ))}
                        </AnimatePresence>
                    </div>
                </div>

                <div className="flex flex-col items-center gap-6 z-10 shrink-0 mt-4">
                    <div className="flex flex-col gap-4 p-5 bg-slate-900/40 rounded-xl border border-slate-800/60 w-full max-w-xl backdrop-blur-sm">

                        <div className="grid grid-cols-[60px_1fr] items-center gap-4">
                            <span className="text-slate-500 text-[10px] font-black tracking-widest text-center">MODE</span>
                            <div className="flex -space-x-px w-full">
                                {modes.map((mode, idx) => (
                                    <button
                                        key={mode}
                                        onClick={() => setMusicalMode(mode)}
                                        className={clsx(
                                            "flex-1 px-2 py-2 text-[10px] font-bold transition-all border border-slate-700 whitespace-nowrap",
                                            idx === 0 && "rounded-l-md",
                                            idx === modes.length - 1 && "rounded-r-md",
                                            musicalMode === mode
                                                ? "bg-indigo-600 border-indigo-400 text-white z-10 shadow-[0_0_12px_rgba(99,102,241,0.25)]"
                                                : "bg-slate-900/80 text-slate-500 hover:bg-slate-800 hover:text-slate-300"
                                        )}
                                    >
                                        {mode.replace('_', ' ')}
                                    </button>
                                ))}
                            </div>
                        </div>

                        <div className="grid grid-cols-[60px_1fr] items-center gap-4">
                            <span className="text-slate-500 text-[10px] font-black tracking-widest text-center">ADD</span>
                            <div className="flex gap-2 w-full">
                                {(['BASS', 'PAD', 'LEAD', 'PERC'] as Role[]).map(role => (
                                    <button
                                        key={role}
                                        onClick={() => addSnake(role)}
                                        className={clsx(
                                            "flex-1 whitespace-nowrap px-2 py-2 text-[10px] font-bold rounded-md border border-slate-700 transition-all hover:scale-[1.02] active:scale-95",
                                            role === 'BASS' ? "text-blue-400 hover:bg-blue-900/30" :
                                                role === 'PAD' ? "text-purple-400 hover:bg-purple-900/30" :
                                                    role === 'LEAD' ? "text-red-400 hover:bg-red-900/30" :
                                                        "text-emerald-400 hover:bg-emerald-900/30"
                                        )}
                                    >
                                        + {role}
                                    </button>
                                ))}
                            </div>
                        </div>
                    </div>

                    <div className="flex gap-4">
                        <button onClick={togglePlay} className={clsx("px-8 py-3 text-xs font-black tracking-widest rounded-lg shadow-lg transition-all transform hover:scale-105 active:scale-95", isPlaying ? "bg-slate-800 text-slate-400 border border-slate-700" : "bg-white text-slate-900")}>
                            {isPlaying ? 'STOP ENSEMBLE' : 'START ENSEMBLE'}
                        </button>
                        <button onClick={reset} className="px-6 py-3 text-xs font-black tracking-widest border border-slate-800 text-slate-500 rounded-lg hover:bg-slate-900 hover:text-slate-300 transition">
                            RESET
                        </button>
                    </div>
                </div>

                <div className="mt-8 mb-4 animate-bounce text-slate-600 flex flex-col items-center gap-2 cursor-pointer shrink-0"
                    onClick={() => window.scrollTo({ top: window.innerHeight, behavior: 'smooth' })}>
                    <span className="text-[10px] font-bold tracking-widest uppercase">System Architecture</span>
                    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 14l-7 7m0 0l-7-7m7 7V3" />
                    </svg>
                </div>
            </div>

            <AboutSection />
        </div>
    );
}

export default App;