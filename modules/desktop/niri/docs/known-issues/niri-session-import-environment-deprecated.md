# niri-session import-environment Deprecation Warning

## Symptom

A brief message appears on the TTY during login before niri takes over:

```
Calling import-environment without a list of variable names is deprecated.
```

## Cause

The `niri-session` script (line 36) calls `systemctl --user import-environment` without specifying variable names:

```bash
# Import the login manager environment.
systemctl --user import-environment
```

This has been deprecated by systemd since around 2021 (see [systemd#18137](https://github.com/systemd/systemd/issues/18137)).

## Upstream Status

- **Issue**: [YaLTeR/niri#254](https://github.com/YaLTeR/niri/issues/254)
- **Discussion**: [YaLTeR/niri#2780](https://github.com/YaLTeR/niri/discussions/2780)

The maintainer has acknowledged this but hasn't prioritized a fix because:
1. The deprecation warning has existed for years without breaking functionality
2. Removing the line could break user scripts that depend on environment variables being available in systemd user services
3. The proper fix would require explicitly listing all variables to import

## Impact

- **Severity**: Low (cosmetic warning only)
- **Functionality**: Not affected - environment variables are still imported correctly

## Workaround

None currently implemented. Possible solutions:
1. Override `niri-session` in NixOS config to patch the script
2. Wait for upstream fix
3. Contribute a PR to niri with an explicit variable list

## Investigation Notes

Other startup warnings observed (unrelated to this issue):
- `Environment variable $DISPLAY not set, ignoring.` - Expected on Wayland
- `EglExtensionNotSupported(["EGL_WL_bind_wayland_display"])` - Intel GPU driver limitation
- `error spawning xwayland-satellite` - xwayland-satellite not installed (optional)
