# Design System Document

## 1. Overview & Creative North Star: "The Kinetic Editorial"

This design system is not a standard web interface; it is a high-octane, editorial experience designed to mirror the velocity and impact of professional athletics. Our Creative North Star is **"The Kinetic Editorial."** 

We move beyond the "template" look by treating the screen as a dynamic canvas. The system rejects the comfort of centered, balanced grids in favor of intentional asymmetry, aggressive typography scales, and "breaking the frame" with imagery. This is an exclusive environment—professional yet disruptive—where bold color blocks and sharp angles communicate a sense of movement and elite status.

---

## 2. Colors: Tonal Depth & Vibrancy

The palette is anchored in deep, sophisticated purples, allowing vibrant neon accents to vibrate against dark surfaces.

### Core Palette
- **Background (`#26022e`):** The foundation. A deep, saturated plum that feels more premium and intentional than pure black.
- **Primary (`#f4bdff`) / Primary Container (`#e894ff`):** The electric purple signature. Use this for high-impact branding and focal points.
- **Secondary (`#ffb961`):** A high-contrast orange for calls to action and navigational "hooks."
- **Tertiary (`#00ebb3`):** A neon cyan/green reserved for success states, kinetic accents, or specific athlete-related callouts.

### The "No-Line" Rule
Standard 1px borders are strictly prohibited for sectioning. Structural boundaries must be defined solely through background color shifts. For example, a `surface-container-low` section sitting on a `background` provides all the definition required. We define space through mass, not lines.

### Surface Hierarchy & Nesting
Treat the UI as a series of physical layers. Use the `surface-container` tiers to create depth:
- **Lowest Tier (`surface-container-lowest`):** Deepest "recessed" areas.
- **Highest Tier (`surface-container-highest`):** The most "elevated" interactive surfaces.
- **The Glass Rule:** For floating elements, use `surface` colors at 60-80% opacity with a `backdrop-blur` of 20px to 40px. This ensures the vibrant brand colors "bleed" through the interface, creating a sense of environmental integration.

---

## 3. Typography: Authority Through Contrast

The typography strategy relies on the tension between a massive, condensed display face and a technical, clean sans-serif.

- **Display & Headline (`spaceGrotesk` / Druk-inspired):** This is our "Voice." It should be used at scale. Don't be afraid to let a `display-lg` headline bleed off the edge of a container or overlap an image. It conveys power and exclusivity.
- **Title & Body (`inter` / Neue Montreal-inspired):** These are for clarity and "The Fine Print." While headlines shout, the body text speaks with calm, professional authority.
- **Label (`manrope`):** Used for metadata, small captions, and technical details.

**Hierarchy Note:** Use high contrast in size. If a headline is `display-lg`, the supporting text should be significantly smaller (`body-md`) to emphasize the editorial importance of the message.

---

## 4. Elevation & Depth: Tonal Layering

We avoid traditional drop shadows in favor of **Tonal Layering**. Depth is a result of color proximity, not artificial lighting.

- **The Layering Principle:** To lift a card, place a `surface-container-high` card onto a `surface-container-low` background. This creates a "soft lift" that feels architectural rather than digital.
- **Ambient Shadows:** If a floating element (like a modal or high-priority CTA) requires a shadow, it must be an "Ambient Shadow." Use the `on-surface` color at 5% opacity with a blur radius of 40px+. Never use pure black shadows.
- **The "Ghost Border" Fallback:** If accessibility requires a border, use the `outline-variant` at 15% opacity. It should be felt, not seen.
- **Sharp Angles:** Use the `none` or `sm` (0.125rem) settings for most containers to maintain the "aggressive" athlete-driven aesthetic. Rounded corners (`xl`) are reserved only for specific "pill" elements like status chips.

---

## 5. Components

### Buttons
- **Primary:** Bold `secondary` (Orange) or `primary` (Purple) backgrounds. Sharp corners (`none`). Typography should be uppercase `label-md` with heavy tracking.
- **Tertiary/Ghost:** No background. Use a `secondary` or `white` text with a 1px "Ghost Border" (20% opacity).

### Cards & Lists
- **No Dividers:** Forbid the use of horizontal lines. Use vertical white space from the spacing scale or a shift from `surface-container-low` to `surface-container-high`.
- **Dynamic Insets:** Images within cards should often break the padding of the card, bleeding to the top or side edges to maintain the "Kinetic" feel.

### Input Fields
- **Styling:** Use `surface-container-highest` for the field background. 
- **States:** Focus states should use a vibrant `tertiary` (Neon Green) glow rather than a thick border.

### Chips & Tags
- **Selection:** High-contrast blocks of color (Primary or Tertiary) with `full` roundedness to provide a visual break from the sharp-angled layout.

---

## 6. Do's and Don'ts

### Do
- **Do** overlap elements. Let text sit partially over an image of an athlete to create depth.
- **Do** use aggressive vertical spacing. Let the content breathe to maintain a "premium" feel.
- **Do** use color blocks. A full-width section of `primary-container` with white text creates a powerful visual "reset."

### Don't
- **Don't** use 1px solid black or grey borders. They break the editorial immersion.
- **Don't** center-align everything. Use left-aligned "staggered" layouts to create energy.
- **Don't** use standard "web safe" colors. Stick strictly to the defined brand tokens to maintain the exclusive, impact-driven atmosphere.
- **Don't** use soft, "bubbly" imagery. Use high-contrast, moody, or action-oriented photography.