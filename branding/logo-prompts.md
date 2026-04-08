# loop-closed — Logo Prompts

> Tool: Google Imagen 2 (Gemini)
> All prompts written for natural language input — no Midjourney flags.
> Run the BOLD directions first. The safe directions are reference only.

---

## BOLD DIRECTIONS (recommended)

### Bold A — Ouroboros ⭐ TOP PICK

Concept: a serpent biting its own tail — the ancient ouroboros — rendered
in a completely geometric, technical style. The loop that closes on itself.
No biological detail. Pure form.

```
A minimal geometric icon of a serpent biting its own tail — the ancient
ouroboros symbol — rendered in a completely flat, technical illustration
style with no scales, no texture, no decoration. The body is a uniform
smooth ribbon forming a perfect circle. The bite point is the visual
center of interest: the head exactly touching the tail, the loop sealed.
Single uniform stroke weight throughout, no fill, monochromatic.
White icon on a pure black square background. Precision tool aesthetic,
not decorative or ornate.

Do not include: scales, eyes, tongue, fangs, decorative details of any kind,
medieval or ornate styling, color fills, gradients, drop shadows, glow
effects, text, letterforms, 3D rendering, texture, noise.
```

**If Imagen adds biological detail, add to prompt:**
> "The body is a simple smooth ribbon with no surface detail whatsoever.
> Cleaner and more geometric than any snake reference you have seen."

**Light background version — swap the last line of the setup:**
> "Black icon on a pure white square background."

---

### Bold B — Terminal Return

Concept: a right-pointing arrow that curves back and points at itself.
Suggests a command that returns to its own prompt. Pure terminal DNA.

```
A minimal technical icon: a right-pointing arrow glyph whose shaft curves
in a tight loop and returns to point back at the arrowhead's origin, as if
a terminal command is feeding back into its own prompt. The entire mark
is drawn with a single continuous line of uniform stroke weight. Monospace
terminal aesthetic — precise, geometric, no organic curves. White on black
square background, icon proportions, 1:1 ratio.

Do not include: fills, gradients, multiple arrows, text, letterforms,
decorative elements, shadows, glow, 3D, anything that would not belong
in a terminal window.
```

---

### Bold C — The Sealed Bracket

Concept: a closing square bracket `]` whose stroke curves back and seals
itself shut with a small arrowhead. A bracket that closes on itself.
Most code-native option.

```
A minimal code-native icon: a square bracket shape whose vertical stroke
curves back left at the bottom and connects upward to the bracket's top,
forming a completely closed loop. The closure point has a small arrowhead
indicating the direction of flow. The result reads as both a bracket and
a loop simultaneously. Geometric precision, single uniform stroke weight,
no fill. White on black square background.

Do not include: text, fills, gradients, shadows, decorative elements,
multiple brackets, 3D effects, organic curves.
```

---

## SAFE DIRECTIONS (reference / fallback)

### Safe 1 — Closing Loop Arrow

```
A minimal flat vector icon of a single continuous arrow line that forms
a complete closed loop — like a circle, but with an arrowhead where the
line meets itself, showing the exact moment the loop closes. Stroke-only
design, no fill. Precise geometric construction, uniform stroke weight
throughout. White icon on a pure black square background. Clean, technical,
precision tool aesthetic. Square format, 1:1 ratio.

Do not include: gradients, shadows, glow effects, text, letterforms, 3D
rendering, organic lines, brain imagery, circuit board patterns, robot
icons, decorative elements.
```

### Safe 2 — Signal Return

```
A minimal technical icon: two short horizontal parallel lines where both
ends curve inward and connect to each other, forming a closed oval track
shape — like a simplified magnetic field diagram or racetrack seen from
above. Single uniform stroke weight, no fill, monochromatic. Flat vector
style, geometric precision. White mark on black square background.

Do not include: gradients, shadows, text, arrows, 3D effects, decorative
elements, fills, varying stroke widths.
```

### Safe 3 — Typographic Mark

```
A typographic logo mark: the text "loop-closed" set in a geometric
monospace typeface with precise tight letter-spacing. The hyphen between
"loop" and "closed" is replaced by a small minimalist closed-loop arrow
symbol that matches the stroke weight of the letterforms. White text on
black background. No separate icon — the typography and integrated symbol
together are the complete mark.

Do not include: decorative fonts, serifs, gradients, drop shadows,
additional graphic elements beyond the letterforms and integrated symbol.
```

---

## SVG Construction Brief (for building Direction Bold A manually)

If you want to build the ouroboros mark from scratch in Figma or as SVG:

- **Canvas:** 512×512px
- **Ring diameter:** 360px (centered, 76px margin all sides)
- **Stroke width:** 36px (10% of diameter)
- **Stroke cap:** round
- **Ring:** a circle stroke at 340px diameter (center of stroke lands at 360px)
- **Head:** flattened ellipse at the 12 o'clock position, 52px wide × 36px tall
- **Tail:** the ring stroke terminates inside the head's "mouth" — a 20px gap
  in the ring at 12 o'clock, the tail tip pointing toward center
- **Gap:** 20px between tail tip and head interior
- **Result:** the tail disappears into the head at 12 o'clock, the loop reads closed

**Colors:**
- Light mode: `#0D0D0D` on `#FAFAFA`
- Dark mode: `#FAFAFA` on `#0D0D0D`
- With accent (optional): `#D4622A` for the head/bite point only

---

## Notes on Imagen 2 behavior

- It tends to add texture even when asked for "flat" — add "no texture, no noise,
  perfectly flat" if the output feels rendered
- It respects explicit "Do not include" lists better than negative stylistic adjectives
- Run each prompt 4 times and pick the sharpest result — Imagen has high variance
- Square outputs (1:1) tend to produce cleaner icon results than landscape
- If a prompt produces something close but slightly off, adjust ONE thing at a time
