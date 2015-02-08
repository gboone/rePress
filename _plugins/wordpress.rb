require 'fileutils'
require 'open-uri'
require 'json'
require 'wordpress-api'

module Jekyll
	class WpPost < Page
		def initialize(site, base)
			@site = site
			@base = base
		end
	end

	class WPGenerator < Generator
		safe true

		def generate(site)
			params = {"posts_per_page" => "-1"}
			wpposts = WordPress.get_posts(site.config['wpApi'], params)
			generatePosts(site, wpposts)
		end

		def update?(site, last_update, slug)
			post = site.posts.find {|p| p.slug == slug }
			if post.data.include?('modified')
				modified = Date.parse(post.data['modified'])
				if modified && modified == last_update
					false
				else
					true
				end
			else
				true
			end
		end

		def assembleFrontmatter(post, layouts)
			tags = []
			unless post['terms']['post_tag'].nil? 
				for t in post['terms']['post_tag'] 
					name = t['name'].strip
					tags.push(name)
				end
			end
			frontmatter = {}
			frontmatter[:title] = post['title']
			frontmatter[:author] = post['author']['username']
			frontmatter[:excerpt] = post['excerpt'].gsub(%r{</?[^>]+?>}, '').strip unless post['excerpt'].nil?
			frontmatter[:tags] = tags
			unless layouts.include?(post['format'])
				frontmatter[:layout] = 'post'
			else
				frontmatter[:layout] = post['format']
			end
			frontmatter[:modified] = post['modified']
			return frontmatter
		end
		
		def generatePosts(site, data)
			for d in data
				last_update = Date.parse(d['modified'])
				slug = d['slug']
				if update?(site, last_update, slug)
					puts("Building post #{d['title']}")
					post_date = Date.parse(d['date']).strftime("%Y-%m-%d")
					filename = "#{post_date}-#{d['slug']}.html"
					path = File.join(site.source, "_posts", filename)
					frontmatter = assembleFrontmatter(d, site.layouts)
					if d['content'].nil? 
						puts "No content for #{d['title']}"
					end
					content = Array.new(1) { d['content'].strip unless d['content'].nil? }

					front = YAML.load(frontmatter.to_json)
					front_yaml = YAML.dump(front)
					File.open(path, 'w') { |file| file.write("#{front_yaml}---\n #{content[0]}")}
					puts("Updated or created #{filename}")
				else
					puts "Post: #{d['title']} is up to date."
				end
			end
		end
	end
end
