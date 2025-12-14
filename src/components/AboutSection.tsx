import React from 'react';
import clsx from 'clsx';

const TechBadge = ({ children }: { children: React.ReactNode }) => (
    <span className="px-3 py-1 text-xs font-mono font-bold text-slate-300 bg-slate-800 rounded-full border border-slate-700">
        {children}
    </span>
);

const SectionTitle = ({ children }: { children: React.ReactNode }) => (
    <h3 className="text-2xl font-bold text-white mb-6 flex items-center gap-3">
        {children}
    </h3>
);

const RoleCard = ({ role, color, desc, logic }: { role: string, color: string, desc: string, logic: string }) => (
    <div className="bg-slate-900/50 p-6 rounded-xl border border-slate-800 hover:border-slate-700 transition-all">
        <div className={clsx("text-sm font-black tracking-widest mb-2", color)}>{role}</div>
        <div className="text-slate-300 text-sm mb-4 leading-relaxed">{desc}</div>
        <div className="bg-slate-950 p-3 rounded text-xs font-mono text-slate-500">
            <span className="text-slate-400">Logic:</span> {logic}
        </div>
    </div>
);

export const AboutSection: React.FC = () => {
    return (
        <section className="w-full bg-slate-950 py-24 px-4 border-t border-slate-900">
            <div className="max-w-5xl mx-auto space-y-24">

                <div className="text-center space-y-6">
                    <h2 className="text-3xl md:text-5xl font-black text-white tracking-tight">
                        THE ARCHITECTURE OF <br />
                        <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-400 via-purple-500 to-emerald-400">
                            DIGITAL ENSEMBLE
                        </span>
                    </h2>
                    <p className="text-slate-400 max-w-2xl mx-auto text-lg leading-relaxed">
                        Polyphonic Snake는 고전 게임의 규칙을 현대적인 Generative Music 시스템으로 재해석한 프로젝트입니다.
                        단순한 승패를 넘어, 플레이어와 AI가 만들어내는 우연과 질서의 조화를 청각적 경험으로 변환합니다.
                    </p>
                </div>

                <div>
                    <SectionTitle>💡 Motivation & Concept</SectionTitle>
                    <div className="grid md:grid-cols-2 gap-8">
                        <div className="space-y-4 text-slate-300 leading-relaxed">
                            <p>
                                <strong className="text-white">"One Screen, Multiple Boards."</strong><br />
                                일반적인 Snake 게임은 혼자만의 고립된 경험입니다. 하지만 "여러 개의 게임이 한 공간에서 동시에 진행된다면 어떨까?"라는 질문에서 이 프로젝트는 시작되었습니다.
                            </p>
                            <p>
                                각기 다른 속도와 패턴을 가진 4개의 Agent가 서로 상호작용하며 음악적 앙상블(Ensemble)을 만들어내는 것이 목표입니다. 이를 위해 Grid 좌표를 MIDI Note로, 충돌 이벤트를 Rhythm으로 변환하는 독자적인 알고리즘을 설계했습니다.
                            </p>
                        </div>
                        <div className="bg-slate-900 p-6 rounded-xl border border-slate-800 flex flex-col justify-center gap-4">
                            <div className="flex items-center gap-4">
                                <div className="w-10 h-10 rounded-lg bg-blue-500/20 text-blue-400 flex items-center justify-center font-bold">V</div>
                                <div>
                                    <div className="text-white font-bold">Visual Feedback</div>
                                    <div className="text-xs text-slate-500">Real-time Reactive Rendering</div>
                                </div>
                            </div>
                            <div className="w-0.5 h-6 bg-slate-800 ml-5"></div>
                            <div className="flex items-center gap-4">
                                <div className="w-10 h-10 rounded-lg bg-purple-500/20 text-purple-400 flex items-center justify-center font-bold">A</div>
                                <div>
                                    <div className="text-white font-bold">Audio Synthesis</div>
                                    <div className="text-xs text-slate-500">WebChucK DSP Engine</div>
                                </div>
                            </div>
                            <div className="w-0.5 h-6 bg-slate-800 ml-5"></div>
                            <div className="flex items-center gap-4">
                                <div className="w-10 h-10 rounded-lg bg-emerald-500/20 text-emerald-400 flex items-center justify-center font-bold">I</div>
                                <div>
                                    <div className="text-white font-bold">Intelligence</div>
                                    <div className="text-xs text-slate-500">Reinforcement Learning Agents</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <SectionTitle>🛠 Tech Stack & Engineering</SectionTitle>
                    <div className="bg-slate-900 rounded-2xl p-8 border border-slate-800">
                        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                            <div>
                                <h4 className="text-white font-bold mb-4 border-b border-slate-700 pb-2">Core & Frontend</h4>
                                <div className="flex flex-wrap gap-2 mb-4">
                                    <TechBadge>React 18</TechBadge>
                                    <TechBadge>TypeScript</TechBadge>
                                    <TechBadge>Vite</TechBadge>
                                    <TechBadge>Tailwind CSS</TechBadge>
                                </div>
                                <p className="text-sm text-slate-400">
                                    고성능 렌더링을 위해 React의 Reconciliation 과정을 최적화했습니다.
                                </p>
                            </div>
                            <div>
                                <h4 className="text-white font-bold mb-4 border-b border-slate-700 pb-2">State & Audio</h4>
                                <div className="flex flex-wrap gap-2 mb-4">
                                    <TechBadge>Zustand</TechBadge>
                                    <TechBadge>WebChucK</TechBadge>
                                    <TechBadge>Web Audio API</TechBadge>
                                </div>
                                <p className="text-sm text-slate-400">
                                    Zustand의 Transient Update를 사용하여 4개의 게임 루프와 오디오 엔진 간의 <span className="text-white">500ms Tick Sync</span>를 완벽하게 유지합니다.
                                </p>
                            </div>
                            <div>
                                <h4 className="text-white font-bold mb-4 border-b border-slate-700 pb-2">AI & Learning</h4>
                                <div className="flex flex-wrap gap-2 mb-4">
                                    <TechBadge>TensorFlow.js</TechBadge>
                                    <TechBadge>Python (Gym)</TechBadge>
                                    <TechBadge>DQN</TechBadge>
                                </div>
                                <p className="text-sm text-slate-400">
                                    Python 환경에서 Reinforcement Learning(DQN)으로 학습된 모델을 브라우저로 이식하여 추론(Inference)합니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <SectionTitle>🎹 Musical Logic Implementation</SectionTitle>
                    <p className="text-slate-400 mb-8">
                        각 뱀(Snake)은 단순한 게임 오브젝트가 아닌 하나의 악기입니다. 위치값(x, y)은 실시간으로 오디오 파라미터로 변환됩니다.
                    </p>
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <RoleCard
                            role="BASS"
                            color="text-blue-400"
                            desc="음악의 토대를 담당합니다. Y축의 위치가 낮을수록(화면 아래쪽) 더 무거운 베이스 음을 연주합니다."
                            logic="Scale Index = (GRID_SIZE - 1 - Y)"
                        />
                        <RoleCard
                            role="PAD (HARMONY)"
                            color="text-purple-400"
                            desc="공간을 채우는 화성을 연주합니다. X축 영역에 따라 4가지 코드 진행(Chord Progression)을 순환합니다."
                            logic="Chord Index = floor(X / 2) % 4"
                        />
                        <RoleCard
                            role="LEAD (MELODY)"
                            color="text-red-400"
                            desc="주선율을 담당합니다. 대각선 이동을 고려하여 X와 Y 좌표의 조합으로 역동적인 음높이 변화를 만듭니다."
                            logic="Note = Base + X + (GRID_SIZE - Y)"
                        />
                        <RoleCard
                            role="PERC (RHYTHM)"
                            color="text-emerald-400"
                            desc="리듬을 담당합니다. 그리드의 상단이나 하단 벽에 닿는 순간(Kick/Snare) 트리거됩니다."
                            logic="Trigger if Y === 0 or Y === GRID_SIZE - 1"
                        />
                    </div>
                </div>

                <div>
                    <SectionTitle>🧠 AI Architecture: From Python to Browser</SectionTitle>
                    <div className="bg-slate-900/30 p-8 rounded-xl border border-slate-800">
                        <div className="flex flex-col md:flex-row gap-8 items-center">
                            <div className="flex-1 space-y-4">
                                <h4 className="text-lg font-bold text-white">The Brain (DQN Agent)</h4>
                                <p className="text-slate-400 text-sm leading-relaxed">
                                    AI 에이전트는 11개의 감각 정보(Sensors)를 통해 세상을 인식합니다.
                                    자신의 머리 기준으로 전후좌우의 장애물 유무, 현재 진행 방향, 그리고 먹이(Target)의 상대적 위치를 파악하여
                                    가장 높은 보상을 얻을 수 있는 행동(Action)을 결정합니다.
                                </p>
                                <ul className="space-y-2 mt-4">
                                    <li className="flex items-center gap-3 text-sm text-slate-300">
                                        <span className="w-2 h-2 rounded-full bg-indigo-500"></span>
                                        Input Layer: 11 Features (Collision Risks, Direction, Food Pos)
                                    </li>
                                    <li className="flex items-center gap-3 text-sm text-slate-300">
                                        <span className="w-2 h-2 rounded-full bg-indigo-500"></span>
                                        Hidden Layers: Dense(256) → Dropout → Dense(256)
                                    </li>
                                    <li className="flex items-center gap-3 text-sm text-slate-300">
                                        <span className="w-2 h-2 rounded-full bg-indigo-500"></span>
                                        Output: 3 Discrete Actions (Straight, Turn Left, Turn Right)
                                    </li>
                                </ul>
                            </div>
                            <div className="flex-1 w-full bg-slate-950 p-6 rounded-lg font-mono text-xs text-slate-500 border border-slate-800">
                                <div className="text-purple-400 mb-2">// Inference Loop</div>
                                <div className="mb-2">1. Get State (Sensors)</div>
                                <div className="pl-4 text-slate-600">[0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1]</div>
                                <div className="mb-2 mt-2">2. Model Predict (TensorFlow.js)</div>
                                <div className="pl-4 text-slate-600">waiting...</div>
                                <div className="mb-2 mt-2">3. Best Action Selection</div>
                                <div className="pl-4 text-emerald-400">Action: "TURN_RIGHT"</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div className="pt-12 text-center border-t border-slate-900">
                    <p className="text-slate-500 text-sm">
                        Designed & Engineered by <span className="text-slate-300 font-bold">You</span>
                    </p>
                    <div className="mt-4 flex justify-center gap-4">
                        <a href="#" className="text-slate-600 hover:text-white transition-colors">GitHub Repository</a>
                        <span className="text-slate-700">|</span>
                        <a href="#" className="text-slate-600 hover:text-white transition-colors">Project Documentation</a>
                    </div>
                </div>

            </div>
        </section>
    );
};