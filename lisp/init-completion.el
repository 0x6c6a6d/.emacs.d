;;; init-completion.el --- 现代化补全堆栈配置 -*- lexical-binding: t; -*-

;; 垂直补全框架
(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom
  (vertico-cycle t)
  (vertico-resize nil)
  (vertico-count 15))

;; 模糊匹配引擎
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        read-file-name-completion-ignore-case t
        read-buffer-completion-ignore-case t
        completion-ignore-case t
        completion-category-overrides
        '((file (styles basic partial-completion))  ; 文件路径混合补全
          (buffer (styles orderless))
          (symbol (styles orderless)))))

;; 注解增强
(use-package marginalia
  :ensure t
  :after vertico
  :config
  (marginalia-mode)
  (setq marginalia-align 'right
        marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light)
        completions-detailed t))

;; 即时补全界面
(use-package corfu
  :ensure t
  :hook ((prog-mode text-mode) . corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  (corfu-separator ?\s)
  (corfu-quit-at-boundary 'separator)
  :config
  ;; 终端优化
  (when (not (display-graphic-p))
    (setq corfu-popupinfo-delay nil
          corfu-auto-delay 0.2)
    (corfu-terminal-mode +1))
  ;; 布局设置
  (setq corfu-min-width 40
        corfu-max-width 120
        corfu-count 12
        corfu-popupinfo-min-width 60
        corfu-popupinfo-max-width 90))

;; 文档弹窗增强
(use-package corfu-popupinfo
  :after corfu
  :config (corfu-popupinfo-mode))

;; 全局交互优化配置
(use-package emacs
  :init
  ;; 忽略大小写
  (setq read-file-name-completion-ignore-case t
        read-buffer-completion-ignore-case t
        completion-ignore-case t)
  
  ;; 统一 Tab 行为
  (setq tab-always-indent 'complete
        completion-cycle-threshold 3)
  
  ;; Minibuffer 集成
  (defun corfu-enable-in-minibuffer ()
    "当 Vertico 未激活时在 minibuffer 启用 Corfu"
    (unless (or (bound-and-true-p vertico--input)
                (bound-and-true-p selectrum--active))
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer 90))

(provide 'init-completion)
