#!/bin/sh

If not archived then the archive API does this

e.g.

http://archive.org/wayback/available?url=https://royalsociety.org/people/steve-brown-11152

returns {"archived_snapshots":{}}

e.g.

http://archive.org/wayback/available?url=https://royalsociety.org/people/ewan-birney-11091

{"archived_snapshots":
  {"closest":
    { "available":true,
      "url":"http://web.archive.org/web/20151116210056/https://royalsociety.org/people/ewan-birney-11091
      timestamp":"20151116210056",
      "status":"200"}}}

#sleep 10
#wget https://web.archive.org/save/https://duncan.hull.name
#sleep 10
#wget https://web.archive.org/save/https://duncan.hull.name
#sleep 10
