const functions = require('firebase-functions');
const admin = require('firebase-admin');
const cors = require('cors')({ origin: true });
const fetch = require('node-fetch');

admin.initializeApp();

exports.corsProxy = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const url = req.query.url;
      if (!url) {
        res.status(400).send('URL is required');
        return;
      }

      const response = await fetch(url);
      const data = await response.buffer();

      res.set('Content-Type', response.headers.get('content-type'));
      res.send(data);
    } catch (error) {
      res.status(500).send(error.toString());
    }
  });
});
