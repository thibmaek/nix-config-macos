{
  enable = true;

  delta = {
    enable = true;
    options = {
      navigate = true;
    };
  };

  userName = "Thibault Maekelbergh";
  userEmail = "thibault@thibtop.be";

  aliases = {
    a = "add";
    aa = "add .";
    amend = "commit --amend --no-edit";
    branches = "branch -a";
    ch = "checkout";
    prune-branches = "fetch origin --prune";
    d = "diff";
    discard = "checkout --";
    ft = "!f() { git checkout -b feature/\"$1\" 2> /dev/null || git checkout feature/\"$1\"; }; f";
    current-branch-name = "rev-parse --abbrev-ref HEAD";
    l = "log";
    pl = "pull";
    publish = "!git push -u origin $(git current-branch-name)";
    remotes = "remote -v";
    s = "status";
    tags = "tag -l";
    update = "push origin HEAD";
  };

  ignores = [ ".DS_Store" ];

  signing = {
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFQi1NuIqPAFqzV5Nb3o9k0hjEIJUe0YERrQK1z4ywzm";
    signByDefault = true;
  };

  extraConfig = {
    apply.whitespace = "fix";
    credential.helper = "osxkeychain";
    core = {
      fsmonitor = true;
      whitespace = "space-before-tab,-indent-with-non-tab,trailing-space";
      trustctime = false;
    };
    help.autocorrect = 1;
    init.defaultBranch = "main";
    push.default = "current";
    color = {
      ui = "auto";
      "branch" = {
        current = "yellow reverse";
        local = "yellow";
        remote = "green";
      };
      "diff" = {
        meta = "yellow bold";
        frag = "magenta bold";
        old = "red";
        new = "green";
      };
      "status" = {
        added = "green";
        changed = "yellow";
        untracked = "cyan";
      };
    };
    diff = {
      renames = "copies";
      colorMoved = "default";
    };
    merge = {
      log = true;
      conflictStyle = "diff3";
    };
    gpg = {
      format = "ssh";
      "ssh".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
  };
}
