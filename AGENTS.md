# Figma CSS to Mobile Flutter Rules

Whenever the user provides Figma CSS layers or designs:

## 1. Do NOT Copy Raw Figma Coordinates or Sizes
- **Never use fixed positions**: Ignore `position: absolute`, `left: ...px`, `top: ...px`, `calc(...)`.
- **Use Flutter Responsive Layouts**: Use `Padding(horizontal: 20)`, `Column`, `Row`, `Expanded`, and `Spacer` for left/right alignments.

## 2. Mobile Font Sizing Scale (Standard Mobile)
Do not use oversized Figma desktop/canvas font sizes. Map them strictly to standard mobile sizes:
- **Title / Page Header**: 20px - 22px (`FontWeight.w700`)
- **Card / Section Title**: 16px - 18px (`FontWeight.w600`)
- **Body / Subtitle**: 13px - 14px (`FontWeight.w400` / `w500`)
- **Captions / Badges / Secondary Details**: 11px - 12px (`FontWeight.w500`)
- **Micro / Status**: 10px - 11px

## 3. Responsive Text & Safe Layouts
- Always wrap trailing text or titles inside `Row` with `Expanded` or `Flexible` with `overflow: TextOverflow.ellipsis` to prevent overflow on smaller screens (down to 320px).
- Containers should use `double.infinity` or responsive padding rather than fixed `width: 354px` or `402px`.

## 4. Do NOT Run Tests Autonomously
- **Never run `flutter test`** on your own unless explicitly commanded by the user. The user will test and report errors themselves.
