#import "template.typ": *

/***** para *****/
#let title = "Git & Latex" 
#let author = "梁子毅"
#let course_id = "系统开发工具基础"
#let instructor = "周小伟，范浩"
#let semester = "2024 Summer"
#let due_time = "Aug 28, 2024"
#let id = "22090001041"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

#set enum(numbering: "1.")
= Git
== 课后练习
#cprob[
  克隆本课程网站的仓库
][
  可以使用`git clone https://github.com/missing-semester-cn/missing-semester-cn.github.io.git`来克隆网站的仓库，运行结果如下@fig1
]
#figure(
image("./figure/img1.png", width: 70%),
caption: [
  `git clone`
  ],
)<fig1>
#cprob[
  将版本历史可视化并进行探索
][
  可以使用`git log --all --graph --decorate`进行可视化，效果如@fig2
]
#figure(
image("./figure/img2.png", width: 70%),
caption: [
  `git log --all --graph --decorate`
  ],
)<fig2>
#cprob[
  探索谁最后修改了README.md 文件？（提示：使用`git log`命令并添加合适的参数）
][
  有两种方式：
  + 直接用`git log`打开，会产生一个类似vim的编辑器，使用`/README.md`可以找到这个文件
  + 或者使用`git log -1 README.md`可以读取含有README.md的第一行如图@fig3
]
#figure(
image("./figure/img3.png", width: 70%),
caption: [
  探索谁最后修改了README.md 文件
  ],
)<fig3>
#cprob[
  最后一次修改 `_config.yml` 文件中 collections: 行时的提交信息是什么？（提示：使用 `git blame` 和 `git show`）
][
  + 可以使用`git blame _config.yml | grep collections`来显示
  + 也可以使用`git show --pretty=format:"%s" a88b4eac | head -1`
  + 二者运行如下@fig4
]
#figure(
image("./figure/img4.png", width: 70%),
caption: [
  最后一次修改 `_config.yml` 文件中 collections: 行时的提交信息
  ],
)<fig4>
#cprob[
  从 GitHub 上克隆某个仓库，修改一些文件。当您使用 `git stash` 会发生什么？通过 `git stash pop` 命令来撤销 `git stash` 操作，什么时候会用到这一技巧？
][
  + 使用`git stash`的时候，会将当前工作区清空，git会将刚刚工作区的文件存起来。
  + 当你完成其他分支的编写（比方说bug处理）再用`git stash pop`取出你之前隐藏的文件（比方说正在开发新功能的文件）
]
#cprob[
  当您执行 `git log --all --oneline` 时会显示什么？
][
  运行结果如下@fig5，因为输出太长，使用`tail -n 10`和管道来输出最后的10行内容
]
#figure(
image("./figure/img5.png", width: 70%),
caption: [
  `git log --all --oneline`的运行结果
  ],
)<fig5>
#cprob[
  与其他的命令行工具一样，Git 也提供了一个名为 ~/.gitconfig 配置文件 (或 dotfile)。请在 ~/.gitconfig 中创建一个别名，使您在运行 git graph 时，您可以得到 `git log --all --graph --decorate --oneline` 的输出结果；
][
  + 用`vim ~/.gitconfig`指令
  + 在其中输入
    ```shell
    [alias]
      graph = log --all --graph --decorate --oneline
    ```
  + 运行结果如下@fig6
]
#figure(
image("./figure/img6.png", width: 70%),
caption: [
  通过vim来编辑.gitconfig文件
  ],
)<fig6>
#figure(
image("./figure/img7.png", width: 70%),
caption: [
  起了别名后的运行结果
  ],
)<fig7>

== 实际运用
+ 连接github
  - 我已经连接过了github，连接之后.gitconfig文件中会有如@fig8 的内容，连接的指令如下
    ```git
    git config --global user.name  "name"//自定义用户名
    git config --global user.email "youxiang@qq.com"//用户邮箱
    ```
  #figure(
  image("./figure/img8.png", width: 70%),
  caption: [
    配置了过后的.gitconfig文件
    ],
  )<fig8>  
+ 建立本地版本库
  - 使用`git init`建立，如@fig9
  #figure(
  image("./figure/img9.png", width: 50%),
  caption: [
    git init
    ],
  )<fig9> 
+ 查看当前状体
  - 使用`git status`,如@fig10
  #figure(
  image("./figure/img10.png", width: 50%),
  caption: [
    git init
    ],
  )<fig10>   
+ 把项目源代码加入仓库
  - 使用`git add .`，如@fig11
  #figure(
  image("./figure/img11.png", width: 50%),
  caption: [
    git init
    ],
  )<fig11>   
+ 提交仓库
  - 使用`git commit -m "first commit"`对起脚进行说明，如@fig12
  #figure(
  image("./figure/img12.png", width: 50%),
  caption: [
    git init
    ],
  )<fig12>   
+ 配置ssh key
  - git bash中指令`ssh-keygen -t rsa -C "youxiang@qq.com"
` 会生成一对ssh密钥，将公钥放到github上（具体内容网上可查，不再赘述）

