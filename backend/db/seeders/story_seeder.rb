module Seeders
  class StorySeeder
    def initialize(desired_story_count=10)
      @desired_story_count = desired_story_count
    end

    def seed!
      @desired_story_count.times do
        create_story!
      end
    end

    private

    def create_story!
      ActiveRecord::Base.transaction do
        story = Story.new(
          title: Faker::Hacker.say_something_smart,
          body: Faker::Lorem.paragraphs(rand(1..5)).join("\n"),
        )
        story.save!
        puts "Created story ##{story.id}!"
      end
    end

  end
end
