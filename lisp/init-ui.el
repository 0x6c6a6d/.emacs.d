(use-package emacs
  :ensure nil
  :init
  (load-theme 'modus-vivendi-tinted t) ; 使用内置浅色主题
  
  ;; 字体配置
  (set-face-attribute 'default nil
		      :font (font-spec :family "Iosevka SS03" :size 20))
  
  (set-fontset-font t 'han (font-spec :family "WenQuanYi MicroHei" :size 20) nil 'prepend)
  (set-fontset-font t 'unicode (font-spec :family "Noto Color Emoji" :size 20) nil 'prepend)
  
  ;; 界面优化
  (setq
   frame-title-format '("%b - Emacs") ; 窗口标题格式
   x-stretch-cursor t                 ; 光标自动缩放
   blink-cursor-blinks 0)             ; 禁用光标闪烁
  ;; 模式行精简
  (use-package simple
    :ensure nil
    :config
    (size-indication-mode 1)
    (column-number-mode 1)
    (line-number-mode 1)))


(provide 'init-ui)
