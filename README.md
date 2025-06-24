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

Code
```
Write test for and implement the follow feature: ...
```

## Helpful Links

*   **Codex Documentation:** https://platform.openai.com/docs/codex
*   **Codex Docker Image:** https://github.com/openai/codex-universal

## Deploying to Netlify

This project now uses [Astro](https://astro.build) and includes the Netlify adapter.
Run `pnpm build` to generate a production build. When pushed to Netlify, the `netlify.toml` configuration will automatically trigger the deployment.
