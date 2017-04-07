;;; config-bindings.el --- Key bindings.

;; ***************************************************************************
;; User iterface.
;;

;; Menu bar mode when you need it.
;;(global-set-key (kbd "C-<f10>") 'menu-bar-mode)


;; Window switching. (C-x o goes to the next window)
;;(windmove-default-keybindings) ;; Shift+direction
;;(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;; back one
;;(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; forward two

;; Font size
(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)


;; **************************************************************************
;; Editing and navigation.

;; You know, like Readline.
(global-set-key (kbd "C-M-h") 'backward-kill-word)

;; Line movement.
#(global-set-key (kbd "M-<up>") 'move-line-up)
#(global-set-key (kbd "M-<down>") 'move-line-down)

;; Automatically indent on return.
;; See http://www.emacswiki.org/emacs-en/AutoIndentation

(define-key global-map (kbd "RET") 'newline-and-indent)

;; Cursor movement.

;;(global-set-key (kbd "<home>") 'beginning-of-line)
;;(global-set-key (kbd "<end") 'end-of-line)
(global-set-key (kbd "<home>") 'beginning-of-visual-line)
(global-set-key (kbd "<end>") 'end-of-visual-line)
(global-set-key (kbd "C-<home>") 'beginning-of-buffer)
(global-set-key (kbd "C-<end>") 'end-of-buffer)

;; Killing and yanking.
(define-key global-map (kbd "<delete>") 'delete-char)
(define-key global-map (kbd "M-<delete>") 'kill-word)
(global-set-key (kbd "C-k") 'kill-whole-line)
(global-set-key (kbd "C-S-<backspace>") 'kill-and-join-forward)

;; Line insertion
(global-set-key (kbd "C-S-<return>") 'insert-empty-line-above)
(global-set-key (kbd "S-<return>") 'insert-empty-line-below)
(global-set-key (kbd "s-<return>") 'insert-empty-line-below-next-line)

;; CLean up whitespace
(global-set-key (kbd "C-c n") 'tidy-buffer)

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Revert buffer.
(global-set-key (kbd "C-c r") 'revert-buffer)


;; ***************************************************************************
;; Evaluation and shell access.
;;

;; Should be able to eval-and-replace anywhere.
(global-set-key (kbd "C-c e") 'eval-and-replace)

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Start a regular shell if you prefer that.
(global-set-key (kbd "C-x M-m") 'shell)


;; ***************************************************************************
;; Miscellaneous.
;;

;; Jump to a definition in the current file. (This is awesome.)
(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; Help should search more than just commands
(global-set-key (kbd "C-h a") 'apropos)


;; File finding
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)

;; Smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'smex-update-and-run)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Version control
(global-set-key (kbd "C-x g") 'magit-status)

;; Kill and unkill buffer.
(global-set-key [f3] 'my-kill-buffer)
(global-set-key [S-f3] 'my-unkill-buffer)

;; Revert buffer
(global-set-key [f5] 'my-revert-buffer)


;; Zencoding bindings.
(global-set-key (kbd "C-M-<return>") 'zencoding-expand-line)

;; Start ERC.
;;(global-set-key (kbd "M-<f1>") 'erc-start)


(global-set-key (kbd "<kp-delete>") 'delete-forward-char)
(global-set-key (kbd "C-<kp-delete>") 'kill-word)
;;(define-key global-map (kbd "<kp-delete>") 'delete-forward-char)
;;(define-key global-map [\d] 'delete-forward-char)


(provide 'config-bindings)
;;; config-bindings.el ends here
