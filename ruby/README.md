# Game Of Life - Ruby
Attempt at building a pure OOP solution.

## Goals
Colony and cells don't care about the space they are inhabiting.
Cells care only about their neighbours and rules for living or dying.
Colony is concerned only about populating the given space and evolving its members.

The idea is that a colony could be inhabiting a 2D or 3D space, or even some other constructs.
Colony and its members should be given the inhabiting rules tu abide by.

## Notes
Command line presentation of the colony accepts width and height as arguments.
[OptionParser](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/optparse/rdoc/OptionParser.html) is used for argument parsing.
Clear screen method is using rbconfig, as noted [here](http://www.ruby-forum.com/topic/86488).
