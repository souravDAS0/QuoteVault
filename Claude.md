# Claude Project Instructions — QuoteVault

You are working inside the QuoteVault mobile application repository.

All UI designs are FINAL and provided as static reference images inside:

/Users/souravdas/personalProjects/quote_vault/assets/ui_pages/

---

## 🔒 CORE RULE (NON-NEGOTIABLE)

You must ONLY work on the task currently loaded into `current_task.md`.

- Do NOT work on files or features outside the active task
- Do NOT redesign UI
- Do NOT invent UI that is not present in the reference images
- Do NOT anticipate future tasks

If the user asks for anything outside `current_task.md`, respond with:

> **"Out of scope. Load the correct task using /scope."**

---

## 🎯 UI REFERENCE RULE

Every task includes one or more **UI reference images**.

You MUST:

- Open and mentally reference the listed image(s)
- Match layout, spacing, components, and visual hierarchy
- Treat the images as the source of truth

If something is unclear:

- Prefer **existing app conventions**
- Do NOT improvise new UI patterns

---

## 🧱 TECH ASSUMPTIONS

- Backend: Supabase (Auth + Database)
- Framework: As selected by developer
- UI: Implemented strictly from reference images
- Strings: No hardcoding (use constants / localization)

---

## 🧱 ARCHITECTURE (MANDATORY — CLEAN ARCHITECTURE)

This project MUST follow **Clean Architecture** principles.

### Layers (STRICT)

1. **Presentation**

   - Flutter widgets
   - UI-only logic
   - Reads state from Riverpod providers
   - ❌ No business logic
   - ❌ No Supabase calls

2. **Application (State / Use Cases)**

   - Riverpod controllers/providers
   - Orchestrates use cases
   - Calls domain services
   - Holds UI state (Freezed)

3. **Domain**

   - Freezed entities
   - Business rules
   - Repository interfaces (abstract classes)
   - ❌ No framework imports
   - ❌ No Supabase / Riverpod imports

4. **Infrastructure / Data**
   - Supabase implementations
   - DTOs (Freezed)
   - Repository implementations
   - Platform / network code

### Dependency Rule (NON-NEGOTIABLE)

Dependencies must point **inward only**:

```
Presentation → Application → Domain ← Infrastructure
```

- Domain MUST NOT depend on any other layer
- Application MUST NOT depend on Infrastructure directly
- Infrastructure depends on Domain interfaces

### Forbidden

- Supabase calls inside widgets or providers
- Business logic inside UI
- Skipping layers “for speed”

Clean Architecture violations are considered **task failure**.

---

## 🧠 STATE MANAGEMENT (STRICT)

### Riverpod Version

- **Riverpod: 3.0.3**
- `flutter_riverpod`
- `riverpod_annotation`
- `riverpod_generator` (code generation)

### Mandatory Rules

- ❌ NO legacy `Provider`, `StateProvider`, `ChangeNotifierProvider`
- ❌ NO manual provider wiring
- ❌ NO mutable state
- ❌ NO `setState` for business logic

✅ ALWAYS use:

- `@riverpod` / `@Riverpod` annotations
- Code-generated providers
- `AsyncValue` for async state
- `AutoDispose` where applicable

### Provider Pattern (MANDATORY)

```dart
@riverpod
class ExampleController extends _$ExampleController {
  @override
  FutureOr<ExampleState> build() async {
    // initial logic
  }
}
```

OR

```dart
@riverpod
Future<List<Quote>> quotes(QuotesRef ref) async {
  // fetch logic
}
```

---

## 🧊 DATA MODELS & STATE (FREEZED — MANDATORY)

### Freezed is NOT optional

### ❌ ABSOLUTELY FORBIDDEN

- Manual Dart `class` definitions for models or state
- Handwritten `copyWith`
- Mutable fields
- Manual `==` or `hashCode`
- Ad-hoc DTOs

### ✅ REQUIRED

- `@freezed`
- Immutable data
- `copyWith` generated
- JSON serialization via `fromJson / toJson`

### Canonical Example

```dart
@freezed
class Quote with _$Quote {
  const factory Quote({
    required String id,
    required String text,
    required String author,
    required String category,
    required bool isFavorite,
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) =>
      _$QuoteFromJson(json);
}
```

OR

```dart
@freezed
class HomeFeedState with _$HomeFeedState {
  const factory HomeFeedState({
    @Default([]) List<Quote> quotes,
    @Default(false) bool isLoading,
    String? error,
  }) = _HomeFeedState;
}
```

---

## 🧬 ARCHITECTURE RULES

- Widgets = UI only
- Providers = state & orchestration
- Services = Supabase / platform logic
- Models = Freezed only

### Dependency flow (STRICT):

```
Widget → Riverpod Provider → Service → Supabase
```

No business logic inside widgets.

---

## 🛠 CODE GENERATION (REQUIRED)

You must assume:

- build_runner is configured
- Code generation is expected and required

Whenever you add:

- a provider → use Riverpod annotations
- a model or state → use Freezed

❌ NEVER write boilerplate that can be generated.

---

## 🧭 WORKFLOW

1. Tasks live as individual `.md` files
2. `/scope <task_file.md>` copies the task into `current_task.md`
3. You must:
   - Read `current_task.md`
   - Follow its scope strictly
   - Complete all acceptance criteria
   - Stop when done

---

## ✅ TASK COMPLETION RULE

A task is complete **only if**:

- All acceptance criteria are satisfied
- UI matches the reference images
- Riverpod providers are annotation-based and code-generated
- ALL models and state use Freezed
- No unrelated code is modified
