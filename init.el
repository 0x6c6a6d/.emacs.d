(setq custom-file (locate-user-emacs-file "custom.el"))

(add-to-list 'load-path "~/.emacs.d/lisp/")

(provide 'init-package)
(require 'init-core)
(require 'init-ui)
(require 'init-completion)
(require 'init-eglot)
(require 'init-editing)
(require 'init-prog)

(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
