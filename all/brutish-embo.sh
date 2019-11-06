#!/bin/sh
# Brute force archive EMBO, ignores 502 Bad Gateway response from server

sleep 3 && wget https://web.archive.org/save/http://people.embo.org/profile/celestina-mariani

sleep 3 && wget https://web.archive.org/save/http://people.embo.org/profile/maciej-zylicz
