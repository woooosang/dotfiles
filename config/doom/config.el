(setq user-full-name "Woosang Kang"
      user-mail-address "loiter97@gmail.com")

;; Automatically tangle this config.org file on save
(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.config/doom/config.org"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

;; Add anon. func as org mode hook, which then adds after-save-hook for current buffer
(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))
(message "complete")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;;; Prevent Extraneous Tabs
;; (setq-default indent-tabs-mode nil)
;; Maybe use tabs for some projects...
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)

(setq doom-theme 'doom-gruvbox)

;; Use specific font for Korean charset.
;; if you want to use different font size for specific charset,
;; add :size POINT-SIZE in the font-spec.
(set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))

(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 20))
  		(unless (doom-font-exists-p doom-font)
	 		(setq doom-font nil))
(setq doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 24))
  		(unless (doom-font-exists-p doom-big-font)
	 		(setq doom-big-font nil))
(setq doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font Mono" :size 20))
  		(unless (doom-font-exists-p doom-variable-pitch-font)
	 		(setq doom-variable-pitch-font nil))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org" "~/org/roam"))

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
         (next-win-buffer (window-buffer (next-window)))
         (this-win-edges (window-edges (selected-window)))
         (next-win-edges (window-edges (next-window)))
         (this-win-2nd (not (and (<= (car this-win-edges)
                     (car next-win-edges))
                     (<= (cadr this-win-edges)
                     (cadr next-win-edges)))))
         (splitter
          (if (= (car this-win-edges)
             (car (window-edges (next-window))))
          'split-window-horizontally
        'split-window-vertically)))
    (delete-other-windows)
    (let ((first-win (selected-window)))
      (funcall splitter)
      (if this-win-2nd (other-window 1))
      (set-window-buffer (selected-window) this-win-buffer)
      (set-window-buffer (next-window) next-win-buffer)
      (select-window first-win)
      (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x |") 'toggle-window-split)

;; Dim panes not in focus
(use-package! dimmer
  :custom (dimmer-fraction 0.2)
  :config (dimmer-mode))
(use-package! centered-window)

(setq default-frame-alist '((undecorated . t)))

;; Set PATH
(use-package exec-path-from-shell
  :config
  (dolist (var '("GOPATH"  "GOROOT" "PYTHONPATH" "CLASSPATH"))
    (add-to-list 'exec-path-from-shell-variables var))
  ;; (when (daemonp)
  ;; (exec-path-from-shell-initialize)))
    (exec-path-from-shell-initialize))

;; Set lsp diagnostic lines
(after! lsp-ui
  (setq lsp-ui-sideline-diagnostic-max-lines 8))

(defconst my-protobuf-style
  '((c-basic-offset . 4)
        (indent-tabs-mode . nil)))

(add-hook 'protobuf-mode-hook
  (lambda () (c-add-style "my-style" my-protobuf-style t)))

(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'gofmt-before-save)
            (setq tab-width 4)))

(with-eval-after-load 'lsp-mode
  (lsp-register-custom-settings
    '(("gopls.completeUnimported" t t)
      ("gopls.staticcheck" t t)
      ("gopls.experimentalWorkspaceModule" t t))))
(setq lsp-go-env '((GOFLAGS . "-tags=wireinject,tools")))

(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

(setq js-indent-level 2)
(setq js2-basic-offset 2)
(setq typescript-indent-level 2)

(setq sh-basic-offset 2)

(setq-default c-basic-offset 4)

(setq projectile-project-search-path '("~/repositories/" ("~/repositories/muselive" . 1)))

(defcustom projectile-project-root-functions
  '(projectile-root-local
    projectile-root-top-down
    projectile-root-bottom-up
    projectile-root-top-down-recurring)
  "A list of functions for finding project roots."
  :group 'projectile
  :type '(repeat function))

;; Register directories with go.mod as a independent project
(after! projectile
  (projectile-register-project-type
    'go
    '("go.mod")
    :project-file "go.mod")
  (projectile-register-project-type
    'java
    '(".project")
    :project-file ".project")
)

(message "complete")

(use-package! blamer
  :bind (("s-i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 35)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 140
                    :italic t)))
  :config
  (global-blamer-mode 1))

;; Make commit message windows long enough to read
(setq blamer-max-commit-message-length 80)

;; List directories first for ls-lisp
(setq ls-lisp-dirs-first t)

(require 'company-terraform)
(company-terraform-init)

(setq auth-sources '("~/.authinfo"))
;; (ghub-request "GET" "/user" nil
;;               :forge 'github
;;               :host "api.github.com"
;;               :username "muse-paul"
;;               :auth 'forge)
(setq code-review-auth-login-marker 'forge)

(setq org-preview-latex-default-process 'dvisvgm)
(after! org (setq org-startup-with-latex-preview t))
(add-hook 'org-mode-hook 'org-fragtog-mode)

;; (setf (cadr (assoc "ChkTeX" TeX-command-list)) "chktex -v6 -n8 %s")
(message "complete")

;; (add-to-list 'default-frame-alist '(fullscreen . fullboth))

(setq dired-listing-switches "-al --group-directories-first")
(when (eq system-type 'darwin)
  (setq insert-directory-program "gls" dired-use-ls-dired t)
  (setq insert-directory-program "/opt/homebrew/bin/gls"))

(add-hook 'dired-mode-hook 'treemacs-icons-dired-mode)

(setq doom-themes-treemacs-theme "doom-colors")

(use-package ox-hugo
  :ensure t   ;Auto-install the package from Melpa
  :after ox)

;; Populates only the EXPORT_FILE_NAME property in the inserted heading.
(with-eval-after-load 'org-capture
  (defun org-hugo-new-subtree-post-capture-template ()
    "Returns `org-capture' template string for new Hugo post.
See `org-capture-templates' for more information."
    (let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
           (fname (org-hugo-slug title)))
      (mapconcat #'identity
                 `(
                   ,(concat "* TODO " title)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " fname)
                   ":END:"
                   "%?\n")          ;Place the cursor here finally
                 "\n")))

  (add-to-list 'org-capture-templates
               '("h"                ;`org-capture' binding + h
                 "Hugo post"
                 entry
                 ;; It is assumed that below file is present in `org-directory'
                 ;; and that it has a "Blog Ideas" heading. It can even be a
                 ;; symlink pointing to the actual location of all-posts.org!
                 (file+olp "posts.org" "Posts")
                 (function org-hugo-new-subtree-post-capture-template))))

(setq org-log-done 'time)
