# Open your app to the world

APIs are ubiquitous. Every web service / web application provides a way to interact with the application. If you provide an API for your application, your users are free how to use your application: They can either use your web frontend or write a script to use on the commandline.

## Example application

In this talk, I provide a sample application where everyone can track his/her history of given talks. You can create an event you attended, and talks you've given at those events.

First of all we need a database. This is the schema of that database:

* TODO

In the directory [base_example](./base_example/) you'll find a version where no API is provided. It is a [Mojolicious::Lite](http://metacpan.org/pod/Mojolicious::Lite) application with a very simple web frontend. You can login into the web application, create the event and add your talks.

In [docs](./docs/), you'll find the SQL file to 

This example does not provide a routine to register yourself.


