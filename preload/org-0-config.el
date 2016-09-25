
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; Try to prevent the org package built-in from being loaded
;; (setq package-enable-at-startup nil)
;; (package-initialize nil)

;; Setup org-mode per http://doc.norang.ca/org-mode.html
(setq org-mode-user-lisp-path "~/emacs/org-mode")
(setq org-mode-user-contrib-lisp-path (concat org-mode-user-lisp-path "/contrib/lisp"))

(setq org-user-agenda-files (quote ("~/zoom-out"
                                    )))

(setq org-directory "~/zoom-out")

(setq org-default-notes-file (concat org-directory "/refile.org"))

;;(setq org-ditaa-jar-path "~/bin/ditaa0_9.jar")
(setq org-ditaa-jar-path (concat org-mode-user-contrib-lisp-path "contrib/scripts/ditaa.jar"))

(setq org-plantuml-jar-path "~/bin/plantuml.jar")

;; The following is customization according to https://www.suenkler.info/docs/emacs-orgmode/
;; in order to be more effective with GTD/Zooming out with org-mode

;; Show only one star in headlines, the front Hide:
;; (setq org-hide-leading-stars ' hidestars)

;; Enter to follow link:
;; (setq org-return-follows-link t)

;; Set up capture templates:

;; When a new task needs to be added I categorize it into one of a few things:

;; A phone call (p)
;; A meeting (m)
;; An email I need to respond to (r)
;; A new task (t)
;; A new note (n)
;; An interruption (j)
;; A new habit (h)
;; and pick the appropriate capture task.

;; Here is my setup for org-capture

;; (setq org-directory "~/zoom-out")
;; (setq org-default-notes-file "~/zoom-out/refile.org")

;; I use C-c c to start capture mode
;; (global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
;; (setq org-capture-templates
;;       (quote (("t" "todo" entry (file org-default-notes-file)
;;                "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
;;               ("r" "respond" entry (file org-default-notes-file)
;;                "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
;;               ("n" "note" entry (file org-default-notes-file)
;;                "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
;;               ("j" "Journal" entry (file+datetree "~/git/org/diary.org")
;;                "* %?\n%U\n" :clock-in t :clock-resume t)
;;               ("w" "org-protocol" entry (file org-default-notes-file)
;;                "* TODO Review %c\n%U\n" :immediate-finish t)
;;               ("m" "Meeting" entry (file org-default-notes-file)
;;                "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
;;               ("p" "Phone call" entry (file org-default-notes-file)
;;                "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
;;               ("h" "Habit" entry (file org-default-notes-file)
;;                "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; The quick clocking in and out of capture mode tasks (often it takes less than a minute to capture some new task details) can leave empty clock drawers in my tasks which aren't really useful. Since I remove clocking lines with 0:00 length I end up with a clock drawer like this:

;; * TODO New Capture Task
;;   :LOGBOOK:
;;   :END:
;;   [2010-05-08 Sat 13:53]
;; I have the following setup to remove these empty LOGBOOK drawers if they occur.

;; Remove empty LOGBOOK drawers on clock out
;; (defun bh/remove-empty-drawer-on-clock-out ()
;;   (interactive)
;;   (save-excursion
;;     (beginning-of-line 0)
;;     (org-remove-empty-drawer-at "LOGBOOK" (point))))

;; (add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

;; Refiling setup
; Targets include this file and any file contributing to the agenda - up to 9 levels deep
;; (setq org-refile-targets (quote ((nil :maxlevel . 9)
;;                                  (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO (not adopted by Yu)
;; (setq org-refile-use-outline-path t)

;; ; Targets complete directly with helm
;; (setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
;; (setq org-refile-allow-creating-parent-nodes (quote confirm))

;; ; Use IDO for both buffer and file completion and ido-everywhere to t
;; (setq org-completion-use-ido t)
;; (setq ido-everywhere t)
;; (setq ido-max-directory-size 100000)
;; (ido-mode (quote both))
;; ; Use the current window when visiting files and buffers with ido
;; (setq ido-default-file-method 'selected-window)
;; (setq ido-default-buffer-method 'selected-window)

; Use the current window for indirect buffer display
;; (setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
;; (defun bh/verify-refile-target ()
;;   "Exclude todo keywords with a done state from refile targets"
;;   (not (member (nth 2 (org-heading-components)) org-done-keywords)))

;; (setq org-refile-target-verify-function 'bh/verify-refile-target)

;; Setting up clocking per http://doc.norang.ca/org-mode.html#Clocking
;;
;; Resume clocking task when emacs is restarted
;; (org-clock-persistence-insinuate)
;;
;; Show lot of clocking history so it's easy to pick items off the C-F11 list
;; (setq org-clock-history-length 23)
;; Resume clocking task on clock-in if the clock is open
;; (setq org-clock-in-resume t)
;; Change tasks to NEXT when clocking in
;; (setq org-clock-in-switch-to-state 'bh/clock-in-to-next)
;; Separate drawers for clocking and logs
;; (setq org-drawers (quote ("PROPERTIES" "LOGBOOK" "CLOCKTABLE" "CLOCK"))) ; added "CLOCKTABLE" "CLOCK" by Yu maybe redundent
;; Save clock data and state changes and notes in the LOGBOOK drawer
;; (setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
;; (setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
;; (setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
;; (setq org-clock-persist t)
;; Do not prompt to resume an active clock
;; (setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
;; (setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
;; (setq org-clock-report-include-clocking-task t)

;; (setq bh/keep-clock-running nil)

;; (defun bh/clock-in-to-next (kw)
;;   "Switch a task from TODO to NEXT when clocking in.
;; Skips capture tasks, projects, and subprojects.
;; Switch projects and subprojects from NEXT back to TODO"
;;   (when (not (and (boundp 'org-capture-mode) org-capture-mode))
;;     (cond
;;      ((and (member (org-get-todo-state) (list "TODO"))
;;            (bh/is-task-p))
;;       "NEXT")
;;      ((and (member (org-get-todo-state) (list "NEXT"))
;;            (bh/is-project-p))
;;       "TODO"))))

;; (defun bh/find-project-task ()
;;   "Move point to the parent (project) task if any"
;;   (save-restriction
;;     (widen)
;;     (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
;;       (while (org-up-heading-safe)
;;         (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
;;           (setq parent-task (point))))
;;       (goto-char parent-task)
;;       parent-task)))

;; (defun bh/punch-in (arg)
;;   "Start continuous clocking and set the default task to the
;; selected task.  If no task is selected set the Organization task
;; as the default task."
;;   (interactive "p")
;;   (setq bh/keep-clock-running t)
;;   (if (equal major-mode 'org-agenda-mode)
;;       ;;
;;       ;; We're in the agenda
;;       ;;
;;       (let* ((marker (org-get-at-bol 'org-hd-marker))
;;              (tags (org-with-point-at marker (org-get-tags-at))))
;;         (if (and (eq arg 4) tags)
;;             (org-agenda-clock-in '(16))
;;           (bh/clock-in-organization-task-as-default)))
;;     ;;
;;     ;; We are not in the agenda
;;     ;;
;;     (save-restriction
;;       (widen)
;;       ; Find the tags on the current task
;;       (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
;;           (org-clock-in '(16))
;;         (bh/clock-in-organization-task-as-default)))))

;; (defun bh/punch-out ()
;;   (interactive)
;;   (setq bh/keep-clock-running nil)
;;   (when (org-clock-is-active)
;;     (org-clock-out))
;;   (org-agenda-remove-restriction-lock))

;; (defun bh/clock-in-default-task ()
;;   (save-excursion
;;     (org-with-point-at org-clock-default-task
;;       (org-clock-in))))

;; (defun bh/clock-in-parent-task ()
;;   "Move point to the parent (project) task if any and clock in"
;;   (let ((parent-task))
;;     (save-excursion
;;       (save-restriction
;;         (widen)
;;         (while (and (not parent-task) (org-up-heading-safe))
;;           (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
;;             (setq parent-task (point))))
;;         (if parent-task
;;             (org-with-point-at parent-task
;;               (org-clock-in))
;;           (when bh/keep-clock-running
;;             (bh/clock-in-default-task)))))))

;; (defvar bh/organization-task-id "eb155a82-92b2-4f25-a3c6-0304591af2f9")

;; (defun bh/clock-in-organization-task-as-default ()
;;   (interactive)
;;   (org-with-point-at (org-id-find bh/organization-task-id 'marker)
;;     (org-clock-in '(16))))

;; (defun bh/clock-out-maybe ()
;;   (when (and bh/keep-clock-running
;;              (not org-clock-clocking-in)
;;              (marker-buffer org-clock-default-task)
;;              (not org-clock-resolving-clocks-due-to-idleness))
;;     (bh/clock-in-parent-task)))

;; (add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)
