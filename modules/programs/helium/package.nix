{ lib, pkgs }:

pkgs.appimageTools.wrapType2 rec {
  pname = "helium";
  version = "0.7.1.1";

  src = pkgs.fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
    sha256 = "sha256-spUogmjv+RNjtuDs5tY7vXFgKR62qUb85Gj/bERCza4=";
  };

  extraInstallCommands = let
    contents = pkgs.appimageTools.extractType2 { inherit pname version src; };
  in ''
    mkdir -p "$out/share/applications"
    mkdir -p "$out/share/lib/helium"
    cp -r ${contents}/opt/helium/locales "$out/share/lib/helium"
    cp -r ${contents}/usr/share/* "$out/share"
    cp "${contents}/${pname}.desktop" "$out/share/applications/"
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${meta.mainProgram}'
  '';

  meta = {
    description = "Private, fast, and honest web browser based on Chromium";
    homepage = "https://github.com/imputnet/helium-chromium";
    platforms = [ "x86_64-linux" ];
    license = lib.licenses.gpl3;
    mainProgram = "helium";
  };
}
