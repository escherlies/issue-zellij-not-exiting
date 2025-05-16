# Issue

Commands executed via 'just' in layout.kdl don't terminate when Zellij exits.


## Reproducable Test

1. Run `nix develop` to start the "test suite". This starts:
   1. Tab "Layout" spawn zellij via layout.kdl
   2. Tab "CLI" spawn same but with "manual" input (simulated here but you could to this manually by typing into a new zellij session)
2. Wait for everything to complete.
3. The called `./echo.sh` script should display all 4 server responses
4. Exit the Zellij via `Ctrl + Q`
5. After exiting, calling `./echo.sh` shows that the just via layout.kdl command still runs and did not exit as it should.


## Result: Zellij Exit Scenarios

The table below shows the behavior of commands when exiting Zellij with `Ctrl+Q`:

| Method     | Command Type         | Exits Properly | Command Details                                                                   |
| ---------- | -------------------- | -------------- | --------------------------------------------------------------------------------- |
| Layout KDL | Direct command (bun) | ✅ Yes          | `pane command="bun" { args "server.js" "3000" "..." }`                            |
| Layout KDL | Via just command     | ❌ No           | `pane command="just" { args "dev-layout" }`                                       |
| CLI        | Direct command (bun) | ✅ Yes          | Using `zellij action write-chars "bun server.js 3002 "Cli -> bun server.js 3002"` |
| CLI        | Via just command     | ✅ Yes          | Using `zellij action write-chars "just dev-cli"`                                  |

The issue is that only the specific combination of layout.kdl + just command fails to exit properly when Zellij is closed. Direct commands in layout.kdl, CLI commands via just, and direct CLI commands all exit properly. 

**Note** that the CLI simulation in this test suite replicates the same behavior as typing the commands manually in a Zellij session.


## Env

```
❯ zellij --version
zellij 0.42.2

❯ uname -av
Linux nixos 6.12.28 #1-NixOS SMP PREEMPT_DYNAMIC Fri May  9 07:50:53 UTC 2025 x86_64 GNU/Linux
```
