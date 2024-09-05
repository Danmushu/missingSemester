#import "template.typ": *

/***** para *****/
#let title = "Shell & Vim & Data wrangling" 
#let author = "梁子毅"
#let course_id = "系统开发工具基础"
#let instructor = "周小伟，范浩"
#let semester = "2024 Summer"
#let due_time = "Sep 5, 2024"
#let id = "22090001041"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

#set enum(numbering: "1.")

= shell
== 课后练习
#cprob[
  阅读 man ls ，然后使用 ls 命令进行如下操作：
  + 所有文件（包括隐藏文件）
  + 文件打印以人类可以理解的格式输出 (例如，使用 454M 而不是 454279954)
  + 文件以最近访问顺序排序
  + 以彩色文本显示输出结果
][
  + `ls -a`
  + `ls -l -h`
  + `ls -l -t`
  + `ls --color=auto`
  运行如@ls
]
  #figure(
  image("./figure/ls.png", width: 70%),
  caption: [
    分别对应上面四个实例
    ],
  )<ls> 
#cprob[
  编写两个 bash 函数 marco 和 polo 执行下面的操作。 每当你执行 marco 时，当前的工作目录应当以某种形式保存，当执行 polo 时，无论现在处在什么目录下，都应当 cd 回到当时执行 marco 的目录。 为了方便 debug，你可以把代码写在单独的文件 marco.sh 中，并通过 source marco.sh 命令，（重新）加载函数。
][
  ```sh
#!bin/bash

marco() {
  # 使用 pwd 命令获取当前工作目录的完整路径
  echo "$(pwd)" > $HOME/marco_history.log  # 将路径写入日志文件，覆盖旧内容
  echo "the path $(pwd) has saved"        # 输出保存成功的消息
}

polo() {
  # 使用 cat 命令显示日志文件中保存的路径
  cat $HOME/marco_history.log
  # 使用 cd 命令切换到日志文件中显示的路径
  # 注意：这里使用了反引号 ` 来执行命令替换，获取日志文件中的路径
  cd `cat $HOME/marco_history.log`
  echo "Done!"  # 输出完成的消息
}
  ```
  运行结果如@shell1
]
  #figure(
  image("./figure/shell1.png", width: 70%),
  caption: [
    对应一个marco实例
    ],
  )<shell1> 

#cprob[
  假设您有一个命令，它很少出错。因此为了在出错时能够对其进行调试，需要花费大量的时间重现错误并捕获输出。 编写一段 bash 脚本，运行如下的脚本直到它出错，将它的标准输出和标准错误流记录到文件，并在最后输出所有内容。 加分项：报告脚本在失败前共运行了多少次。

][
  ```sh
  #!/bin/bash
  # 初始化计数器变量
  count=0
  # 清空 out.log 文件，用于记录输出
  echo > out.log
  # 无限循环，直到找到错误或手动停止
  while true
  do
      # 运行 buggy.sh 脚本，并将输出追加到 out.log 文件
      ./buggy.sh &>> out.log

      # 检查上一个命令的退出状态
      if [[ $? -ne 0 ]]; then
          # 如果命令失败，则打印日志文件内容
          cat out.log
          # 打印失败次数
          echo "failed after $count times"
          # 退出循环
          break
      fi
      # 如果命令成功，则增加计数器
      ((count++)) # 双括号比较醒目
  done
  ```
  运行结果如@shell2
]
  #figure(
  image("./figure/shell2.png", width: 70%),
  caption: [
    对应一个test实例
    ],
  )<shell2> 

  #cprob[
  - 本节课我们讲解的 find 命令中的 -exec 参数非常强大，它可以对我们查找的文件进行操作。 如果我们要对所有文件进行操作呢？例如创建一个zip压缩文件？我们已经知道，命令行可以从参数或标准输入接受输入。在用管道连接命令时，我们将标准输出和标准输入连接起来，但是有些命令，例如tar 则需要从参数接受输入。这里我们可以使用xargs 命令，它可以使用标准输入中的内容作为参数。 例如 ls | xargs rm 会删除当前目录中的所有文件。您的任务是编写一个命令，它可以递归地查找文件夹中所有的HTML文件，并将它们压缩成zip文件。注意，即使文件名中包含空格，您的命令也应该能够正确执行（提示：查看 xargs的参数-d）译注：MacOS 上的 xargs没有-d，查看这个issue

  - 如果您使用的是 MacOS，请注意默认的 BSD find 与GNU coreutils 中的是不一样的。你可以为find添加-print0选项，并为xargs添加-0选项。作为 Mac 用户，您需要注意 mac 系统自带的命令行工具和 GNU 中对应的工具是有区别的；如果你想使用 GNU 版本的工具，也可以使用 brew 来安装。][
  + 通过如@exec1 代码创建所需文件
  + 在输入下面的一行命令
  ```sh
    find . -type f -name "*.test" | xargs -d '\n'  tar -cvzf test.zip
  ```
    - 使用`find`命令从当前目录开始搜索所有`.test`文件
    - 用`xargs`命令处理管道来的`find`命令的输出
    - `-d '\n'`选项告诉`xargs`使用换行符作为分隔符，这样每个文件名都会被单独处理
    - 调用`tar`命令创建一个名为`test.zip`的压缩文件
      - `-c`选项表示创建一个新的压缩文件
      - `-v`选项表示在压缩过程中显示详细信息
      - `-z`选项表示使用`gzip`压缩
]
  #figure(
  image("./figure/exec1.png", width: 70%),
  caption: [
    操作实例1
    ],
  )<exec1>
  #figure(
  image("./figure/exec2.png", width: 70%),
  caption: [
    操作实例2
    ],
  )<exec2>  
== 自行发挥

= Vim
#cprob[
  下载课程提供的 vimrc，然后把它保存到 `~/.vimrc`。 通读这个注释详细的文件 （用 Vim!）， 然后观察 Vim 在这个新的设置下看起来和使用起来有哪些细微的区别。][
    - 文档如下
  ```vim
    " Comments in Vimscript start with a `"`.

    " If you open this file in Vim, it'll be syntax highlighted for you.

    " Vim is based on Vi. Setting `nocompatible` switches from the default
    " Vi-compatibility mode and enables useful Vim functionality. This
    " configuration option turns out not to be necessary for the file named
    " '~/.vimrc', because Vim automatically enters nocompatible mode if that file
    " is present. But we're including it here just in case this config file is
    " loaded some other way (e.g. saved as `foo`, and then Vim started with
    " `vim -u foo`).
    set nocompatible

    " Turn on syntax highlighting.
    syntax on

    " Disable the default Vim startup message.
    set shortmess+=I

    " Show line numbers.
    set number

    " This enables relative line numbering mode. With both number and
    " relativenumber enabled, the current line shows the true line number, while
    " all other lines (above and below) are numbered relative to the current line.
    " This is useful because you can tell, at a glance, what count is needed to
    " jump up or down to a particular line, by {count}k to go up or {count}j to go
    " down.
    set relativenumber

    " Always show the status line at the bottom, even if you only have one window open.
    set laststatus=2

    " The backspace key has slightly unintuitive behavior by default. For example,
    " by default, you can't backspace before the insertion point set with 'i'.
    " This configuration makes backspace behave more reasonably, in that you can
    " backspace over anything.
    set backspace=indent,eol,start

    " By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
    " shown in any window) that has unsaved changes. This is to prevent you from "
    " forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
    " hidden buffers helpful enough to disable this protection. See `:help hidden`
    " for more information on this.
    set hidden

    " This setting makes search case-insensitive when all characters in the string
    " being searched are lowercase. However, the search becomes case-sensitive if
    " it contains any capital letters. This makes searching more convenient.
    set ignorecase
    set smartcase

    " Enable searching as you type, rather than waiting till you press enter.
    set incsearch

    " Unbind some useless/annoying default key bindings.
    nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

    " Disable audible bell because it's annoying.
    set noerrorbells visualbell t_vb=

    " Enable mouse support. You should avoid relying on this too much, but it can
    " sometimes be convenient.
    set mouse+=a

    " Try to prevent bad habits like using the arrow keys for movement. This is
    " not the only possible bad habit. For example, holding down the h/j/k/l keys
    " for movement, rather than using more efficient movement commands, is also a
    " bad habit. The former is enforceable through a .vimrc, while we don't know
    " how to prevent the latter.
    " Do this in normal mode...
    nnoremap <Left>  :echoe "Use h"<CR>
    nnoremap <Right> :echoe "Use l"<CR>
    nnoremap <Up>    :echoe "Use k"<CR>
    nnoremap <Down>  :echoe "Use j"<CR>
    " ...and in insert mode
    inoremap <Left>  <ESC>:echoe "Use h"<CR>
    inoremap <Right> <ESC>:echoe "Use l"<CR>
    inoremap <Up>    <ESC>:echoe "Use k"<CR>
    inoremap <Down>  <ESC>:echoe "Use j"<CR>

  ```
]

