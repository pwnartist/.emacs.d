(defun my-go-mode-hook()
  (require 'company-go)
  (require 'golint)
  (require 'govet)
  (require 'flycheck)
  (require 'go-complete)

  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'completion-at-point-functions 'go-complete-at-point)

  (setq gofmt-command "goimports")
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  (add-to-list 'company-backends 'company-go)
  (flycheck-mode)

  ;; (require 'go-autocomplete)
  ;; (require 'auto-complete-config)
  ;; (ac-config-default)

  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-idle-delay 0)                         ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)                          ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

  (gorepl-mode)
  (yas-minor-mode)
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)


(defun my-go-playground-mode-hook ()
  (define-key go-playground-mode-map (kbd "<s-return>") 'go-playground-exec)
  )

(add-hook 'go-playground-mode-hook 'my-go-playground-mode-hook)

(provide 'setup-go)
