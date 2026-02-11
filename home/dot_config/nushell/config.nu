$env.config.show_banner = false

$env.config.edit_mode = 'vi'
$env.config.buffer_editor = "nvim"

alias c = clear
alias vi = nvim
alias lg = lazygit

use std "path add"

if ('/opt/homebrew' | path exists) {
  $env.HOMEBREW_PREFIX = '/opt/homebrew'
  $env.HOMEBREW_CELLAR = '/opt/homebrew/Cellar'
  $env.HOMEBREW_REPOSITORY = '/opt/homebrew'
  $env.MANPATH = $env.MANPATH? | prepend '/opt/homebrew/share/man'
  $env.INFOPATH = $env.INFOPATH? | prepend '/opt/homebrew/share/info'
  
  path add '/opt/homebrew/bin' '/opt/homebrew/sbin'
}

path add $"($env.HOME)/.bun/bin"
path add "/opt/homebrew/opt/node@20/bin"

let completer = {|spans|
    fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
    | from tsv --flexible --noheaders --no-infer
    | rename value description
    | update value {|row|
      let value = $row.value
      let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any {$in in $value}
      if ($need_quote and ($value | path exists)) {
        let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
        $'"($expanded_path | str replace --all "\"" "\\\"")"'
      } else {$value}
    }
}

$env.config.completions.external = {
    enable: true
    max_results: 100
    completer: $completer
}
