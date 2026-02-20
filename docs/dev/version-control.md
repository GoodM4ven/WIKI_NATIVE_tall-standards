Use the [Graphite](https://graphite.dev) workflow for stacked pull requests.

Install the Graphite CLI with your package manager of choice (for example [bun](https://bun.sh) or [npm](https://npmjs.com)), then run `gt guide workflow` to see the latest command flow.

> [!NOTE]
> Graphite command options can change across versions. If a command differs in your setup, check `gt <command> --help`.

# Workflow

## Initialization

- Open the project in your IDE and terminal.
- If Git is not initialized yet (no `.git` directory), run `git init` first.
- Run `gt init`.
- Configure trunk branch settings with `gt config`.

## Pull Request Flow (Including Stacks)

1. Check out the branch you want to base your work on.
2. If your repository has multiple trunk candidates, set the right one in `gt config` under `Repository-level settings` -> `Trunk branch`.
3. Create a branch for your changes with `gt create --all --message "[v1.2.3] Short change description"`.
4. Update the current branch with `gt modify --all` whenever you add more commits.
5. For stacked changes, run `gt create` again from your current branch.
6. To update an older branch in the stack, use `gt checkout`, select it, make edits, then run `gt modify --all`.
7. Submit with `gt submit`. Use `gt submit --stack` when submitting multiple related branches.
8. After merges, go back to your trunk branch and run `gt sync` to clean local stacked branches and sync state.

## Trunking (Choosing a Base Branch)

1. Start with an up-to-date `main` branch (`gt checkout main` then `gt sync`).
2. Create the branch you want to keep as a long-lived trunk (for example `dev`).
3. Rename the branch if needed using `gt rename dev`.
4. Submit and merge the setup branch.
5. Set your repository trunk to `dev` in `gt config`.
6. Run `gt sync` again to align local branch state.

## Keeping Sub-Trunks Up to Date

1. Merge completed pull requests into `main`.
2. Check out `dev` (`gt checkout dev`).
3. Run `gt sync` to clean merged branches.
4. Fetch latest refs with `git fetch origin`.
5. Rebase on top of main: `git rebase origin/main`.
6. Push updates to the sub-trunk branch: `git push origin dev`.

### Create a GitHub Release Tag

1. Set trunk to `main` in `gt config`.
2. Check out `main` (`gt checkout main`).
3. Run `gt sync`.
4. Create your Git tag.
5. Push commits and tags (for example `git push --follow-tags`).
6. Create the release on GitHub.
7. Switch back to `dev`, set trunk back to `dev` if needed, and run `gt sync`.
