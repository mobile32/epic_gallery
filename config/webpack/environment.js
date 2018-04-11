const { environment } = require('@rails/webpacker')

const webpack = require('webpack');
environment.plugins.append('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}));

environment.config.merge({
    resolve: {
        alias: {
            'jquery-ui': 'jquery-ui/ui',
        }
    }
});

module.exports = environment