{ ... }:
{
  programs.jujutsu.settings.fileset-aliases = {
    # Keep review filters independent of the directory where jj is invoked.
    "LOCK" = {
      definition = "root-glob:'**/*.{lock,sum}' | root-glob:**/*-lock.*";
      doc = "Lockfiles";
    };
    "DOC" = {
      definition = "root-glob:'**/*.{txt,md,mdx}'";
      doc = "Documentation files";
    };
  };
}
