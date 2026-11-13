-- Copy every change marked with space in the revisions view, as full
-- change IDs, one per line.
local checked = revisions.checked()
if #checked == 0 then
  flash({ text = "No changes marked; use space to select", error = true })
  return
end

-- jjui hands us shortest unique IDs; expand each one before copying.
local full_ids = {}
for _, change_id in ipairs(checked) do
  local full_id, lookup_error = jj("log", "--no-graph", "-r", change_id, "-T", "change_id")
  if not full_id or full_id == "" then
    flash({ text = "Failed to resolve change ID " .. change_id .. ": " .. (lookup_error or "unknown error"), error = true })
    return
  end
  full_ids[#full_ids + 1] = full_id
end

local text = table.concat(full_ids, "\n")
local ok, err = copy_to_clipboard(text)
if not ok then
  flash({ text = "Failed to copy change IDs: " .. (err or "unknown error"), error = true })
  return
end
flash("Copied " .. #full_ids .. " change ID(s)")
