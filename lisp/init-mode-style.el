;; c/c++ 缩进风格
(c-add-style "microsoft"
             '("stroustrup"
               (c-offsets-alist
                (access-label ./)
                (innamespace . -)
                (inline-open . 0)
                (inher-cont . c-lineup-multi-inher)
                (arglist-cont-nonempty . +)
                (template-args-cont . +))))

(add-to-list 'c-default-style '(c++-mode . "microsoft"))
(add-to-list 'c-default-style '(c-mode . "microsoft"))

(provide 'init-mode-style)
