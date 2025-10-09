# Aanya’s All-Nighter

Aanya’s All-Nighter is a frantic typing sprint game built with the Godot Engine. Your goal: help Aanya power through her all-night typing marathon by boosting her speed, managing energy drinks, and outlasting fatigue across three colourful levels.

## Why I Made This Project

I wanted to create a fast-paced arcade challenge based on real late-night study sessions. I thought it would be fun (and a little relatable for students!) to build a resource management game where you have to balance risk and stamina, just like staying up all night for an assignment.

## How I Made It

I used Godot 4 and GDScript, starting with a basic Node2D structure for the player and UI. Most logic centres around timers for fatigue, pages, and boosts. Graphics were kept simple, just colours and labels (no external assets). The game logic focuses on instant feedback and smooth difficulty: SPACE boosts your typing rate, crossing the screen refills your energy drinks, and F instantly restarts the session!

## Struggles & Lessons Learned

Getting pause and restart to work everywhere (every game state) was tough! Godot’s input and pausing can be tricky, so I ended up using a control flag instead of the built-in pause. Balancing fatigue vs. boosting rates took lots of playtesting. I also learned a ton about UI design and resource loops, making strategy feel rewarding and fun.

---

This repo is meant for students and game devs who want a clear, simple example of a risk-reward resource management game with no fancy graphics or complex systems, just pure gameplay!


[![Athena Award Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Faward.athena.hackclub.com%2Fapi%2Fbadge)](https://award.athena.hackclub.com?utm_source=readme)
