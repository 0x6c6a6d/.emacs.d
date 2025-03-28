(use-package emacs
  :ensure nil
  :init
  (setq
   gc-cons-threshold most-positive-fixnum
   gc-cons-percentage 0.6
   frame-inhibit-implied-resize t
   default-frame-alist '((height . 45) (width . 145))
   )
  (setq-default 
   cursor-type 'bar
   scroll-conservatively 1000
   read-process-output-max(* 4 1024 1024)
   )
  :hook
  (emacs-startup . (lambda ()
		     (setq gc-cons-threshold 16777216
			   gc-cons-percentage 0.1)
		     "Statistic for the startup time."
		     (message "Emacs loaded in %s with %d garbage collections."
			      (format "%.2f seconds" (float-time (time-subtract after-init-time before-init-time)))
			      gcs-done))))



(provide 'early-init)
