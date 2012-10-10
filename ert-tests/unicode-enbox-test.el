
;;; requires and setup

(when load-file-name
  (setq pcache-directory (expand-file-name "test_output/" (file-name-directory load-file-name)))
  (setq package-enable-at-startup nil)
  (setq package-load-list '((pcache t)
                            (persistent-soft t)
                            (ucs-utils t)
                            (list-utils t)
                            (string-utils t)))
  (when (fboundp 'package-initialize)
    (package-initialize)))

(require 'persistent-soft)
(require 'ucs-utils)
(require 'list-utils)
(require 'string-utils)
(require 'unicode-enbox)


;;; unicode-enbox-unicode-display-p

(ert-deftest unicode-enbox-unicode-display-p-01 nil
  :tags '(:interactive)
  (should
   (unicode-enbox-unicode-display-p)))


;;; unicode-enbox

(ert-deftest unicode-enbox-01 nil
  (should (equal "┌────┐\n│Test│\n└────┘"
                 (unicode-enbox "Test"))))

(ert-deftest unicode-enbox-02 nil
  (should (equal "┌─────────┐\n│Multiline│\n│Test     │\n└─────────┘"
                 (unicode-enbox "Multiline\nTest"))))

(ert-deftest unicode-enbox-03 nil
  (should (equal "╭─────────╮\n│Multiline│\n│Test     │\n╰─────────╯"
                 (let ((unicode-enbox-default-type "Rounded"))
                   (unicode-enbox "Multiline\nTest")))))

(ert-deftest unicode-enbox-04 nil
  (should (equal "┏━━━━━━━━━┓\n┃Multiline┃\n┃Test     ┃\n┗━━━━━━━━━┛"
                 (let ((unicode-enbox-default-type "Heavy"))
                   (unicode-enbox "Multiline\nTest")))))

(ert-deftest unicode-enbox-05 nil
  (should (equal "╔═════════╗\n║Multiline║\n║Test     ║\n╚═════════╝"
                 (let ((unicode-enbox-default-type "Double"))
                   (unicode-enbox "Multiline\nTest")))))

(ert-deftest unicode-enbox-06 nil
  (should (equal ".---------.\n|Multiline|\n|Test     |\n+---------+"
                 (let ((unicode-enbox-default-type "ASCII"))
                   (unicode-enbox "Multiline\nTest")))))

(ert-deftest unicode-enbox-07 nil
  (should (equal "           \n Multiline \n Test      \n           "
                 (let ((unicode-enbox-default-type "Spaces"))
                   (unicode-enbox "Multiline\nTest")))))

(ert-deftest unicode-enbox-08 nil
  (should (equal "┌───────────┐\n│ Multiline │\n│ Test      │\n└───────────┘"
                 (unicode-enbox " Multiline \n Test " nil 'append))))

(ert-deftest unicode-enbox-09 nil
  (should (equal "┌───────┐\n│ultilin│\n│est    │\n└───────┘"
                 (unicode-enbox "Multiline\nTest" nil 'overwrite))))

(ert-deftest unicode-enbox-10 nil
  (should (equal "┌─────────┐\n│         │\n│Multiline│\n│Test     │\n└─────────┘"
                 (unicode-enbox " \n Multiline \n Test " nil nil 'append))))

(ert-deftest unicode-enbox-11 nil
  (should (equal "┌─────────┐\n│Test     │\n└─────────┘"
                 (unicode-enbox "Multiline\nTest\nText" nil nil 'overwrite))))

(ert-deftest unicode-enbox-12 nil
  "Deboxing should happen because the input carries a special text property."
  (should (equal "╭────╮\n│Test│\n╰────╯"
                 (unicode-enbox
                  (unicode-enbox "Test") nil nil nil nil "Rounded"))))

(ert-deftest unicode-enbox-13 nil
  "Deboxing should not happen because the input carries no special text property."
  (should (equal "╭──────╮\n│┌────┐│\n││Test││\n│└────┘│\n╰──────╯"
                 (unicode-enbox "┌────┐\n│Test│\n└────┘" nil nil nil nil "Rounded"))))

(ert-deftest unicode-enbox-14 nil
  "Deboxing should happen because it is forced by argument."
  (should (equal "╭────╮\n│Test│\n╰────╯"
                 (unicode-enbox "┌────┐\n│Test│\n└────┘" nil nil nil 'force "Rounded"))))

(ert-deftest unicode-enbox-15 nil
  "Horizontal bar should be created from line of only dashes."
  (should (equal "┌────────┐\n│Category│\n├────────┤\n│item one│\n│item two│\n└────────┘"
   (unicode-enbox "Category\n--\nitem one\nitem two"))))


;;; unicode-enbox-debox

(ert-deftest unicode-enbox-debox-01 nil
  (should (equal "┌────┐\n│Test│\n└────┘"
                 (unicode-enbox-debox "┌────┐\n│Test│\n└────┘"))))

(ert-deftest unicode-enbox-debox-02 nil
  (should (equal "Test"
                 (unicode-enbox-debox "┌────┐\n│Test│\n└────┘" t))))

(ert-deftest unicode-enbox-debox-03 nil
  (should (equal "Test"
                 (unicode-enbox-debox (unicode-enbox "Test")))))

(ert-deftest unicode-enbox-debox-04 nil
  "This is a bug.  If input doesn't match Rounded on all sides, no deboxing should happen."
  :expected-result :failed
  (should (equal "┌────┐\n│Test│\n└────┘"
                 (unicode-enbox-debox "┌────┐\n│Test│\n└────┘" t "Rounded"))))

(ert-deftest unicode-enbox-debox-05 nil
  "This is a bug.  Horizontal rules are not being restored."
  :expected-result :failed
  (should (equal "Category\n--------\nitem one\nitem two"
   (unicode-enbox-debox (unicode-enbox "Category\n--\nitem one\nitem two")))))

;;
;; Emacs
;;
;; Local Variables:
;; indent-tabs-mode: nil
;; mangle-whitespace: t
;; require-final-newline: t
;; coding: utf-8
;; byte-compile-warnings: (not cl-functions)
;; End:
;;

;;; unicode-enbox-test.el ends here
