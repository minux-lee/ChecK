# SCALES: Generative Audio Ensemble

![SCALES _ Generative Audio Ensemble · 11 07am · 12-15](https://github.com/user-attachments/assets/31c2636a-e7cd-4806-86d4-3f39c33e52d7)

> **"The collision of agents becomes the coincidence of rhythm."**

**SCALES** is a Generative Music System that reimagines the classic rules of the Snake game. The title embodies a double meaning: the **reptilian scales** that form the snake's body, and the **musical scales** that form the ensemble's harmony.

Going beyond simple win/loss mechanics, this project transforms the interplay of chance and order created by players and AI into a unique auditory experience.

🔗 **[Play Live Demo](https://minux-lee.github.io/Scales/)**

## 💡 Motivation & Concept

**"Controlled Randomness: The Multi-Agent Ensemble"**

Traditional music production often relies on static, repetitive loops. SCALES challenges this determinism by introducing **Controlled Randomness** into the composition process.

The system allows multiple instances of the same instrument to run simultaneously across different boards, creating a layered, polyphonic texture. Whether driven by the pathfinding logic of an **AI Agent** or the spontaneous reactions of a **Human Player**, each board generates a unique, non-linear pattern.

## 🎹 Musical Logic Implementation

Each snake is not just a game object, but an instrument. Position values `(x, y)`, the direction of snake (NEWS), and its length are converted into audio parameters in real-time. There are also other modes you can select.
`fun void onTick(int beatCount, string mode, int x, int y, string instrument, string dir, int length)`

| Role | Instrument | Description & Effect Modulation | Musical Logic (Formula) |
|------|------------|---------------------------------|-------------------------|
| **BASS** | Synth Bass | **Head Direction**: Depending on the direction of the snake's head, the root and fifth of the corresponding chord are played. As the snake gets longer, the sustain gain increases. <br> *Effect: Length increases Sustain Gain.* | `Bass Index = snake.direction_i` |
| **PAD** | Ambient Pad | **Harmonic Zoning**: Among the chord tones, a total of four different combinations of chord tones are played depending on the value of x + y. The length of the snake connects to the detune level of the union. <br> *Effect: Length increases Oscillator Detune.* | `Chord Index = (x + y) % 4` |
| **LEAD** | Lead Synth | **Scale of the Mode**: For each mode, notes are played according to the corresponding scale. Occasionally, the rhythm is subdivided during playback. As the snake gets longer, the reverb level increases. <br> *Effect: Length increases Reverb Level.* | `NNote Index = x (, y)` |
| **PERC** | Rhythm | **Parity Rhythm**: Drum samples are played according to each mode. Depending on the direction of the head, the number of times a closed hi-hat or a triangle is triggered varies. As the snake gets longer, the reverb mix increases. <br> *Effect: Length increases Reverb Mix.* | `#hihat or #triangle = f(snake.direction_i)` |

## 🧠 AI Architecture: DQN Agent

The AI Agent is powered by a **Deep Q-Network (DQN)** that runs entirely in the browser using TensorFlow.js. It makes decisions every 500ms based on its immediate surroundings.

### 1. Observation Space (The Inputs)
The neural network receives a vector of **11 boolean values** representing the snake's **relative** perception. It does not see the entire grid.
* **[0-2]** Danger (Straight, Right, Left)
* **[3-6]** Current Direction (Left, Right, Up, Down)
* **[7-10]** Food Location (Left, Right, Up, Down)

### 2. Neural Network Structure
A concise Dense Neural Network optimized for real-time web inference.
* **Input Layer**: Shape (11,)
* **Dense Layer**: 256 Units (ReLU)
* **Dropout**: Rate 0.2
* **Dense Layer**: 256 Units (ReLU)
* **Output Layer**: 3 Units (Actions)

### 3. Action Space
The model outputs 3 Q-values. The system selects the action with the highest value (ArgMax). Actions are **relative** to the snake's current head direction:
* **Action 0**: Go Straight
* **Action 1**: Turn Right (Clockwise)
* **Action 2**: Turn Left (Counter-Clockwise)

## 🛠 Tech Stack & Engineering

### Core & Frontend
* **React 18 & TypeScript**: Logic structure and type safety.
* **Vite**: Fast build tooling.
* **Tailwind CSS**: Styling and UI components.
* **Optimization**: Optimized React's reconciliation process for high-performance rendering.

### State & Audio
* **Zustand**: Maintains perfect **500ms Tick Sync** between 4 game loops and the audio engine using transient updates.
* **WebChucK**: Web-based ChucK compiler for real-time sound synthesis.
* **Web Audio API**: Audio context management.

### AI & Learning
* **TensorFlow.js**: Inferences the pre-trained model directly in the browser.
* **Python (Gymnasium)**: Environment used for training the original DQN model.

## 📦 Installation & Usage

### 1. Prerequisites
* Node.js (v18+)
* Python 3.9+ (Optional: Only required for retraining the model)

### 2. Setup & Run
```bash
git clone https://github.com/minux-lee/Scales.git
cd Scales
npm install
npm run dev
```

### 3. Retraining the Model (Optional)
The project includes a pre-trained model in `public/models/`. To retrain:

```bash
# Install Python dependencies
pip install tensorflow gymnasium numpy tensorflowjs

# Run training script
python train_snake.py
```

## 👥 Credits
Designed & Engineered by [minux-lee](https://github.com/minux-lee) & [siu1031](https://github.com/siu1031).
- License: MIT
