{ lib, stdenv, fetchzip, unzip }:

stdenv.mkDerivation rec {
  pname = "gollama";
  version = "1.14.0";

  src = fetchzip {
    url = "https://github.com/sammcj/gollama/releases/download/${version}/gollama-macos.zip";
    sha256 = "sha256-HZ/6LTN57XtFCE87smmO8wr0V1O/RXoL2bnX0E8pzcY="; # You'll need to add the correct SHA256 hash here
    stripRoot = false;
  };

  nativeBuildInputs = [ unzip ];

  installPhase = ''
    mkdir -p $out/bin
    find . -name 'gollama' -type f -exec cp {} $out/bin/ \;
    chmod +x $out/bin/gollama
  '';

  meta = with lib; {
    description = "A CLI client for LLaMA/Alpaca models";
    homepage = "https://github.com/sammcj/gollama";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
