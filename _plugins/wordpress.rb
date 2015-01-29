require 'fileutils'
require 'open-uri'
require 'json'

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
			wpposts = grabPosts(site)
			generatePosts(site, wpposts)
		end

		def grabPosts(site)
			index = WpPost.new(site, site.source)
			puts("WordPress API: #{site.config['wpApi']}")
			data = open(site.config['wpApi'] + "posts/")
			wpposts = JSON.load(data)
		end

		def generatePosts(site, data)
			for d in data
				puts("Building post #{d['title']}")
				post_date = Date.parse(d['date']).strftime("%Y-%m-%d")
				filename = "#{post_date}-#{d['slug']}.html"
				path = File.join(site.source, "_posts", filename)
				tags = []
				unless d['terms']['post_tag'].nil? 
					for t in d['terms']['post_tag'] 
						name = t['name'].strip
						tags.push(name)
					end
				end
				frontmatter = {}
				frontmatter[:title] = d['title']
				frontmatter[:author] = d['author']['username']
				frontmatter[:excerpt] = d['excerpt'].gsub(%r{</?[^>]+?>}, '').strip
				frontmatter[:tags] = tags
				frontmatter[:layout] = d['format']
				content = d['content'].strip

				front = YAML.load(frontmatter.to_json)
				front_yaml = YAML.dump(front)
				contents = YAML.load(content.to_json)
				contents_yaml = YAML.dump(contents)
				File.open(path, 'w') { |file| file.write(front_yaml + contents_yaml)}
				puts("Updated or created #{filename}")
			end
		end
	end
end