+ 推送
  - 使用`git push -u origin master`
  - 如果是fork的别人的仓库，可以发起pull request申请merge

- git实例一共12个

= Latex
- 我已经使用过latex一段时间了，这里根据我之前用latex使用的实验报告作为实例
== 基本结构
  - 代码如下：
  ```tex
  \documentclass[12pt]{article}

  \usepackage{amsmath,amsthm,amssymb,color,latexsym}%重要别删，对newenvironment有用
  \usepackage[a4paper,left=1cm,right=1cm,top=0.5cm,bottom=1cm]{geometry}
  \usepackage[all]{xy}
  \usepackage{geometry}        
      \geometry{letterpaper}    
  \usepackage{graphicx}
  \usepackage{url}
  \usepackage{ctex}
  \usepackage[colorlinks=true, allcolors=blue]{hyperref}
  \usepackage{type1cm}
      \fontsize{10.5pt}{15.75pt}

  \newtheorem{problem}{Problem}

  \newenvironment{jielun}[1][\it\bf{结论}]{\textbf{#1. } }{\ }
  \newenvironment{taolun}[1][\it\bf{讨论}]{\textbf{#1. } }{\ }

  \pagestyle{empty}
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \begin{document}
  \noindent \CJKfamily{zhkai}class name\hfill 16  \\
  HW4.202404\hfill 梁子毅

  %顶格 线
  \noindent\hrulefill
  \CJKfamily{zhkai}
  \begin{problem}

  \end{problem}
  \begin{enumerate}
      \item 
  \end{enumerate}

  \begin{quote}

  \end{quote}

  \begin{problem}

  \end{problem}

          
  \end{document}

  ```
  #speci_block[代码解释][
  + `\documentclass[12pt]{article}`: 这行代码定义了文档的类型为article，并且字体大小设置为12pt。
  + `\usepackage`: 这些行引入了多个LaTeX包，用于提供额外的功能，比如数学公式、定理环境、颜色、图形插入等。
  + `\geometry`: 这个命令用于设置页面的尺寸和边距。
  + `\newtheorem`: 定义了一个名为problem的新定理环境，用于标记问题。
  + `\newenvironment`: 定义了两个新的环境jielun和taolun，分别用于标记结论和讨论部分。
  + `\pagestyle{empty}`: 设置页面的样式为无页眉和页脚。
  + `%`: 是注释的符号，我这里用来作为分隔符
  + `\begin{document}`: 这标志着文档内容的开始。
  + `\noindent`: 这行代码防止段落首行缩进。
  + `\CJKfamily{zhkai}`: 这行代码指定了使用中文楷体字体。
  + `class name\hfill 16  \\`: 这行代码设置了文档的标题和日期，\hfill用于水平填充空白，使日期右对齐。
  + `HW4.202404\hfill 梁子毅`: 这可能是作业的编号和作者的名字，同样使用\hfill进行右对齐。
  + `\noindent\hrulefill`: 这行代码在文档中添加了一条水平线。
  + `\begin{problem}`: 开始一个新的问题环境。
  + `\begin{enumerate}`: 开始一个枚举列表。
  + `\end{enumerate}`: 结束枚举列表。
  + `\begin{quote}`: 开始一个引用环境。
  + `\end{quote}`: 结束引用环境。
  + `\begin{problem}`: 开始另一个问题环境。
  + `\end{document}`: 这标志着文档内容的结束。
  ]
    
  #figure(
  image("./figure/latex_1.png", width: 70%),
  caption: [
    l我的一份latex模板
    ],
  )<latex1> 
- 除此之外，常用的还有`\section`，`\title`,`\author`
- 如下@latex2 是我上个学期使用的一份报告模板\

  #figure(
  image("./figure/latex_2.png", width: 100%),
  caption: [
    我的一份latex模板
    ],
  )<latex2> 

- Latex实例一共20个（20个命令）

= 总结
- Git
  + git工具的思想相当有意思，但是接口的设计相当“丑”，很难记，我上github看了git的源码，感觉文件结构很混乱（大概是因为我功力不到家），看不透。
  + 目前我使用git会用clion等jetbrain的ide中的简便图形界面，当连接好仓库之后，直接点击图形界面的commit和push还是相当方便的
- Latex
  + 上一个学期用了大半个学期的latex来写实验报告，中途挑选了一个tau-book的模板@latex2 这个模板比较好看
  + 使用latex的感觉就是这个工具又臭又长，非常难用，但是确实比markdown的编译效果美观很多
  + 现在使用写报告用的是typst，一个新的排版语言，底层用rust构建，编译速度很快，而且很好配置（latex我配置了大半天都还是报错，最后使用overleaf来写）
  + 总的来说，如果没有一定的必要，推荐使用typst这个新生代来进行编写实验报告或者笔记，工具玩来玩去，轻量和便捷慢慢成为追求，满足需求即是王道