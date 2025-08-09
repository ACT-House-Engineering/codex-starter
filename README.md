# Codex Starter

A simple starter example for building with OpenAI Codex.

## Setup

1.  Navigate to your Codex environment settings:
    [https://chatgpt.com/codex/settings/environments](https://chatgpt.com/codex/settings/environments)
2.  Select your environment or create a new one for this repository.
3.  Scroll down to the "Code Execution" section.
4.  Paste the following into the "Setup script" field:

    ```sh
    chmod +x ./setup-codex.sh
    ./setup-codex.sh
    ```

## Helpful Commands

Here's an example command to get you started:

Ask
```
Generate a PRD of the following feature for me to review then I want you to build it: ...
```

Ask
```
Go through the codebase and find some tasks to clean up the code
```

Ask
```
Find and fix a file to improve using docs/code-quality/twelve-factor.md
```

Ask
```
Find and fix a file to improve using docs/code-quality/pragmatic.md
```

Ask
```
Generate a mermaid diagram and docs for ...
```

Code
```
Write test for and implement the follow feature: ...
```

Code
```
Go through the files in the tablecn dir and try removing "as" type casting and "any" types so that we have better type safety. 

- If an "as" or "any" can't be removed add a comment explaining why
- Be sure to correctly encode comment in JSX
- Leave "as const" as that's very type safe
- If you have to replace an instance of "as" with one or more instances of as then just leave it alone 
```


## Helpful Links

*   **Codex Documentation:** https://platform.openai.com/docs/codex
*   **Codex Docker Image:** https://github.com/openai/codex-universal
