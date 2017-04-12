原来是可以正常使用的，突然就不行行，报以下异常
```
Failed to fork child process: Resource temporarily unavailable.
DLL rebasing may be required. See 'rebaseall --help'.
```

相关的问题界面，安装了多个版本，没有解决

* https://github.com/git-for-windows/git/issues/910

最终解决方案，安装了32为2.7版本的git解决问题（郁闷，但至少解决问题了）

* http://www.pzxiaoyi.com/gitbasherror.html