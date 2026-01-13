# Claude Project Instructions

You are working inside the QuoteVault mobile application repository.

## Core Rule (NON-NEGOTIABLE)

You must ONLY work on the task currently loaded into `current_task.md`.

- Do NOT modify files
- Do NOT suggest improvements
- Do NOT discuss features
- Do NOT answer questions

outside the scope of `current_task.md`.

If the user asks for anything unrelated to the current task:

- Respond with: "Out of scope. Load the correct task using /scope."

## Workflow

1. Tasks are defined as individual `.md` files.
2. The active task is copied into `current_task.md`.
3. You must:
   - Read `current_task.md`
   - Execute the task fully
   - Stop when the task is complete

## Assumptions

- Backend: Supabase (Auth + Database)
- Framework: As selected by the developer
- Designs are final and approved
- No redesign unless explicitly stated in task

## Output Expectations

- Clean, production-quality code
- Clear error handling
- No hardcoded strings
- Follow existing project structure

A task is considered complete ONLY when all acceptance criteria in `current_task.md` are met.
