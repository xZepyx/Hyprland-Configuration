if status is-interactive
    set -g fish_greeting
    starship init fish | source
    fastfetch
    # Commands to run in interactive sessions can go here
end
