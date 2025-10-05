# Aanya’s All-Nighter

> *A fun and simple typing-themed arcade game made with Godot Engine. All game graphics were created using Canva.*

---

## Gameplay Overview

Help Aanya stay awake and finish her typing assignment before running out of energy!
Boost her productivity, manage her fatigue, and complete all levels for victory.

* Hold **Spacebar** to boost and type faster (if you have energy drinks left).
* Typing fills “Pages Typed” and increases fatigue.
* Use energy drinks wisely; running out disables boosting.
* If the fatigue bar fills up, Aanya dozes off and you lose.
* Complete the required number of pages to level up.
* Survive all levels to win.

---

## Controls

| Action                   | Key      |
| ------------------------ | -------- |
| Boost/Type               | Spacebar |
| Restart (after win/loss) | R        |

---

## Installation & Running

1. **Requirements:**

   * Godot Engine 4.x

2. **Clone or Download** this repository.

3. **Assets:**

   * All character art and graphics were created in Canva, included in the `assets/` folder.

4. **Open the Project:**

   * In Godot, press “Import”, select the project folder, and open.

5. **Run the Game:**

   * Press **F5** or click the “Run” button inside Godot.

---

## Scene Structure

```
Main (Node2D)
├─ CanvasLayer
│   ├─ ScoreLabel   (Label)
│   ├─ EnergyLabel  (Label)
│   └─ FatigueBar   (ProgressBar)
├─ Background      (ColorRect)
├─ Aanya           (Node2D, instanced from Aanya.tscn)
```

*Note:* All UI nodes must be named as above, and must be direct children of `CanvasLayer`.

---

*Have fun helping Aanya power through her all-nighter!*
