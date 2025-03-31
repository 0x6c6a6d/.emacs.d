(use-package emacs
  :ensure nil
  :init
  (setq
   gc-cons-threshold (* 128 1024 1024)    ; 128MB初始阈值
   gc-cons-percentage 0.5
   read-process-output-max (* 8 1024 1024) ; 8MB进程I/O缓冲
   process-adaptive-read-buffering t
   frame-inhibit-implied-resize t
   comp-speed 3
   comp-deferred-compilation t
   native-comp-async-report-warning-errors 'silent
   default-frame-alist '((height . 45) (width . 145)))

  ;; 通过/proc接口自动检测系统参数（修正正则表达式）
  (defun arch/get-system-memory ()
    "通过/proc/meminfo获取物理内存（MB）"
    (with-temp-buffer
      (ignore-errors
        (insert-file-contents "/proc/meminfo")
        (when (re-search-forward "MemTotal:[ \t]*\\([0-9]+\\) kB" nil t)
          (/ (string-to-number (match-string 1)) 1024)))))

  (when-let ((total-mem (arch/get-system-memory))
             (total-bytes (* total-mem 1024 1024)))
    ;; 动态设置内存回收阈值（转换为整数值）
    (setq memory-free-threshold (truncate (* total-mem 0.25 1024 1024))
          gc-cons-high-threshold (round (* total-bytes 0.6)))) ; 修正变量名

  ;; AMD Ryzen 专用优化（修正正则表达式）
  (when (with-temp-buffer
          (ignore-errors
            (insert-file-contents "/proc/cpuinfo")
            (and (re-search-forward "vendor_id[ \t]+: AuthenticAMD" nil t)
                 (re-search-forward "cpu family[ \t]+: 25" nil t))))
    ;; 内存对齐参数优化
    (setq malloc-alignment 64)    ; 匹配L1缓存行
    (setq gnutls-algorithm-priority "NORMAL:-GROUP-MEDIUM")) ; TLS优化

  (setq-default 
   cursor-type 'bar
   scroll-conservatively 1000)

  :hook
  (prog-mode . (lambda ()
                (setq-local gc-cons-threshold (* 256 1024 1024)))) ; 编程模式优化
    
  (emacs-startup . (lambda ()
                    ;; 延迟10秒后调整GC参数
                    (run-with-timer
                     10 nil
                     (lambda ()
                       (setq gc-cons-threshold (* 64 1024 1024)
                             gc-cons-percentage 0.2
                             garbage-collection-messages t)
                       ;; 空闲GC定时器
                       (run-with-idle-timer
                        15 t
                        (lambda ()
                          (unless (active-minibuffer-window)
                            (garbage-collect))))))
                    ;; 优化启动消息格式
                    (message 
                     "Emacs loaded in %.2fs | GC cycles: %d | Final threshold: %s"
                     (float-time (time-subtract after-init-time before-init-time))
                     gcs-done
                     (file-size-human-readable gc-cons-threshold)))))

(provide 'early-init)
