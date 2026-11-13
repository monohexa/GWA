module Jekyll
    class CalculatorPage < Page
        def initialize(site, base, key, dataFile)
            @site = site
            @base = base
            slug = dataFile['slug'].to_s.strip
            slug = key if slug.empty?
            @dir = "grading/#{slug}"
            @name = "index.html"

            process(@name)
            read_yaml(File.join(base, "_layouts"), "calculator.html")

            data["grading"] = dataFile
            data["title"] = dataFile["title"] || key
        end
    end

    class ProductGenerator < Generator 
        safe true
        priority :highest

        def generate(site)
            (site.data["gradings"] || {}).each do |key, dataFile|
                site.pages << CalculatorPage.new(site, site.source, key, dataFile)
            end
        end
    end
end