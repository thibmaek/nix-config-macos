{
  enable = true;
  enableBashIntegration = false;
  enableZshIntegration = true;
  settings = {
    character.error_symbol = "✗";
    hostname.format = "[$hostname]($style) in ";
    os.disabled = true;
    container.disabled = true;
    username.disabled = true;
    custom.docker = {
      description = "Shows the Docker symbol if the current directory has Dockerfile or docker-compose files";
      files = ["Dockerfile" "docker-compose.yaml" "compose.yaml"];
      when = "command -v docker &> /dev/null; exit (echo $?);";
      command = "echo 🐳";
    };
  };
}
