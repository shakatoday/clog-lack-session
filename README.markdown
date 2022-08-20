# Clog-Lack-Session
For using [lack-middleware-session](https://github.com/fukamachi/lack/blob/master/lack-middleware-session.asd) in [CLOG](https://github.com/rabbibotton/clog)
## Usage
```common-lisp
(clog:initialize 'SOME-HANDLER
                 :lack-middleware-list `(,lack.middleware.session:*lack-middleware-session*
                                         ,clog-lack-session:*middleware*))
```
Then, you can use ```(clog-lack-session:current-session clog-obj)``` to get the server side user session as a ```hash-table```

### Sample code
In your [CLOG](https://github.com/rabbibotton/clog) app, you can gethash to retrieve/setf server-side session based current user data
```common-lisp
(gethash :current-user
         (clog-lack-session:current-session clog-obj))
```
With the following code, when a user visit the root path ```"/"``` without corresponding current user data, the user can only see "I'm a static front page."
```common-lisp
(clog:initialize nil
                 :lack-middleware-list `(,lack.middleware.session:*lack-middleware-session*
                                         ,clog-lack-session:*middleware*
                                         ,(lambda (app)
                                            (lambda (env)
                                              (cond ((and (string= (getf env
                                                                         :path-info)
                                                                   "/")
                                                          (null (gethash :current-user
                                                                         (getf env
                                                                               :lack.session))))
                                                     `(200 (:content-type "text/plain")
                                                           ("I'm a static front page.")))
                                                    (t
                                                     (funcall app env)))))))
```
## Installation
### [Roswell](https://github.com/roswell/roswell)
```bash
$ ros install shakatoday/clog-lack-session
```
### local-project
```bash
$ cd PATH-TO-YOUR-QUICKLISP-LOCAL-PROJECT
$ git clone https://github.com/shakatoday/clog-lack-session.git
```
Then quicklisp can find it.
## Warning
It currently uses ```document.cookie``` API. You can't turn on ```HttpOnly``` for cookie.
I'll find another way so it won't call ```document.cookie``` in the future.
## Author

* Shaka Chen (scchen@shaka.today)

## Copyright

Copyright (c) 2022 Shaka Chen (scchen@shaka.today)

## License

Licensed under the BSD 3-Clause License.
