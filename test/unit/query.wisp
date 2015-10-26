(ns query.test.unit.query
  "tests for query.query"
  (:require [query.test.setup :refer [setup-tests!]]
            [tape]
            [query.src.query :refer [$get]]))

(setup-tests!
"<html>
   <head><title>Hello, world!</title></head>
   <body>
     <h1>lol</h1>
     <custom>hello</custom>
     <section id=\"html5\">a section with id</section>
     <div class=\"hello-world\">test of classes</div>
     <div class=\"test1\">hello 1</div>
     <div class=\"test1\">hello 2</div>
     <div class=\"root\">
       <span class=\"nested\">Nested!</span>
     </div>
   </body>
 </html>")

(defmacro test
  [desc & body]
  `(tape ~desc (fn [t]
    (do
      (~@body t)
      (t.end)))))

; passing test with jsdom working
(test "$get can select single element by tag name"
  (fn [t]
    (do 
      (def $res ($get "h1"))
      (t.equal (:outerHTML $res) "<h1>lol</h1>"))))

(test "$get can select single element by class name"
  (fn [t]
    (t.equal 
      (:innerHTML ($get ".hello-world"))
      "test of classes")))

(test "$get can select multiple elements by class name"
  (fn [t] (do
    (t.equal
      (:length ($get ".test1"))
      2)
    (t.equal
      (:innerHTML (aget ($get ".test1") 0))
      "hello 1"))))

(test "$get can select single element by id"
  (fn [t] 
    (t.equal
      (:innerHTML ($get "#html5"))
      "a section with id")))
