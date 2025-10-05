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

## Customization

* Page, fatigue, and color settings are at the top of `Main.gd`.
* Replace the Aanya art with your own (just update the texture in the Aanya scene).
* All scripts include comments for easy modification.

---

## Attribution

All character and UI graphics were designed using **Canva**.
You may use and modify these assets in accordance with Canva’s licensing and your own project needs.

---

## Troubleshooting

* **Node not found** or **null instance** errors:

  * Check your scene for correct node names and hierarchy.

* **R doesn’t restart the game:**

  * Confirm the Input Map includes the action `restart` mapped to the R key.

* **Game not updating:**

  * Ensure the correct scripts and scene hierarchy are in use.

---

## License & Use

You may use, redistribute, and remix this project for non-commercial or educational purposes.
Please include a link to this repository and Canva if you share your own version.

---

*Have fun helping Aanya power through her all-nighter!*
