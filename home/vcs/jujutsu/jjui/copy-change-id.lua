local change_id = context.change_id()
if not change_id then
  flash({ text = "No change ID selected", error = true })
  return
end

-- jjui supplies a shortest unique ID; expand it before copying.
local full_id, lookup_error = jj("log", "--no-graph", "-r", change_id, "-T", "change_id")
if not full_id or full_id == "" then
  flash({ text = "Failed to resolve change ID: " .. (lookup_error or "unknown error"), error = true })
  return
end

local ok, err = copy_to_clipboard(full_id)
if not ok then
  flash({ text = "Failed to copy change ID: " .. (err or "unknown error"), error = true })
  return
end
flash("Copied change ID: " .. full_id)
