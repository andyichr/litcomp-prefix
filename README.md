Synopsis
--------------------------------------------------------------------------------
The purpose of this package is to build out a complete prefix containing
all dependencies required to invoke the litcomp daemon.

Run Dependencies
--------------------------------------------------------------------------------
* build environment (enough to run configure/make)

For documentation:

* latex, dvi viewer

Litcomp Documentation
--------------------------------------------------------------------------------
An example command to generate and view the litcomp manual:

    ( cd litcomp/ && make docs; ) && xdvi -fullscreen -s 3 litcomp/docs/manual.dvi

Litcomp Invocation
--------------------------------------------------------------------------------
    make run
