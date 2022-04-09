#TODO: Delete it later , it's annoying dealing with unversioned apps from nix.
self: super: {

  installApplication =
    { name
    , appname ? name
    , version
    , src
    , description
    , homepage
    , postInstall ? ""
    , sourceRoot ? "."
    , ...
    }:
      with super; stdenv.mkDerivation {
        name = "${name}-${version}";
        version = "${version}";
        src = src;
        buildInputs = [undmg];
        sourceRoot = sourceRoot;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          	mkdir -p "$out/Applications/${appname}.app"
          	cp -pR * "$out/Applications/${appname}.app"
        '' + postInstall;
        meta = with lib; {
          description = description;
          homepage = homepage;
          platforms = platforms.darwin;
        };
      };

  Docker = self.installApplication rec {
    name = "Docker";
    version = "unknown";
    sourceRoot = "Docker.app";
    src = super.fetchurl {
      url = "https://desktop.docker.com/mac/main/arm64/Docker.dmg";
      sha256 = "CNLh6yCgWTLb6boBrY9uglgz/mz1RnKnJq0Y5fXKuKg=";
      # date = 18/03/2022;
    };
    description = ''
      Docker Desktop for Mac is an easy-to-install application for building,
      debugging, and testing Dockerized apps on a Mac
    '';
    homepage = https://store.docker.com/editions/community/docker-ce-desktop-mac;
  };

  GoogleChrome = self.installApplication rec {
    name = "GoogleChrome";
    version = "unknown";
    sourceRoot = "Google Chrome.app";
    src = super.fetchurl {
      url = "https://dl.google.com/chrome/mac/universal/stable/CHFA/googlechrome.dmg";
      sha256 = "+ytAF17VbourVhCZnLER0WxIJejoCAuStkJWlIAouAM=";
      # date = 18/03/2022;
    };
    description = ''
      Google Chrome is a cross-platform web browser developed by Google.
    '';
    homepage = http://google.com/chrome/;
  };

  GoogleDrive = self.installApplication rec {
    name = "GoogleDrive";
    version = "unknown";
    src = super.fetchurl {
      url = "https://dl.google.com/drive-file-stream/GoogleDrive.dmg";
      sha256 = "3AzfGvW+rSNhYNHpKDGYFM70C8/JqpsXYZYr4tfEXnk=";
      # date = 18/03/2022;
    };
    description = ''
      Google drive is a cloud storage service that lets you store, sync, and share files.
    '';
    homepage = http://google.com/drive/;
  };

  Raycast = self.installApplication rec {
    name = "Raycast";
    appname = "Raycast";
    version = "unknown";
    sourceRoot = "Raycast.app";
    src = super.fetchurl {
      url = "https://api.raycast.app/v2/download";
      curlOpts = [ "-L" ];
      # without name the unpacking the download fails.
      name = "Raycast.dmg";
      sha256 = "GF8mqCjp2LtL/pnMteZ1PuwyGiOf0NF2azMEIpojRm4=";
    };
    description = "Mac Application launcher";
    homepage = https://www.raycast.com;
  };

  Spotify = self.installApplication
    rec  {
      name = "Spotify";
      version = "unknown";
      src = super.fetchurl {
        url = "http://download.spotify.com/Spotify.dmg";
        sha256 = "B8MLcMW2BxlYUnt3nWaQ2wPr8JKx4ZSWwd9qfuCMfkw=";
      };
      sourceRoot = "Spotify.app";
      description = "Spotify music for OSX";
      homepage = https://www.spotify.com/;
    };

  Whatsapp = self.installApplication rec {
    name = "Whatsapp";
    appname = "Whatsapp";
    version = "unknown";
    sourceRoot = "Whatsapp.app";
    src = super.fetchurl {
      url = "https://web.whatsapp.com/desktop/mac/files/WhatsApp.dmg";
      sha256 = "sha256-Fw9eC+40EqRl/jz6NNb5rWFgnmKhrp90DkPaF5wyDbs=";
    };
    description = "Whatsapp is a free, cross-platform messaging app";
    homepage = https://www.whatsapp.com;
  };


}
