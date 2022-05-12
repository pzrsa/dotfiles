local signs_status_ok, signs = pcall(require, "gitsigns")
if not signs_status_ok then
	return
end

signs.setup()