#cprob[
  - 安装和配置一个插件： ctrlp.vim.
    + 用 mkdir -p ~/.vim/pack/vendor/start 创建插件文件夹
    + 下载这个插件： cd ~/.vim/pack/vendor/start; git clone https://github.com/ctrlpvim/ctrlp.vim
    + 阅读这个插件的 文档。 尝试用 CtrlP 来在一个工程文件夹里定位一个文件，打开 Vim, 然后用 Vim 命令控制行开始`:CtrlP`.
    + 自定义`CtrlP:`添加 configuration 到你的`~/.vimrc`来用按 Ctrl-P 打开 CtrlP
][
  - 运行结果如@ctlp
]
  #figure(
  image("./figure/ctlp.png", width: 70%),
  caption: [
    操作实例2
    ],
  )<ctlp>  
#cprob[如何在 Vim 中打开一个新文件？][
  可以通过命令模式输入`:e <filename>`打开一个新文件，或者使用`:edit <filename>`
]

#cprob[如何在 Vim 中保存文件？][
  - 按`:w`保存文件。
  - 按`:wq`保存并退出 Vim。
  - 按`:x`也是保存并退出的快捷方式。
  - 按`:w <filename>`可以将文件另存为指定的文件名。
]

#cprob[如何在 Vim 中复制和粘贴文本？][
  - 按`v`进入字符可视模式，选择文本，然后按`y` 复制。
  - 将光标移动到目标位置，按`p`粘贴到光标后，或按`shift+p`粘贴到光标前。
]

#cprob[如何在 Vim 中搜索和替换文本？][
  
]

#cprob[][
  
]
= Data wrangling
== 课后练习
#cprob[
  - 统计 words 文件 (/usr/share/dict/words) 中包含至少三个 a 且不以 's 结尾的单词个数。这些单词中，出现频率前三的末尾两个字母是什么？ 
  - sed 的 y 命令，或者 tr 程序也许可以帮你解决大小写的问题。共存在多少种词尾两字母组合？
  - 还有一个很 有挑战性的问题：哪个组合从未出现过？
][
  + `cat /usr/share/dict/words | tr "[:upper:]" "[:lower:]" | grep -E "^([^a]?*a){3}.*$" | grep -v "'s$"|wc -l`
    - tr xxx用于将大写字母转换为小写字母
    - `grep -E "^([^a]?*a){3}.*$"` 意为：匹配前面是不是a都可以含有a的组三次
    - grep -v 
]