Raspberry Pi Erlang Webserver
=====

Embedded Erlang webserver for reading values from a digital temperature sensor.

Build
-----

    $ make distclean
    
    $ make

To start the release in the foreground:

    $ ./_rel/webserver/bin/webserver console
    
Then point your browser at http://localhost:8080/sensors/temp