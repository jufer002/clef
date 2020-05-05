module TagsHelper
    # Get n most recent courses.
    def get_tags()
        Tag.all()
    end

    def get_important_tags(n)
        tags = get_n_tags(n)
        #want to have it so easy, intermediate, and hard are at top
    end

    def get_n_tags(n)
        tag_list = []
        tags = {}
        Tag.all.each do |tag|
            tags[tag] = tag.lessons.size + tag.courses.size
            puts tags[tag]
        end
        tags = Hash[tags.sort_by {|k,v| -v}]
        tags = tags.first(n)
        tags.each {|key| tag_list.append key[0]}
        tag_list
    end

end
