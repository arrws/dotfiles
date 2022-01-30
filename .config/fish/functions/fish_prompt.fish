function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    set brred "ff0000"
    set brgreen "00ff00"
    set brgrey "777777"

    # Only show host if in SSH or container
    # Store this in a global variable because it's slow and unchanging
    if not set -q prompt_host
        set -g prompt_host ""
        if set -q SSH_TTY
            or begin
                command -sq systemd-detect-virt
                and systemd-detect-virt -q
            end
            set -l host (hostname)
            set prompt_host $usercolor$USER$normal@(set_color $fish_color_host)$host$normal":"
        end
    end
    echo -n $prompt_host

    # set root color
    set_color $brgrey
    if functions -q fish_is_root_user; and fish_is_root_user
        set_color $brred
    end
    # print location
    printf '%s' (prompt_pwd)

    # print git
    set_color normal
    printf '%s' (fish_vcs_prompt)

    # set last status color
    set_color $brgreen
    if not test $last_status -eq 0
        set_color $brred
    end
    # print last command status
    printf ' > '
    set_color normal
end
