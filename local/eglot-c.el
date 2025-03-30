;; -*- lexical-binding: t; -*-

;; 一键运行程序
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

;; 编译命令生成器
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
  (local-set-key (kbd "C-c C-c") #'compile)
  (local-set-key (kbd "C-c C-r") #'arch/run-c-program))

(provide 'eglot-c)
