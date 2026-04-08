# loop-closed — Design System
## Elite Momentum Edition

---

## 1. Creative North Star: "The Kinetic Editorial"

loop-closed is a precision tool with editorial energy. The visual identity
combines developer-native roots with a high-contrast, high-velocity aesthetic.
It should feel like a system built for elite performance — not a startup, not
a corporate product, not an AI toy.

**The tension that drives everything:** terminal precision meets editorial boldness.
The grid is intentionally asymmetric. The typography is aggressive. The color
is deep and saturated. Every element should feel like it was placed with purpose.

---

## 2. Logo & Glyph-Mark

### The Icon
A right-pointing arrow (`>`) — the terminal prompt — followed by a tight
curved return stroke that loops back to its origin. The loop closes.

- **Concept:** feedback, recursion, the session that starts where the last one ended
- **Stroke:** single-weight, high-contrast, no fill
- **Color:** `#E894FF` on `#1F0027` (Deep Plum)
- **Logo file:** `logo.png`

### Usage
| Context | Size | Notes |
|---------|------|-------|
| GitHub README header | 80×80px | Dark background version |
| GitHub social card | Embedded | See `github-cover.png` |
| Favicon | 32×32 and 16×16px | Test at 16px — the mark holds |

### What not to do
- Don't add drop shadows or glows to the mark
- Don't place on light backgrounds without testing contrast
- Don't resize below 16px without testing legibility

---

## 3. Color Palette

| Role | Value | Usage |
|------|-------|-------|
| Background | `#1F0027` Deep Plum | Primary dark foundation |
| Surface low | `#26022e` | Cards, recessed sections |
| Surface high | `#3a0050` | Elevated interactive surfaces |
| Accent / Action | `#E894FF` | CTAs, the glyph-mark, focus rings |
| Neon / Success | `#00EBB3` | Active states, positive feedback |
| Amber / Warning | `#FFB961` | Alerts, secondary actions |
| Muted text | `#c4a0d0` | Captions, metadata |
| Foreground | `#f0e4f7` | Primary text |

### The No-Line Rule
Standard 1px borders are prohibited for sectioning. Define boundaries
through background color shifts only. Space and mass replace lines.

### Glass surfaces
Floating elements: surface color at 60–80% opacity with `backdrop-blur: 20–40px`.
The brand colors bleed through — this is intentional.

### Ghost border (accessibility fallback)
`outline-variant` at 15% opacity. It should be felt, not seen.

---

## 4. Typography

| Role | Font | Application |
|------|------|-------------|
| Display / Headline | **Space Grotesk** Bold | Large, commanding — often uppercase |
| UI / Body | **Space Grotesk** Regular | Functional, high-legibility |
| Code / Terminal | **JetBrains Mono** | All code samples and terminal output |

### Rules
- Display headlines: uppercase or title case for editorial impact
- Size contrast is load-bearing — `display-lg` headline + `body-md` body
- Let headlines bleed off container edges when it serves the layout
- Wide tracking on display text (`letter-spacing: 0.05–0.1em`)
- Left-align body text — centered layouts kill the energy

---

## 5. Elevation & Depth

Depth through tonal layering, not shadows.

- **Lift a card:** `surface-container-high` on `surface-container-low`
- **Ambient shadow (floating only):** `on-surface` at 5% opacity, blur 40px+. Never pure black.
- **Corner radius:** `none` or `2px` for containers. `9999px` for pill chips only.

---

## 6. Components

### Buttons
- **Primary:** `#E894FF` or `#FFB961` background. Sharp corners. Uppercase label, heavy tracking.
- **Ghost:** No background. `#E894FF` or white text with 1px ghost border at 20% opacity.

### Cards
- No dividers. Use vertical whitespace or surface-container color shifts.
- Images break the padding — bleed to card edges for kinetic feel.

### Inputs
- Background: `surface-container-highest`
- Focus state: `#00EBB3` glow, not a border

### Chips / Tags
- `#E894FF` or `#00EBB3` blocks. Full roundedness (`border-radius: 9999px`).

---

## 7. Design Principles

1. **High-velocity layouts** — whitespace + large type create momentum
2. **Editorial hierarchy** — treat screens like magazine spreads
3. **Kinetic interactions** — sharp, responsive, no smoothed-over softness
4. **Intentional asymmetry** — reject the comfortable centered grid

---

## 8. Do's and Don'ts

### Do
- Overlap elements — text over imagery creates depth
- Use aggressive vertical spacing — premium products breathe
- Use full-width color blocks (`#E894FF` section with white text = visual reset)
- Let the accent color do the heavy lifting on focus and hierarchy

### Don't
- Use 1px solid grey borders — they break the editorial immersion
- Center-align everything
- Use gradients
- Use blue, green, or standard "AI product" colors
- Use soft, rounded, bubbly imagery

---

## 9. Voice

Precise. Confident. A practitioner talking to practitioners.
Short sentences. First person. No buzzwords.

**Banned:** seamlessly, powerful, robust, leverage, revolutionize,
cutting-edge, game-changing, supercharge, unlock, streamline.
