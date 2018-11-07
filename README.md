# rePress

WordPress will soon release a [REST API](http://wp-api.org/#rest-api_about) as a core feature. The code is currently available as [a plugin](https://github.com/WP-API/WP-API) so that WP contributors can iterate on it with users without throwing it immediately into the codebase. (WordPress calls it a "Feature Plugin.") Jekyll Plugin will ingest data from a WordPress API and export Jekyll posts when the site is built. With Jekyll Plugin, the WordPress site runs even on a local web server. 
What you need to do is:
-install the plugin.
-find a location of API endpoint (usually stored as 'wp-json').

The ultimate goal is a Jekyll installation where you can write posts in either the WordPress content editor or as Markdown files served on a Jekyll-built site.

## Configuration
1. Have a WordPress site with the REST API installed
2. Install Jekyll
2. Put the address for the root endpoint in `_config.yml` under the `wpApi` key
3. Build the site

## Support

The plugin now supports ingesting posts and exporting the raw post content. The plugin has some problems such as pipes showing up in strange places. Please aware that we are just started and the work is in progress. Feedback is welcome!
