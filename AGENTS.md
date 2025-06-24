# Contributor Guide

(These rules apply to the entire codebase so should not be very opinionated)

## Instructions
- Always prefer simple, readable implementation over premature optimization.
- Include an @ai JSDoc tag above any code you add or modify
- Only use Biome for linting and formatting. ESLint and Prettier are not used so
  the workflow stays fast.

## Commands
- Check types = `pnpm typecheck`
- AI Specific Lints = `ai-lint:changes`
- Lint - `pnpm lint`

`pnpm install` should already have been run at the setup step in ./setup-codex.sh

## Dev Environment Tips
- Run `ai-lint:changes`, `pnpm lint`, `pnpm typecheck` to verify the code is ready to commit
- Ensure your code is as readable as possible. 
- Avoid generic names like data, object, item, value, or just a single letter. 
- Use kebab-case for file names
- Preserve human written comments whenever they remain relevant. Update comments to match the new code, only removing them when they are clearly obsolete or incorrect.
- Ensure code is always very readable and avoid things like acronyms or generic names on things like variables and functions
- Always check docs/ for any relevant context

## Commit instructions
- Use Semantic Commit Messages
- Example: "feat: add login route"
- Include 'Generated with [Tool Name] with [Model Name]' in commit descriptions
- "Add 'Co-Authored-By: [You] <ai@act.house>' to all commits"
- "Include AI tool as co-author in commit trailers"
