local status_ok, signs = pcall(require, "gitsigns")
if not status_ok then
	return
end

signs.setup()
