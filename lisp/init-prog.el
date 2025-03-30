;; -*- lexical-binding: t; -*-

;; 编程配置
(use-package prog-mode
  :ensure nil
  :defer 1
  :hook
  (prog-mode . display-line-numbers-mode)
  (prog-mode . hl-line-mode)
  
  :config
  (setq
   display-line-numbers-width 3
   indicate-empty-lines t))

;; 内置语法检查
(use-package flymake
  :ensure nil
  :defer t)

;; 版本控制集成
(use-package vc-hooks
  :ensure nil
  :defer t
  :config
  (setq vc-follow-symlinks t))

;; Scheme 配置 
(load "./scheme-prog.el")
(use-package scheme-mode-hook
  :init
  (setq scheme-program-name "chez")
  :bind (("<f5>" . scheme-send-last-sexp-split-window)
	 ("<f6>" . scheme-send-definition-split-window)))

(provide 'init-prog)

