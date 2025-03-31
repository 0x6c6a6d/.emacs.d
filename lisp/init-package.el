;; -*- lexical-binding: t; -*-

(use-package package
  :ensure nil ; 核心包无需ensure
  :demand t   ; 强制提前加载
  :config
  ;; *重要改动* Emacs 30开始，package.el默认自动初始化，不需要手动调用 package-initialize
  ;; 禁用旧版package初始化告警
  (setq package-enable-at-startup nil)
  ;; 使用清华大学ELPA镜像源
  (setq package-archives
        '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
          ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
          ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))) 
  ;;; 自动开启quickstart模式（Emacs 30新特性）
  (when (and (fboundp 'package-quickstart)
             (not (or noninteractive (daemonp))))
    (setq package-quickstart t)
    ;; 仅首次启动时刷新缓存
    (unless (file-exists-p (expand-file-name "package-quickstart.el" user-emacs-directory))
      (package-refresh-contents))) 
  ;;; 自动化建议（解决可能出现的冲突）
  ;; 当用户手动调用package-initialize时给出提示
  (advice-add 'package-initialize :before
              (lambda (&optional _)
                (when (and (not noninteractive)
                           (not package--initialized))))))

(provide 'init-package)
