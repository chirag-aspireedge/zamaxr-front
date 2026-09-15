---
name: figma-mobile
description: Rules for converting Figma CSS into responsive Flutter mobile UI with proper font sizes and alignments.
---

# Figma CSS to Flutter Mobile Conversion

Whenever you paste Figma CSS layers:
1. **Never copy raw coordinates**: Ignore `left`, `top`, `calc(...)`. Use responsive Flutter padding (`horizontal: 20`), `Expanded`, `Row`, and `Column`.
2. **Never use oversized font sizes**: Scale down Figma text to mobile standards:
   - Page Title: `20px - 22px`
   - Section / Card Header: `16px - 18px`
   - Body text: `13px - 14px`
   - Subtext / Metadata: `11px - 12px`
3. **Responsive Width**: Never hardcode fixed container widths like `354px`; use `double.infinity` inside responsive padding.
