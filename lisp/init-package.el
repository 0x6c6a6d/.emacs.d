(use-package package
  :config
  (setq package-quickstart t)
  (dolist (i '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
	       ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
	       ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
    (add-to-list 'package-archives i))
  (unless (bound-and-true-p package--initialized)))

(provide 'init-package)
