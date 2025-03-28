;;; init-eglot.el --- C/C++开发优化配置（带现代补全套件）

;; 一键运行程序（保持原功能）
(defun arch/run-c-program ()
  (interactive)
  (unless buffer-file-name (user-error "需要先保存文件"))
  (let* ((default-directory (file-name-directory buffer-file-name))
         (exe (concat (file-name-sans-extension buffer-file-name)
                      (when (eq system-type 'windows-nt) ".exe")))
         (cmd (if (eq system-type 'windows-nt) exe (concat exe))) ; 修正Unix执行路径
         (buffer (format "*Running %s*" exe)))
    (cond
     ((not (file-exists-p exe)) (user-error "请先编译: C-c C-c"))
     ((file-executable-p exe)
      (async-shell-command cmd buffer)
      (pop-to-buffer buffer
                     `((display-buffer-reuse-window
                        display-buffer-in-direction)
                       (direction . right)
                       (window-width . 0.4))))
     (t (user-error "添加执行权限: chmod +x %s" exe)))))

;; 编译命令生成器（保持原功能）
(defun arch/compile-c-command ()
  (let ((target (concat (file-name-sans-extension buffer-file-name)
                        (when (eq system-type 'windows-nt) ".exe")))
        (compiler (if (eq major-mode 'c++-mode)
                      "clang++ -std=c++20"
                    "clang -std=c17")))
    (format "%s -Wall -Wextra -o %s %s"
            compiler
            (shell-quote-argument target)
            (shell-quote-argument buffer-file-name))))

;; 增强模式初始化
(defun arch/c-init ()
  (setq-local compile-command (arch/compile-c-command))
  (setq c-basic-offset 4 indent-tabs-mode nil)
  (eglot-ensure) ; LSP 初始化
  ;; 现代补全集成（不新增功能仅配置）
  (corfu-mode 1)                  ; 启用内联补全
  (local-set-key (kbd "C-c C-c") #'compile)
  (local-set-key (kbd "C-c C-r") #'arch/run-c-program))

;; Eglot主配置（带补全套件整合）
(use-package eglot
  :ensure nil
  :hook
  ((c-mode c++-mode) . arch/c-init)
  (before-save . eglot-format-buffer)
  :custom
  (eglot-autoshutdown t)
  (eglot-send-changes-idle-time 0.5)
  :config
  ;; LSP服务器配置
  (setq eglot-server-programs
        '(((c-mode c++-mode) . ("clangd"
				 "--background-index"
				 "--clang-tidy"
				 "--header-insertion=never"
				 "--pch-storage=memory"))))
        
  ;; Vertico+Orderless搜索增强
  (setq completion-category-overrides '((eglot (styles orderless)))) ; LSP结果使用orderless
  (setq read-file-name-completion-ignore-case t
        read-buffer-completion-ignore-case t
        completion-ignore-case t)
  
  ;; Marginalia注解增强
  (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light)
        eglot-ignored-server-capabilities '(:documentHighlightProvider)
        completions-detailed t)

  ;; Corfu内联补全配置
  (with-eval-after-load 'corfu
    (setq corfu-auto t
          corfu-cycle t
          corfu-preselect 'prompt
          corfu-quit-no-match 'separator)
    (define-key corfu-map (kbd "M-n") #'corfu-next)
    (define-key corfu-map (kbd "M-p") #'corfu-previous)))

(provide 'init-eglot)
