# Open your app to the world

APIs are ubiquitous. Every web service / web application provides a way to interact with the application. If you provide an API for your application, your users are free how to use your application: They can either use your web frontend or write a script to use on the commandline.

## Example application

In this talk, I provide a sample application where everyone can track their history of given talks. You can create an event you attended, and talks you've given at those events.

First of all we need a database. This is the schema of that database:

* TODO

In the directory [base_example](./base_example/) you'll find a version where no API is provided. It is a [Mojolicious::Lite](http://metacpan.org/pod/Mojolicious::Lite) application with a very simple web frontend. You can login into the web application, create the event and add your talks.

In [docs](./docs/), you'll find the SQL file to create the database.

With this application you can register yourself, and do all the basic stuff I mentioned before. To maintain the history of given talks, you have to open a browser, go to the application, login and enter the events and talks. This is fine. But wouldn't it be better if you could to the same on the command line? Wouldn't it be nice if the conference website had a button to send all the data to the application? This is hard with just the web interface.

You can write wrappers that sends the same requests as the browser. But this is not the best way. The URLs might change or the form fields are renamed. The web interface could have some captchas. Hence the application needs something better - an API.

Now you have to decide what the API looks like. It should provide an API for all the things you could do on the web interface.

Many years ago SOAP was the way to go. And there were other types of API, too. But nowadays (nearly) everyone provides a REST-API. And even more recently GraphQL is hyped. So what should we choose?

## REST

REST is the abbreviation for *REpresentational State Transfer*. This term was introduced in 2000 by Roy Fielding in his dissertation.

REST describes a set architectural principles that can be used to design webservices. It focuses on how a resource is addressed an how the state of a resource can be changed. Roy fielding defined six principles for REST.

### six principles of REST

#### Client-server architecture

The first principle of REST is easy. Every webpage uses a client-server architecture: The browser is the client and the webpage is on the server.

This won't change when we change our application.

#### Statelessness

#### Cacheability

The server should add information to the response if it is cacheable or not. And the client should cache cacheable responses to avoid superfluous requests. That leads to scaleable web applications.

#### Layered system

#### Code on demand (optional)

#### Uniform interface

### RESTful vs RESTish

#### Richardson Maturity Model

#### HATEOAS

##### JSON:API

### OData

### Swagger

#### Tools

#### Mojolicious

### The application

Now we want to update our application. We want to make it accessible for various clients. Currently we only support software that can display a HTML page. We want to open the application to the world. Other applications should be able to access the information

But we 

## GraphQL

## REST vs. GraphQL

## Moving the application forward
