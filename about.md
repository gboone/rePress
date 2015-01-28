---
layout: page
title: JekyllPress
permalink: /about/
---

WordPress will soon release a [REST API](http://wp-api.org/#rest-api_about) as a core feature. The code is currently available as [a plugin](https://github.com/WP-API/WP-API) so that WP contributors can iterate on it with real users without throwing it immediately into the codebase. (WordPress calls it a "Feature Plugin.") This is a Jekyll Plugin that will ingest data from a WordPress API and export Jekyll posts at the time the site is built. You can have the WordPress site running anywhere you want, even on a local web server. All you need to do is install the plugin, for now, and know where the API endpoint is (usually `wp-json`). 

The ultimate goal is a Jekyll installation where you can write posts in either the WordPress content editor or as Markdown files served on a Jekyll-built site.

## Configuration
1. Have a WordPress site with the REST API installed
2. Install Jekyll
2. Put the address for the root endpoint in `_config.yml` under the `wpApi` key
3. Build the site

## Support

The plugin currently supports ingesting posts and exporting the raw post content. And currently it's failing on anything beyond the first post for some strange reason. But, hey, we're just getting started! This is very much a work in progress and contributions are welcome.