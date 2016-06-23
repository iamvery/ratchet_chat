# Pakex

Building realtime functionality with server-rendered backend.

- encapsulate rendering pieces of the view
- encapsulate data lookup so it's repeatable

Problems with current design:

The "go render and notify" is invoked when messages are created.
A better way to think about/do this is to state at some point: render messages with this data and note that the data may change so be ready to do it again.
Then when messages are created: notify whoever cares that messages changed which would trigger the update.
This is roughly what Pakyow does.
