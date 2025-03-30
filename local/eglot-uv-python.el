;; -*- lexical-binding: t; -*-

(defun arch/setup-python-env ()
  "动态配置 Python 开发环境"
  (interactive)
  (let* ((venv-root (locate-dominating-file default-directory ".venv"))
         (venv-dir (when venv-root (expand-file-name ".venv" venv-root)))
         (venv-bin (when venv-dir (expand-file-name "bin" venv-dir)))
         (pyright-cmd (when venv-bin (expand-file-name "pyright-langserver" venv-bin))))
    (if venv-dir
        ;; [存在虚拟环境时的逻辑]
        (progn

	  ;; 1. 注入环境变量（buffer-local）
          (setq-local process-environment 
                      (cons (format "PATH=%s:%s" venv-bin (getenv "PATH"))
                            process-environment))
          (setq-local exec-path (cons venv-bin exec-path))

	  ;; 2. 验证并配置 LSP 路径
          (if (not (file-executable-p pyright-cmd))
	    ;; 如果 pylsp 不存在，显示警告但继续执行
            (message "⚠️ pyright 未安装：执行 %s/bin/pip install 'pyright'" 
                     venv-dir)))

      ;; [无虚拟环境时的逻辑]
      (message "ℹ️ 未找到虚拟环境，使用全局 Python 配置"))))


(provide 'eglot-uv-python)
