{ config, ... }:

{
  programs.ssh = {
    enable = true;
    compression = true;
    controlMaster = "auto";
    controlPersist = "10m";
    forwardAgent = true;
    hashKnownHosts = true;
    matchBlocks = {
#      github = {
#        host = "github.com";
#        identitiesOnly = true;
#        identityFile = "~/.ssh/id_rsa_yubikey.pub";
#      };
      nixtst = {
        hostname = "192.168.122.15";
        user = "mudrii";
      };
    };
  };
}