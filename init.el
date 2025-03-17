(setq custom-file (locate-user-emacs-file "custom.el"))

(setq-default auto-window-vscroll nil
	      default-directory "~"
	      frame-title-format "%b"
	      help-window-select t
	      initial-major-mode 'fundamental-mode
	      inhibit-startup-screen t
	      isearch-allow-motion t
	      isearch-lazy-count t
	      kill-whole-line t
	      mode-line-compact t
	      tab-width 4
	      indent-tabs-mode nil
          cursor-type 'bar
          highlight-symbol-at-point t
	      backup-directory-alist (quote (("." . "~/.emacs.d/backup")))
	      read-process-output-max (* 4 1024 1024)
	      require-final-newline t
	      scroll-conservatively 1000
	      use-short-answers t)


(add-to-list 'load-path (concat user-emacs-directory "lisp"))

(require 'init-rc)
(require 'init-mode-style)
(require 'init-scheme)


(add-hook 'emacs-startup-hook (lambda ()
	  "Statistic for the startup time."
	  (message "Emacs loaded in %s with %d garbage collections."
		   (format "%.2f seconds" (float-time (time-subtract after-init-time before-init-time)))
		   gcs-done)))

(add-hook 'window-setup-hook (lambda ()
	  (set-face-attribute 'default nil :font (font-spec :family "IosevkaFixedSS03 Nerd Font" :size 20))
	  (set-fontset-font t 'unicode (font-spec :family "Noto Color Emoji" :size 16) nil 'prepend)))

(add-hook 'window-setup-hook (lambda()
	  (load-theme 'modus-vivendi-tinted t)))

(add-hook 'after-init-hook 'global-auto-revert-mode)
(add-hook 'after-init-hook 'delete-selection-mode)
(add-hook 'after-init-hook 'global-visual-line-mode)
(add-hook 'after-init-hook 'pixel-scroll-precision-mode)


(use-package package
  :config
  (setq package-quickstart t)
  (dolist (i '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
	       ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
	       ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
    (add-to-list 'package-archives i))
  (unless (bound-and-true-p package--initialized)))

(use-package paren
  :config
  (setq show-paren-when-point-in-periphery t
	show-paren-when-point-inside-paren t
	show-paren-style 'mixed))

(use-package which-key :after which-key-mode)

(use-package display-line-numbers
  :ensure nil
  :init
  (setq display-line-numbers-width-start t)
  (setq-default display-line-numbers 'visual))

(use-package ido
  :config
  (setq ido-everywhere t
	ido-virtual-buffers t
	ido-use-faces t
	ido-default-buffer-method 'selected-window
	ido-auto-merge-work-directories-length -1)
  (ido-mode))

(use-package scheme-mode
  :init
  (setq scheme-program-name "chez")
  :hook (after-init . paredit-mode)
  :bind (("<f5>" . scheme-send-last-sexp-split-window)
	 ("<f6>" . scheme-send-definition-split-window)))

(use-package quickrun
  :ensure t
  :when (derived-mode-p 'prog-mode))

(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
