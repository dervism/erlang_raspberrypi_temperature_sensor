Raspberry Pi Erlang Webserver
=====

Embedded Erlang webserver for reading values from a digital temperature sensor.

Prerequisites
-----

You must download and install [Erlang](https://www.erlang-solutions.com/home.html) in order to build and run this project.

For Raspberry Pi, you can download Erlang Mini (without gui packages) which is good for small embedded devices. Go to the [download page]((https://www.erlang-solutions.com/resources/download.html)), select "Raspbian" and follow the installation instructions.

If you want to program the GPIOs on embedded devices directly, you will also need the [Erlang ALE modules](https://github.com/esl/erlang_ale).

Build
-----

    $ make distclean
    
    $ make

To start the release in the foreground:

    $ ./_rel/webserver/bin/webserver console
    
Then point your browser at http://localhost:8080/sensors/temp
