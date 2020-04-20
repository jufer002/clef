module TagsHelper
    # Get n most recent courses.
    def get_tags()
        Tag.all()
    end
end
