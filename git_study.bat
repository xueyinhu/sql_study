:: git 是一个开源性的分布式版本控制系统（同时也是一个内容管理系统，工作管理系统等）
goto git_config 

git config 专门来配置或者读取相应的工作变量环境，这些变量可以存储再三个不同的位置
/etc/gitconfig 文件 系统中对所有用户的配置都普遍适用的配置，选项为 --system
~/.gitconfig 文件 用户目录下的配置文件，选项为 --global
.git/config 文件 只针对当前项目有效，

配置项：
git config --global user.name {name}
git config --global user.email {email}

查看配置信息：
git config --list

:git_config
goto git_work

1. 克隆 Git 资源作为工作目录
2. 在克隆的资源上添加或修改文件
3. 如果他人已经进行了修改，可以进行更新
4. 在提交前查看修改
5. 提交修改
6. 修改完成后，如果发现错误，可以进行撤回并再次修改提交

:git_work
goto git_basic

工作区：目录 (workspace)
暂存区：英文为 stage 或 index ，一般存在 .git/index 中 (staging area)
版本区：工作区的 .git 目录 (local repository)
远程仓库：(remote repository)

:git_basic
goto git_create

git init {dir_path} 初始化一个 Git 仓库，可以指定目录
git add {file_path} 将指定文件纳入版本控制
git clone {repo} {dir_path} 从现有的 Git 仓库中拷贝项目，可以指定拷贝位置
git config -e [-global] 针对当前仓库[系统上所有仓库]对配置文件进行修改

:git_create
goto git_oper

Git 的工作就是创建和保存项目的快照与之后的快照进行对比

Git 创建
git init 初始化仓库
git clone 拷贝一份远程仓库，也就是下载一个项目

Git 的提交与修改
git add 添加文件到暂存区
git status 查看仓库当前的状态，显示有变更的文件
git diff 比较文件的不同，即暂存区与工作区的差异
git commit 提交暂存区到本地仓库
git reset 回退版本
git rm 将文件从暂存区和工作区中删除
git mv 移动或重命名工作区文件

Git 提交日志
git log 查看历史提交记录
git blame {file} 以列表形式查看指定文件的历史修改记录

Git 远程操作
git remote 远程仓库操作
git fetch 从远程获取代码库
git pull 下载远程代码并合并
git push 上传远程代码并合并

:git_oper
goto git_branch

Git 分支实际上是指向快照的指针，每个分支代表一条独立的开发线

git branch {branch_name} 创建分支
git checkout {branch_name} 切换分支，会用该分支最后提交的快照替换掉工作目录的内容
git merge 合并分支
git branch 列出分支， master 分支是默认分支
git branch -d {branch_name} 删除分支

合并冲突：进行修改后使用 git add 来告知 Git 文件冲突已经解决

:git_branch
goto git_history

git log 查看历史提交记录
git blame {file} 以列表形式查看指定文件的历史修改记录

:git_history
goto git_tag

想要标记某个特别的提交快照，可以用 git tag 打上标签
git tag -a {info}

:git_tag


