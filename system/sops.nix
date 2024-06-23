{config, ...}
: {
  sops.defaultSopsFile = ../secrets/mimi.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/gus/.config/sops/age/keys.txt";
  sops.secrets."config.dae" = {
    owner = config.users.users.gus.name;
  };
  sops.secrets."gh" = {};
  sops.secrets."gpt" = {
    owner = config.users.users.gus.name;
  };
}
