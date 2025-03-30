;; -*- lexical-binding: t; -*-

(use-package emacs
  :ensure nil
  :init
  (setq
   inhibit-startup-screen t       ; 禁用启动画面
   initial-scratch-message nil    ; 禁止显示初始消息
   make-backup-files nil          ; 禁用自动备份
   auto-save-default nil          ; 禁用自动保存
   ring-bell-function 'ignore     ; 禁用声音提示
   use-dialog-box nil             ; 控制台使用文本对话框
   use-short-answers t

   ;; 增强 eldoc 显示
   eldoc-echo-area-use-multiline-p 3  ; 最大化文档显示行数
   eldoc-idle-delay 0.4             ; 提示显示延迟
   )

  (menu-bar-mode -1)              ; 禁用菜单栏
  (tool-bar-mode -1)              ; 禁用工具栏
  (scroll-bar-mode -1)            ; 禁用滚动条

  ;; 编码设置
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-language-environment "UTF-8"))

(provide 'init-core)
