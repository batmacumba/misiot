const express = require( 'express' );
const app = express();
app.use( express.json() );

app.get( '/', ( req, res ) => {
    console.log( 'received GET', req.body );
    res.sendStatus( 200 );
} );

app.post( '/', ( req, res ) => {
    console.log( 'received POST', req.body );
    res.sendStatus( 200 );
} );

<<<<<<< HEAD
app.listen( 8877, () => console.log( 'Node.js server started on port 8877.' ) );
=======
app.listen( 5000, () => console.log( 'Node.js server started on port 5000.' ) );
>>>>>>> 756c5d6dfa987e8f613f571086dc961c54eb8830
