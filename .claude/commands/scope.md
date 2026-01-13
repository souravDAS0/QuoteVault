# /scope Command

## Purpose

Load a task into the active Claude working context.

## Behavior

1. Accept a task filename as argument
2. Copy its contents into `current_task.md`
3. Overwrite any existing content in `current_task.md`

## Usage

/scopes task_filename.md

Example:
/scope authentication.md

After execution:

- Claude must ONLY operate within `current_task.md`
