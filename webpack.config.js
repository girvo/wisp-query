module.exports = {
    // Entry point
    entry: 'src/query.wisp',

    // JS output
    output: {
        path: __dirname,
        filename: 'bundle.js'
    },

    // Loaders
    loaders: [
        {
            test: /\.wisp$/,
            loader: 'wisp-loader'
        }
    ]      
};
