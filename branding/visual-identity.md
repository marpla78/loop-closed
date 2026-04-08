# loop-closed — Visual Identity

> This is the reference for all visual decisions: GitHub README, logo, any
> future landing page or social assets. When in doubt, consult this first.

---

## The Feeling

Precision instrument. A well-worn notebook. Something built to last, not to impress.
Not a startup. Not corporate. Not trying to look like an AI product.

---

## Color

### Primary palette (monochromatic — always works)

| Role | Light mode | Dark mode |
|------|-----------|-----------|
| Background | `#FAFAFA` | `#0D0D0D` |
| Foreground | `#0D0D0D` | `#FAFAFA` |
| Muted text | `#6B6B6B` | `#8A8A8A` |
| Border | `#E0E0E0` | `#2A2A2A` |

### Accent (optional — use sparingly, one element at a time)

`#D4622A` — a burnt orange. Precise, warm, not neon. Evokes circuit traces and
aged copper. Use only for: the bite point in the ouroboros logo, a single
highlight in the README, or a hover state.

**Do not use:** blue (Anthropic territory), purple (AI cliché), green (success
theater), gradients of any kind, neon or fluorescent tones.

---

## Typography

### In the README (no web fonts — GitHub renders system stack)
- Headers: system-ui, rendered by GitHub as-is. Don't fight it.
- Code blocks: GitHub's monospace. Don't fight it.
- The README IS the brand. Clean markdown IS the design.

### If a landing page or social asset needs a font

| Role | Font | Source |
|------|------|--------|
| Headings | [DM Mono](https://fonts.google.com/specimen/DM+Mono) | Google Fonts, free |
| Body | [Inter](https://fonts.google.com/specimen/Inter) | Google Fonts, free |
| Code | [JetBrains Mono](https://fonts.google.com/specimen/JetBrains+Mono) | Google Fonts, free |

**Reasoning:** DM Mono carries the terminal/precision aesthetic without being cold.
Inter is neutral enough to stay out of the way. JetBrains Mono is what most
developers already use in their editor — familiar without being generic.

---

## Logo Usage

### Recommended mark: Bold A (Ouroboros)
See `logo-prompts.md` for generation instructions and SVG construction brief.

### Sizes and contexts

| Context | Size | Format | Notes |
|---------|------|--------|-------|
| GitHub README header | 80×80px | PNG or SVG | Dark version on dark README |
| Favicon | 32×32px and 16×16px | PNG | Must read at 16px — test this |
| Social card / OG image | 1200×630px | PNG | Logo + name + tagline |
| In-text reference | — | Inline text only | Don't embed logo in body copy |

### What not to do
- Don't add drop shadows or glows to the logo
- Don't put the logo on a colored background unless you've tested contrast
- Don't use the safe directions (circular arrow) if the ouroboros renders well
- Don't resize the logo below 16px without testing legibility first
- Don't animate the logo unless there's a specific, intentional reason

---

## Voice (for any written material)

Precise, not precious. Confident, not loud. A practitioner talking to other
practitioners. First person. Short sentences. No buzzwords.

**Banned words:** seamlessly, powerful, robust, leverage, revolutionize,
cutting-edge, game-changing, supercharge, unlock, streamline.

**Tone check:** would this sentence feel at home in a README written by
someone who actually uses this tool daily? If not, rewrite it.

---

## README visual structure

The README is the primary brand surface. These decisions are non-negotiable:

1. **No hero image required.** The hook text IS the hero. If a logo is added,
   it goes above the title, centered, 80px, with 16px space below.
2. **Code blocks are design elements.** Use them liberally — before/after
   comparisons in code blocks are more convincing than prose.
3. **Tables for comparison only.** Not for decoration.
4. **No badges** (build passing, version, license shields) — they signal
   "this is a library," not "this is a system." A plain MIT license line
   in the footer is enough.
5. **One call to action.** Not three. The CTA is: "Star it, fork it, run install.sh."

---

## Social assets (if needed)

### OG image / Twitter card

Layout: centered logo mark (ouroboros, 120px) above the name "loop-closed" in
DM Mono at 48px, below that the tagline in Inter at 20px muted. Dark background
`#0D0D0D`. No decorative elements, no gradients, no pattern fills.

```
Background: #0D0D0D
Logo: centered, 120×120px, white version
Name: "loop-closed" — DM Mono Medium, 48px, #FAFAFA, centered
Tagline: one line — Inter Regular, 20px, #6B6B6B, centered
Bottom margin: 48px
```

---

## What "on brand" looks like

- A README with no hero image that still feels intentional
- A logo that would look correct in a terminal or a Figma file
- Copy that a senior developer would not roll their eyes at
- No purple. No gradients. No "AI" anywhere in the visual identity.
