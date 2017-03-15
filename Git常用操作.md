### 基本操作
##### 1\. git init————初始化仓库

    xzg@DESKTOP-3HASB31 MINGW64 ~ (xzg)
         $ mkdir git-tutorial

        xzg@DESKTOP-3HASB31 MINGW64 ~ (xzg)
         $ cd git-tutorial

        xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (xzg)
         $ git init
         Initialized empty Git repository in C:/Users/xzg/git-tutorial/.git/

        xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)

#####  2\. git status————查看仓库状态

    xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git status
         On branch master

        Initial commit

        nothing to commit (create/copy files and use "git add" to track)
#####  3\. git add————向暂存区中添加文件
         xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ touch README.md

        xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git status
         On branch master

        Initial commit

        Untracked files:
          (use "git add <file>..." to include in what will be committed)

            README.md

        nothing added to commit but untracked files present (use "git add" to track)

        xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git add README.md

        xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git status
         On branch master

        Initial commit

        Changes to be committed:
          (use "git rm --cached <file>..." to unstage)

            new file:   README.md

        xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)

##### 4\. git commit————保存仓库的历史记录
         xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git commit -m "commit log info"
         [master (root-commit) f31f627] commit log info
          1 file changed, 1 insertion(+)
          create mode 100644 README.md

git commit -m "此处是提交的日志信息"

##### 5\. git log————查看提交日志
         xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git log
         commit f31f6273ffa9f0a9cf8cd6f9754ec07d89e9f559
         Author: xzg <xzg8023@163.com>
         Date:   Tue Dec 6 15:43:04 2016 +0800

            commit log info

---

        xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git log --pretty=short
         commit f31f6273ffa9f0a9cf8cd6f9754ec07d89e9f559
         Author: xzg <xzg8023@163.com>
    
          commit log info
    
        xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git log README.md
         commit f31f6273ffa9f0a9cf8cd6f9754ec07d89e9f559
         Author: xzg <xzg8023@163.com>
         Date:   Tue Dec 6 15:43:04 2016 +0800

           commit log info
    
        xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)

- git log --pretty=short //只显示第一条简述信息

- git log README.md//直线式README.md文件的相关日志

---
         xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git log -p
         commit f31f6273ffa9f0a9cf8cd6f9754ec07d89e9f559
         Author: xzg <xzg8023@163.com>
         Date:   Tue Dec 6 15:43:04 2016 +0800
    
            commit log info
    
         diff --git a/README.md b/README.md
         new file mode 100644
         index 0000000..100b938
         --- /dev/null
         +++ b/README.md
         @@ -0,0 +1 @@
         +README
         \ No newline at end of file
    
        xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git log -p README.md
         commit f31f6273ffa9f0a9cf8cd6f9754ec07d89e9f559
         Author: xzg <xzg8023@163.com>
         Date:   Tue Dec 6 15:43:04 2016 +0800
    
            commit log info
    
        diff --git a/README.md b/README.md
         new file mode 100644
         index 0000000..100b938
         --- /dev/null
         +++ b/README.md
         @@ -0,0 +1 @@
         +README
         \ No newline at end of file

- git log -p 查看提交所带来的改动，文件的前后差异会显示在提交信息之后。
- git log -p README.md 查看关于 README.md文件，提交所带来的改动，文件的前后差异会显示在提交信息之后。

##### git diff————查看更改前后的差异
         xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git diff
         diff --git a/README.md b/README.md
         index 100b938..502aef1 100644
         --- a/README.md
         +++ b/README.md
         @@ -1 +1,5 @@
         -README
         \ No newline at end of file
         +README
         +
         +test
         +
         +git diff 测试
         \ No newline at end of file
     -  “-” 表示被删除的行
     -  “+” 表示添加的行
     ---
         xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git diff head
         diff --git a/README.md b/README.md
         index 100b938..eaa4888 100644
         --- a/README.md
         +++ b/README.md
         @@ -1 +1,5 @@
         -README
         \ No newline at end of file
         +README
         +
         +
         +
         +git diff 测试
         \ No newline at end of file

- git diff head 查看与最近一次提交记录的差异

### 分支操作

##### git branch —————显示分支一览表
         xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git branch
         * master

