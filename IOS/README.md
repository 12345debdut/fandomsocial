## fandomsocial iOS

SwiftUI-based iOS client for the fandomsocial experience. Current build focuses on the onboarding flow with custom navigation and keypad/OTP UI; home content is a placeholder.

### Overview
- Entry point: `fandomsocialApp` → `ContentView` uses `NavigationRouter` for navigation state.
- Screens: landing (brand + CTA), phone number input (custom numeric keypad), OTP verification (custom OTP fields), simple home placeholder for member/guest.
- Navigation: shared `Router` drives a `NavigationStack` via `Route` enum (landing, phone input, OTP verify, home).
- UI: SwiftUI components with custom capsules, concave circles, and reusable keyboard/OTP input views; assets live in `Assets.xcassets`.

### Project Structure
- `fandomsocial/` — app sources
  - `landing/` — landing, background, T&C views
  - `mobileNumber/` — phone input + OTP verification screens
  - `home/` — home screen and `UserType`
  - `navigation/` — `Router`, `Route`, and `NavigationRouter`
  - `components/` — shared UI pieces (custom keypad, OTP field, buttons, etc.)
  - `theme/` — color definitions
  - `logger/` — app logging helper
  - `Assets.xcassets/` — app icons and images
- `fandomsocial.xcodeproj/` — Xcode project

### Requirements
- Xcode 15+ (SwiftUI, iOS 17 previews)
- iOS 17+ deployment target (update as needed)

### Getting Started
1) Open `IOS/fandomsocial.xcodeproj` in Xcode.  
2) Select the `fandomsocial` scheme and a simulator/device.  
3) Run (`⌘R`). Landing screen should appear with phone/guest options.

### Current Behavior
- Phone flow: landing → phone input (custom keypad) → OTP verification (custom OTP input) → home placeholder.
- Guest flow: currently stubbed; extend `Route.home(.guest)` to customize guest behavior.

### Next Steps / TODO
- Wire real authentication/OTP backend and validation.
- Flesh out home experience for member vs guest.
- Add analytics, error handling, and unit/UI tests.
- Update this README with environment/setup details once backend is integrated.
