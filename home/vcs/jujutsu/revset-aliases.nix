{ ... }:
{
  programs.jujutsu.settings.revset-aliases = {
    # find the closest pushable branch to the given branch
    "closest_pushable(to)" = /* jjrevset */ ''
      heads(::to & mutable() & ~description(exact:"") & (~empty() | merges()))
    '';

    # find local "trunk" branch, or fallback to trunk()
    "local_trunk()" = /* jjrevset */ ''
      coalesce(present(main), present(master), bookmarks("trunk"), trunk())
    '';

    "trunk" = /* jjrevset */ "trunk()";
    "local_trunk" = /* jjrevset */ "local_trunk()";

    # stack(x, n) is the set of mutable commits reachable from 'x', with 'n'
    # parents. 'n' is often useful to customize the display and return set for
    # certain operations. 'x' can be used to target the set of 'roots' to traverse,
    # e.g. @ is the current stack.
    "stack()" = /* jjrevset */ "ancestors(reachable(@, mutable()), 2)";
    "stack(x)" = /* jjrevset */ "ancestors(reachable(x, mutable()), 2)";
    "stack(x, n)" = /* jjrevset */ "ancestors(reachable(x, mutable()), n)";
    "stack" = /* jjrevset */ "stack()";

    # find the tip of the descendant lineage (excluding empty revisions)
    "tips(x)" = /* jjrevset */ "heads((x::) ~ empty())"; # ALL possible tips of the descendant lineage
    "tips()" = /* jjrevset */ "tips(@)";
    "tip(x)" = /* jjrevset */ "latest(tips(x))"; # most RECENT tip of the descendant lineage
    "tip" = /* jjrevset */ "tip(@)";
  };
}
