#
# Git
#

{
  programs = {
    git = {
      enable = true;
      userName = "Ole Magnus Fon Johnsen";
      userEmail = "me@omfj.no";
      signing = {
        key = "me@omfj.no";
        signByDefault = true;
      };
      aliases = {
        s = "status";
      };
    };
  };
}
