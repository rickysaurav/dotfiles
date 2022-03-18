# Unversioned applications might need to have their hashes updated pretty frequently. Since, they are well unversioned.
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
        buildInputs = [ undmg unzip ];
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
      sha256 = "2mHbDdCi+TcX4x2v5Fr5THM6arY56XT3rUq22eXCc+Y=";
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
      sha256 = "n5yL7qunD78O7H5nuK/QscO7yI8TRlqbx0wdwF8mTfQ=";
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

  iTerm2 = self.installApplication rec {
    name = "iTerm2";
    appname = "iTerm";
    version = "3.4.15";
    sourceRoot = "iTerm.app";
    src = super.fetchurl {
      url = "https://iterm2.com/downloads/stable/iTerm2-3_4_15.zip";
      sha256 = "32594ee038efdda96b5d7a325c11219bac667f69ca952a5ff080b26079871b78";
      # date = 18/03/2022;
    };
    description = "Mac terminal application";
    homepage = https://www.iterm2.com;
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
      sha256 = "sP/YhUyQE2rs3mUku7g1rCnxTdXiUJIvSzeM3NJEnyc=";
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
        sha256 = "hZb+9UmFgRr8ev+MPcIfvL9j/8Q+FHQlqzAqXYe1YQc=";
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
      sha256 = "agSuh6m5qvvlZuY/uzR9jttV01hFCYHtxu7qeguB5Z8=";
    };
    description = "Whatsapp is a free, cross-platform messaging app";
    homepage = https://www.whatsapp.com;
  };


  #TODO: Add karabiner with their config, displaylink, logi options
}
