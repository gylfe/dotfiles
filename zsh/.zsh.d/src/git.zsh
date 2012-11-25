autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git 

# 下のformatsの値をそれぞれの変数に入れてくれる機能の、変数の数の最大。
# デフォルトだと2くらいなので、指定しておかないと、下のformatsがほぼ動かない。
zstyle ':vcs_info:*' max-exports 7

# 左から順番に、vcs_info_msg_{n}_ という名前の変数に格納されるので、下で利用する
zstyle ':vcs_info:*' formats '%R' '%S' '%b' '%s'
# 状態が特殊な場合のformats
zstyle ':vcs_info:*' actionformats '%R' '%S' '%b|%a' '%s'

# 4.3.10以上の場合は、check-for-changesという機能を使う。
autoload -Uz is-at-least
if is-at-least 4.3.10; then
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' formats '%R' '%S' '%b' '%s' '%c' '%u'
    zstyle ':vcs_info:*' actionformats '%R' '%S' '%b|%a' '%s' '%c' '%u'
fi

# zshのPTOMPTに渡す文字列は、可読性がそんなに良くなくて、読み書きしたり、つまりデバッグが
# 大変なため、文字列を組み立てるのは関数でやることにする。
# そのほうが分岐などを追加するのが楽。
# この先、追加で表示させたい情報はいろいろでてくるとおもうし。
function echo_rprompt () {
    local repos branch st color

    STY= LANG=en_US.UTF-8 vcs_info
    if [[ -n "$vcs_info_msg_1_" ]]; then
        # -Dつけて、~とかに変換
        repos=`print -nD "$vcs_info_msg_0_"`

        # if [[ -n "$vcs_info_msg_2_" ]]; then
            branch="$vcs_info_msg_2_"
        # else
        #     branch=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        # fi

        if [[ -n "$vcs_info_msg_4_" ]]; then # staged
            branch="%F{green}$branch%f"
        elif [[ -n "$vcs_info_msg_5_" ]]; then # unstaged
            branch="%F{red}$branch%f"
        else
            branch="%F{blue}$branch%f"
        fi

        print -n "[%25<..<"
        print -n "%F{yellow}$vcs_info_msg_1_%F"
        print -n "%<<]"

        print -n "[%15<..<"
        print -nD "%F{yellow}$repos%f"
        print -n "@$branch"
        print -n "%<<]"

    else
        print -nD "[%F{yellow}%60<..<%~%<<%f]"
    fi
}

setopt prompt_subst
RPROMPT='`echo_rprompt`'

##http://qiita.com/items/7180eb6c788233280502
##zshの右プロンプトに以下の情報を表示する。
###カレントディレクトリがgitリポジトリだった場合
###リポジトリルートからの相対パス(25文字以上は前半を省略)
###リポジトリルートのパス(ホームディレクトリは~に省略。15文字以上は前半を省略)
###カレントブランチ
###状態によって色を変える
###そうじゃなかった場合は、カレントディレクトリだけ表示