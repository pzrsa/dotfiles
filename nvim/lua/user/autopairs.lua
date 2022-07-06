local npairs_status_ok, npairs = pcall(require, "nvim-autopairs")
if not npairs_status_ok then
  return
end

npairs.setup{
  check_ts = true,
}