#### git checkout -b ————创建/切换分支
         xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (master)
         $ git checkout -b feature-A
         M       README.md
         Switched to a new branch 'feature-A'

- git checkout -b 新分支名称 

        连续使用以下两条命令也可以达到同样的效果

        git branch feature-A
        git checkout feature-A

此时再查看分支列表如下：

        xzg@DESKTOP-3HASB31 MINGW64 ~/git-tutorial (feature-A)
         $ git branch
         * feature-A
           master

- “ * ” 当前所在的分支，此时再进行相关操作则是发生在当前分支的

**注**  此处可能会出现以下错误：
 >error: pathspec 'master' did not match any file(s) known to git.
>这里是因为，还没有文件被提交过。即没有commit 过任何文件。
>当commit过以后就可以切换分支了
>备注：此时执行：git branch，只显示有dev 这个branch。
>不过我们可以直接再创建一个master出来。

具体操作如下：

        admin@admin-PC MINGW64 ~/git-tutorial (feature-A)
         $ git checkout master
         error: pathspec 'master' did not match any file(s) known to git.
    
        admin@admin-PC MINGW64 ~/git-tutorial (feature-A)
         $ git add xzg.md
    
        admin@admin-PC MINGW64 ~/git-tutorial (feature-A)
         $ git commit -m "文件提交信息"
         [feature-A (root-commit) 5dbd6b3] 文件提交信息
          1 file changed, 0 insertions(+), 0 deletions(-)
          create mode 100644 xzg.md
    
        admin@admin-PC MINGW64 ~/git-tutorial (feature-A)
         $ git push
         fatal: No configured push destination.
         Either specify the URL from the command-line or configure a remote repository using
    
          git remote add <name> <url>
    
        and then push using the remote name
    
           git push <name>
    
        admin@admin-PC MINGW64 ~/git-tutorial (feature-A)
         $ git log
         commit 5dbd6b35a05cc592b712e05300b866e763d2ede2
         Author: xzg <xzg8023@163.com>
         Date:   Tue Dec 6 22:22:49 2016 +0800
    
         文件提交信息
         admin@admin-PC MINGW64 ~/git-tutorial (feature-A)
         $ git checkout -b master
         Switched to a new branch 'master'
    
        admin@admin-PC MINGW64 ~/git-tutorial (master)
         $ git branch
          feature-A
         * master

+ git log --graph————以图表形式分支
    
                admin@admin-PC MINGW64 ~/git-tutorial (master)
                 $ git log --graph
                 * commit 1d92fafc16b7fc9d256060bead62c8f5b3afe92b
                 | Author: xzg <xzg8023@163.com>
                 | Date:   Tue Dec 6 22:44:08 2016 +0800
                 |
                 |     测试
                 |
                 * commit 88c07a79bb8c02f19a57515548f5d27587ceb196
                 | Author: xzg <xzg8023@163.com>        
                 | Date:   Tue Dec 6 22:34:22 2016 +0800
                 |
                 |     master add a file
                 |        
                 * commit 5dbd6b35a05cc592b712e05300b866e763d2ede2
                   Author: xzg <xzg8023@163.com>
                   Date:   Tue Dec 6 22:22:49 2016 +0800
    
                  文件提交信息

+ git reset————回溯历史版本

+ git commit --amend————修改提交信息
+ git rebase -i ————压缩历史
+ git remote add————添加远程仓库
+ git push————推送至远程仓库
+ git clone————获取远程仓库
+ git pull————获取最新的远程仓库分支


1. 本地分支关联远程分支
```
    droidMailClient (develop)
    $ git branch --set-upstream-to=origin/develop
    Branch develop set up to track remote branch develop from origin.
```
1. 本地分支和远程分支的关系

```
   git branch -vv
```

或者

>
     $ git branch -a
     * master
      remotes/origin/HEAD -> origin/master
      remotes/origin/master
      remotes/origin/notes


> 查看远程分支信息

```
    $ git remote -v
    origin  https://github.com/xxx/Notes.git (fetch)

    origin  https://github.com/xxx/Notes.git (push)
```

+ 对文件的版本追踪

>
    git update-index --assume-unchanged ＜filename＞       //停止对stack文件追踪
    git update-index --no-assume-unchanged ＜filename＞     //继续对stack文件追踪

