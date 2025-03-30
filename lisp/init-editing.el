;; -*- lexical-binding: t; -*-

;; 编辑增强
(use-package simple
  :ensure nil
  :defer 1
  :init
  (global-auto-revert-mode 1) ; 自动重新加载修改文件
  (electric-pair-mode 1)      ; 自动括号匹配
  (show-paren-mode 1)         ; 高亮匹配括号
  (delete-selection-mode 1)   ; 区域输入替换
  (setq
   indent-tabs-mode nil       ; 使用空格缩进
   tab-width 4
   require-final-newline t
   sentence-end-double-space nil)
  
  ;; 剪贴板集成
  (when (eq system-type 'gnu/linux)
    (setq
     select-enable-clipboard t         ; 共享系统剪贴板
     save-interprogram-paste-before-kill t))) ; 保留剪贴板历史

(provide 'init-editing)
