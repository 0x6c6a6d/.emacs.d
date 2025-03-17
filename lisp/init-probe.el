
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode simpc-mode) "clangd"))
(add-hook 'c++-mode-hook #'eglot-ensure)
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'simpc-mode-hook #'eglot-ensure)

(use-package quickrun
  :ensure t
  :commands (quickrun)
  :init 
  (quickrun-add-command "c++"
    '((:command . "clang++")
      (:exec . ("%c -std=c++20 %o -o %e %s %e %a"))
      (:remove . ("%e")))
     :default "c++")
  (quickrun-add-command "c"
    '((:command . "clang")
      (:exec . ("%c -std=c11 %o -o %e %s %e %a"))
      (:remove . ("%e")))
     :default "c")
  (quickrun-add-command "python"
    '((:command . "python")
      (:exec . ("%c"))
      (:remove . ("%c")))
    :default "python"))

(provide 'init-probe)