> .gitignore 文件只能忽略本地未提交到服务器上的文件信息，如果要忽略服务器上已存在的文件，则需要使用git rm --cached 
 ＜filename＞ 或 git update-index --no-assume-unchanged ＜filename＞取出本地对该文件的追踪，然后在.gitignore文件中配置对应的规则

+  附：Git教程

     http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000 


     http://www.runoob.com/git/git-tutorial.html

    手把手教你使用git： http://blog.jobbole.com/78960/
    
#### 多账号切换

https://my.oschina.net/csensix/blog/184434

+ 本地分支关联远程分支

```
fatal: No remote repository specified.  Please, specify either a URL or a
remote name from which new revisions should be fetched.
```
> 修改本地仓库中的.git中的config文件信息，内容如下：
> 
```
[core]
	repositoryformatversion = 0
	filemode = false
	bare = false
	logallrefupdates = true
	symlinks = false
	ignorecase = true
[user]
	name = name
	email = email
[remote "origin"]  
        url = ssh:...autotest //....git
        fetch = +refs/heads/*:refs/remotes/origin/*  
        pushurl = ssh:...autotest   //....git
```

> 更换上边的url和pushurl即可

+ 中文显示问题

         git config --global core.quotepath false

> core.quotepath设为false的话，就不会对0x80以上的字符进行quote。中文显示正常,
.gitconfig（C:\Users\admin\.gitconfig）文件增加了以下配置信息：

```
[core]
	quotepath = false
```

### git解决本地多个ssh-key的问题

    通过不同的域名或者Ip地址，动态加载不同的ssh-key以及对应的用户信息。

 1. 添加key
 >在C:\Users\username\.ssh文件夹中执行Git Brash Here，输入以下指令:
 ```
  ssh-keygen -t rsa -C "youremail"
 ```
 > 如果提示：Your public key has been saved in /root/.ssh/id_rsa.pub.
 > 则修改文件名，再次保存即可
 2. 让git识别我们新增的key
 > 输入以下指令：
 ```
 ssh-agent bash
 ssh-add id_rsa_name//因为本身是在.ssh文件夹下，否则使用 ssh-add ~/.ssh/id_rsa_name
 ```
> id_rsa_name是新保存的key，
3. 配置config文件
```
#Host 是你远程仓库的地址，注意哦，如果有些服务器做的ip端口转发，这里不要带上端口号
Host git.oschina.net
#HostName 是远程仓库的地址，同样如果做的端口转发也不应带端口号
HostName git.oschina.net
#Port 端口号，如果有做转发需要在这里填写端口号，没有就不必要填
#Port 8800
#用户
User 111
#识别key的文件
IdentityFile ~/.ssh/id_rsa
#都指向同一个平台的话，下面的Host需要做个处理，因为我们在用这个key的时候根据Host从上到下进行查找，不做修改肯定会先查找到第一个key,依旧无效，随便改就好了，其他参数不做特殊处理
Host git222.oschina.net
HostName git.oschina.net
#Port 8800
User 222
IdentityFile ~/.ssh/id_rsa_2
```
> 如果没有config文件，则新建一个

>设置成功测试
+ 文件信息
```
#GitHub Git

Host github
HostName github.com
User xzg8023
IdentityFile ~/.ssh/id_rsa_github
```
```
$ git clone git@github:xzg8023/tools.git
Cloning into 'tools'...
Enter passphrase for key '/c/Users/xzg/.ssh/id_rsa_github':
remote: Counting objects: 322, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 322 (delta 0), reused 0 (delta 0), pack-reused 319
Receiving objects: 100% (322/322), 1.12 MiB | 72.00 KiB/s, done.
Resolving deltas: 100% (110/110), done.
Checking connectivity... done.

```

4. 可能存在的问题

+ 提交的用户信息不正确

> 一般是执行过以下指令导致:
```
git config --global user.name "your_name"

git config --global user.email  "your_email"
```
> 所以我们要取消git的全局设置
```
git config --global --unset user.name
git config --global --unset user.email
```

> 针对每一个项目，设置单独的用户信息，指令如下:
```
git init
git config user.name "your_name"
git config user.email "your_email"
```
+ AndroidStudio中会提示输入对应的用户信息
