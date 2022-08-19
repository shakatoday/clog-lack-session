(in-package :cl-user)
(defpackage clog-lack-session
  (:use :cl)
  (:export #:*middleware*
           #:current-session))
(in-package :clog-lack-session)

(defvar *lack-sessions* (make-hash-table :test 'equal :synchronized t))

(defparameter *middleware*
  (lambda (app)
    (lambda (env)
      (let ((current-lack-session-id (getf (getf env
                                                 :lack.session.options)
                                           :id)))
        (setf (gethash current-lack-session-id
                       *lack-sessions*)
              (getf env
                    :lack.session)))
      (funcall app env))))

(defun lack-session-id-from-browser-cookie (clog-obj)
  (let* ((cookie (clog:js-query clog-obj "document.cookie"))
         (key-value-pair-strings (ppcre:split ";" cookie))
         (key-value-pair-alist (mapcar (lambda (string)
                                         (let ((pairs (ppcre:split "="
                                                                   string
                                                                   :limit 2)))
                                           (cons (first pairs)
                                                 (second pairs))))
                                       key-value-pair-strings)))
    (cdr (assoc "lack.session"
                key-value-pair-alist
                :test #'string=))))

(defun current-session (clog-obj)
  (gethash (lack-session-id-from-browser-cookie clog-obj)
           *lack-sessions*))
