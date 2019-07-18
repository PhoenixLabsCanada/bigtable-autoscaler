#!/bin/sh
curl --verbose \
      --data client_id=749603101123-boqotv7970v1vrbuvbjlepm5orkv42tq.apps.googleusercontent.com \
      --data client_secret=In35DpSjqEi4Bg5wyIBoSaR7 \
      --data code=4/hAGO-z6Pd5HYWR1LTAcCjkAwOHLnaW4YS0-moljGBMdLCR1EbR7eCuw \
      --data redirect_uri=urn:ietf:wg:oauth:2.0:oob \
      --data grant_type=authorization_code \
      https://www.googleapis.com/oauth2/v4/token
