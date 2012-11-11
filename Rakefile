desc "make configuretion for dotfiles"
task :default => [:vim, :zsh, :pry]

desc "make link for vim configuration"
task :vim do
    vim_dir = Dir.pwd + '/vim'
    dotfiles = [[".vimrc",".vimrc"],[".gvimrc",".gvimrc"],["vimfiles",".vim"]]
    dotfiles.each do |t,l|
        target = vim_dir + '/' + t
        link = Dir.home + '/' + l

        if FileTest.exist?(link)
            puts link + " is already exist!"
        else
            File.symlink(target,link)
        end
    end
end


desc "make link for zsh configuration"
task :zsh do
    zsh_dir = Dir.pwd + '/zsh'
    dotfiles = [[".zshrc",".zshrc"],[".zshenv",".zshenv"],[".zsh.d",".zsh"]]
    dotfiles.each do |t,l|
        target = zsh_dir + '/' + t
        link = Dir.home + '/' + l

        if FileTest.exist?(link)
            puts link + " is already exist!"
        else
            File.symlink(target,link)
        end
    end
end

desc "make link for pry configuration"
task :pry do
    pry_dir = Dir.pwd + '/coding/pry'
    dotfiles = ['.pry','.pryrc']
    dotfiles.each do |t|
        target = pry_dir + '/' + t
        link = Dir.home + '/' + t

        if FileTest.exist?(link)
            puts link + " is already exist!"
        else
            File.symlink(target,link)
        end
    end
end

desc "make link for luakit configuration [extra]"
task :luakit do
    target = Dir.pwd + '/luakit'
    link = ENV['XDG_CONFIG_HOME'] + '/luakit'

    if FileTest.exist?(link)
        puts link + " is already exist!"
    else
        File.symlink(target,link)
    end
end

desc "make link for x configuration [extra]"
task :x do
    x_dir = Dir.pwd + '/x'
    dotfiles = ['.Xdefaults','.Xmodmap','.Xresources']
    dotfiles.each do |t|
        target = x_dir + '/' + t
        link = Dir.home + '/' + t

        if FileTest.exist?(link)
            puts link + " is already exist!"
        else
            File.symlink(target,link)
        end
    end

end
