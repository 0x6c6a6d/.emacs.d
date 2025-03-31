;;; init-eglot.el

(load "~/.emacs.d/local/eglot-uv-python.el")
(load "~/.emacs.d/local/eglot-c.el")

(use-package eglot
  :after (vertico orderless)
  :ensure nil
  :hook
  (((c-mode c++-mode) . (lambda ()
			  (eglot-ensure)
			  (arch/c-init)))
   (python-mode . (lambda ()
		    (setq-local python-indent-offset 4
                                tab-width 4)
                    (arch/setup-python-env)
                    (eglot-ensure))))
  (before-save . eglot-format-buffer)
  :custom
  (eglot-autoshutdown t)
  (eglot-send-changes-idle-time 0.5)
  :config
  ;; 统一 LSP 服务器设置
  (setq eglot-server-programs
        '(((c-mode c++-mode) . ("clangd"
				"--background-index"
				"--clang-tidy"
				"--header-insertion=never"
				"--pch-storage=memory"))
          (python-mode . ("pyright-langserver" "--stdio"))))

  ;; Vertico+Orderless搜索增强
  (setq completion-category-overrides '((eglot (styles orderless)))) ; LSP结果使用orderless
  
  ;; Marginalia注解增强
  (setq eglot-ignored-server-capabilities '(:documentHighlightProvider)))

(provide 'init-eglot)
