# TODO: Remove this overlay once nixpkgs PR #476565 is merged
# https://github.com/NixOS/nixpkgs/pull/476565
# Tracking issue: https://github.com/NixOS/nixpkgs/issues/475989
final: prev: {
  oculante = prev.oculante.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [
      ./libaom-sys-cmake-nasm-fix.patch
    ];
    patchFlags = [
      "-p1"
      "--directory=../${oldAttrs.pname}-${oldAttrs.version}-vendor"
    ];
  });
}
